<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ChangeRoleID.aspx.cs" Inherits="ChangeRoleID" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="JsDB/jquery.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString().toUpperCase();
                $(".cv").text(now);

            }

            //  GetDetails("NA");

            $("#btnSearch").click(function () {
                var Name = $("#SearchText").val();

                if (Name.length == 0 || Name == "") {
                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: "Please Enter Employee Name !",
                        timer: 3000
                    });
                } else {
                    GetDetails(Name);
                }

            })


            $("#SearchText").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/Get_EmployeOfficeEmailList',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        var ddlCustomers = $("[id*=select]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {
                            ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                        });

                    }

                });
            });


        });

        function GetDetails(Email) {

            var formData = new FormData();
            formData.append("Email", Email);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/GetAssignRole',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    if (data[0].response == 'Fail') {

                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "No details found."

                        });
                        $("#TableTbody").empty();
                    } else {
                        $("#TableTbody").empty();
                        jQuery('<thead> <tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell"> Department </th><th class="d-none d-xl-table-cell">JobProfile </th><th class="d-none d-md-table-cell">Permission (View / Edit )</th>  </tr>  </thead> ').appendTo("#TableTbody");

                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                            $("#TableTbody").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].Department + '</td> <td>' + data[i].JobProfile + '</td>'
                                     + '<td><a  data-bs-toggle="tooltip" id="Edit"' + j + ' onclick="ShowPermissionList( )" data-bs-placement="top" title="" data-bs-original-title="Edit"><i class="fa fa-edit"></i></a> &nbsp; &nbsp;'
                               + ' </tr> </tbody> ');

                            j++;
                        }
                    }

                }

            });
        }
        function ShowPermissionList() {

            $(".loaderbg").show();
            var formData = new FormData();
            formData.append("Email", $("#SearchText").val());
            $.ajax({
                url: 'WebServerFile/WebService.asmx/ShowPermission',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    if (data[0].response == 'Fail') {

                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "No details found."

                        });
                        $("#tabtbody1").empty();
                        $("#tabtbody2").empty();
                    } else {
                        $("#tabtbody1").empty();
                        $("#tabtbody2").empty();
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {

                            if (data[i].FileName == "PayRoll System" && data[i].Type == "1") {
                                GetPayRollSystemPermission(data[i].Pageid);
                            
                            } else {
                                $("#RayDiv").hide();
                            }
                            if (data[i].Type == "1") {

                                $("#tabtbody1").append(' <tr> <td>' + data[i].FileName + '</td>  <td> <input type="checkbox"  id="' + j + 'A" onchange ="ChangeRole(' + data[i].id + ', ' + j + ' , ' + 1 + ')" checked  /> </td> <tr> ');
                                
                            } else {
                                $("#tabtbody2").append(' <tr> <td>' + data[i].FileName + '</td>  <td> <input  type="checkbox"  id="' + j + 'B" onchange ="ChangeRole(' + data[i].id + ', ' + j + ', ' + 2 + ')"  /> </td> <tr> ');
                                
                            }
                   
                            j++;
                        }
                        $("#defaultModalPrimary").modal('show');
                        $(".loaderbg").hide();
                    }

                }

            });

        }

        function GetPayRollSystemPermission(Pageid) {
            
            var formData = new FormData();
            formData.append("Email", $("#SearchText").val());
            formData.append("Pageid", Pageid);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/ShowSubPermission',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    if (data[0].response == 'Fail') {

                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "No details found."

                        });
                        $("#tabtbody3").empty();
                    } else {
                        $("#tabtbody3").empty();
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {

                           
                            if (data[i].Type == "1") {

                                $("#tabtbody3").append(' <tr> <td>' + data[i].FileName + '</td>  <td> <input type="checkbox"  id="' + j + 'C" onchange ="SubChangeRole(' + data[i].id + ', ' + j + ' , ' + 1 + ')" checked  /> </td> <tr> ');
                                
                            } else {
                                $("#tabtbody3").append(' <tr> <td>' + data[i].FileName + '</td>  <td> <input  type="checkbox"  id="' + j + 'D" onchange ="SubChangeRole(' + data[i].id + ', ' + j + ', ' + 2 + ')"  /> </td> <tr> ');
                                
                            }

                            j++;
                        }
                        $("#RayDiv").show();
                    }

                }

            });
        }

        //
        function SubChangeRole(Updateid, id, type) {

            //$(".loaderbg").show();
            //alert(Updateid + " " + id + " " + type);

            var q = "";
            if (type == "1" || type == 1) {
                q = "C";
            } else {
                q = "D";

            }
            var my = id + q;
            var val = "";
            //var checked = $("input["+ my +"]:checked").length;
            var checkbox1 = document.getElementById(my);
            if (checkbox1.checked) {
                val = 1;

            }
            else {
                val = 0;
            }
            debugger;
            var formData = new FormData();
            formData.append("Updateid", Updateid);
            formData.append("val", val);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/SubUpdatePermission',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    //if (val == 0) {
                    //    Swal.fire({
                    //        icon: 'success',
                    //        width: '300px',
                    //        text: "Permission Denied Successfully.",
                    //        timer: 2000
                    //    });
                    //} else {
                    //    Swal.fire({
                    //        icon: 'success',
                    //        width: '300px',
                    //        text: "Permission Allowed Successfully.",
                    //        timer: 2000
                    //    });
                    //}
                    $(".loaderbg").hide();
                }
            });
        }

        //
        function ChangeRole(Updateid, id, type) {
            $(".loaderbg").show();
            //alert(id + " " + type)
            var q = "";
            if (type == "1" || type == 1) {
                q = "A";
            } else {
                q = "B";

            }
            var my = id + q;
            var val = "";
            //var checked = $("input["+ my +"]:checked").length;
            var checkbox1 = document.getElementById(my);
            if (checkbox1.checked) {
                val = 1;

            }
            else
            {
                val = 0;
            }
            
            var formData = new FormData();
            formData.append("Updateid",Updateid);
            formData.append("val", val);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/UpdatePermission',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    //if (val == 0) {
                    //    Swal.fire({
                    //        icon: 'success',
                    //        width: '300px',
                    //        text: "Permission Denied Successfully.",
                    //        timer: 2000
                    //    });
                    //} else {
                    //    Swal.fire({
                    //        icon: 'success',
                    //        width: '300px',
                    //        text: "Permission Allowed Successfully.",
                    //            timer: 2000
                    //    });
                    //}
                    ShowPermissionList();
                    $(".loaderbg").hide();
                }
            });
        }

        // 
        // 
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-0">
        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>Assign Role</h3>
            </div>
            <div class="col-auto ms-auto text-end mt-n1">
                <div class=" me-2 d-inline-block">
                    <span class="btn btn-light bg-white shadow-sm "><i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong> </span>
                </div>
            </div>
        </div>

        <%-- ************************************************************************************** --%>
        <div class="row">
            <div class="col-12 col-lg-12 d-flex">
                <div class="card flex-fill w-100">
                    <div class="card-header">
                        <br />
                    </div>
                    <div class="card-body">
                        <div class="row mt-4">

                            <div class="col-md-3">

                                <input list="select" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                                <datalist class="MeClass" id="select">
                                </datalist>
                            </div>

                            <div class="col-md-1">
                            </div>

                            <div class="col-md-1">
                            </div>

                            <div class="col-md-3">
                                <button type="button" id="btnSearch" class="btn btn-primary">Search </button>
                            </div>



                        </div>
                    </div>
                </div>
            </div>

        </div>



        <%-- ************************************************************************************** --%>

        <div class="row">
            <div class="col-12 col-lg-12 d-flex">
                <div class="card flex-fill w-100">
                    <div class="card-header">
                        <br />
                    </div>
                    <div class="card-body">
                        <table class="table table-striped mt-0 text-center" id="TableTbody">
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <%-- ************************************************************************************** --%>

    <%-- ************************************************************************************** --%>
    <div class="modal fade" id="defaultModalPrimary" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Default modal</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="card-body">
                    <div class="row mt-4">

                        <div class="col-md-4 text-center">
                            <h3>Permission  Allowed</h3>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Page Name</th>
                                        <th scope="col">Permission </th>

                                    </tr>
                                </thead>
                                <tbody id="tabtbody1">
                                  
                                </tbody>
                            </table>

                        </div>

                        <div class="col-md-4 text-center">
                                <h3>Permission  Denyed </h3>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Page Name</th>
                                        <th scope="col">Permission</th>

                                    </tr>
                                </thead>
                                <tbody id="tabtbody2">
                               
                                </tbody>
                            </table>
                        </div>

                            <div class="col-md-4 text-center" id="RayDiv" style="display:none;">
                            <h3>PayRoll System Permission Allowed / Denyed </h3>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Page Name</th>
                                        <th scope="col">Permission </th>

                                    </tr>
                                </thead>
                                <tbody id="tabtbody3">
                                  
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                 
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        $(function () {
            var dateToday = new Date();
            var dates = $("#from, #to").daterangepicker({
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 3,
                minDate: dateToday,
                onSelect: function (selectedDate) {
                    var option = this.id == "from" ? "minDate" : "maxDate",
                        instance = $(this).data("daterangepicker"),
                        date = $.daterangepicker.parseDate(instance.settings.dateFormat || $.daterangepicker._defaults.dateFormat, selectedDate, instance.settings);
                    dates.not(this).daterangepicker("option", option, date);
                }
            });
        })


    </script>
</asp:Content>


