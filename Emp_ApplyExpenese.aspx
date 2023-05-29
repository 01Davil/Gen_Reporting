<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="Emp_ApplyExpenese.aspx.cs" Inherits="Emp_ApplyExpenese" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".my").hide();
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }
            // Get Apply EXpenese TableTbody
            $(function () {
                 var formData = new FormData();
                        formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                        $.ajax({
                            url: 'WebServerFile/Employee_MasterService.asmx/TypeofExpenese',
                            type: 'POST',
                            data: formData,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (data) {
                                for (var i = 0; i < data.length; i++) {
                                    var s = " <option>" + data[i].Type + "</option>";
                                    $("#Exp_Type").append(s);
                                }
                            },
                            xhr: function () {
                                var fileXhr = $.ajaxSettings.xhr();
                                if (fileXhr.upload) {
                                  
                                }
                                return fileXhr;
                            }
                        });
                //
                GetApplyExpenese("Processing");

            });
            //
            
            ///
            //
            $('.numberonly').keypress(function (e) {

                var charCode = (e.which) ? e.which : event.keyCode

                if (String.fromCharCode(charCode).match(/[^0-9]/g)) {

                    Swal.fire('Please Enter Number');

                    return false;
                }

            });
            //
            $("#BtnSave").click(function (e) {
                e.preventDefault();

                if ($(this).text() == 'Save') {
                    
                    var TypeExp = $("#Exp_Type option:selected").val();
                    if (TypeExp == "Select") {
                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "Please Select a valid option ",
                            timer: 3000
                        });
                    } else if (TypeExp=="Other") {
                        TypeExp = $("#Type_Exp").val().trim();
                        
                    } else {
                        TypeExp = TypeExp;
                    }
                    
                 var Amount = $("#Amount").val();
                var Purpose = $("#Purpose").val();
                var file = $('#SlipFile')[0].files.length;
                if (Amount.length == 0 || Amount == ' ' || Purpose.length == 0 || Purpose == '' || TypeExp.length == 0 || TypeExp == " ") {
                    Swal.fire('please fill all required fields');
                } else {
                    if (file == 0) {
                        Swal.fire('Please Select File');
                    } else {
                        var formData = new FormData();
                        formData.append("Slip", $("#SlipFile")[0].files[0]);
                        formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                        formData.append("Ampunt", Amount);
                        formData.append("Purpose", Purpose);
                        formData.append("TypeExp", TypeExp);
                        $.ajax({
                            url: 'WebServerFile/Employee_MasterService.asmx/SaveExpenese',
                            type: 'POST',
                            data: formData,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (Result) {
                                if (Result == 'Save') {
                                    Swal.fire({
                                        icon: 'success',
                                        width: '300px',
                                        text: "Expenese Apply success",
                                        timer: 3000
                                    });
                                    GetApplyExpenese("Processing");
                                    $("#Amount").val("");
                                    $("#Purpose").val("");
                                    $("#SlipFile").val("");
                                    setTimeout(function () {
                                        location.reload();
                                    },1000);
                                } else {
                                    Swal.fire({
                                        icon: 'info',
                                        width: '300px',
                                        text: "Expenese Not Apply success",
                                        timer: 3000
                                    });
                                }
                            },
                            xhr: function () {
                                var fileXhr = $.ajaxSettings.xhr();
                                if (fileXhr.upload) {
                                  
                                }
                                return fileXhr;
                            }
                        });
                    }
                }
                    // Save
                } else {
                    var Amount= $("#Amount").val();
                    var Purpose = $("#Purpose").val();

                    if (Amount != '' || Purpose != '') {

                        if ($('#SlipFile')[0].files.length == 0) {
                            var formData = new FormData();
                            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                            formData.append("Ampunt", $("#Amount").val());
                            formData.append("Purpose", $("#Purpose").val());
                            formData.append("Id", $("#Mid").val());
                            $.ajax({
                                url: 'WebServerFile/Employee_MasterService.asmx/UpdateExpeneseSP',
                                type: 'POST',
                                data: formData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (Result) {
                                    if (Result == 'Save') {
                                        Swal.fire({
                                            icon: 'success',
                                            width: '300px',
                                            text: "Expenese Update Success",
                                            timer: 3000
                                        });
                                        $("#Amount").val("");
                                        $("#Purpose").val("");
                                        $("#SlipFile").val("");
                                        GetApplyExpenese("Processing");
                                        setTimeout(function () {
                                            location.reload();
                                        }, 1000);
                                    } else {
                                        Swal.fire({
                                            icon: 'info',
                                            width: '300px',
                                            text: "Expenese Not Update ",
                                            timer: 3000
                                        });
                                    }
                                },
                                xhr: function () {
                                    var fileXhr = $.ajaxSettings.xhr();
                                    if (fileXhr.upload) {

                                    }
                                    return fileXhr;
                                }
                            });

                        } else {
                            var formData = new FormData();
                            formData.append("Slip", $("#SlipFile")[0].files[0]);
                            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                            formData.append("Ampunt", $("#Amount").val());
                            formData.append("Purpose", $("#Purpose").val());
                            formData.append("Id", $("#Mid").val());
                            $.ajax({
                                url: 'WebServerFile/Employee_MasterService.asmx/UpdateExpenese',
                                type: 'POST',
                                data: formData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (Result) {
                                    if (Result == 'Save') {
                                        Swal.fire({
                                            icon: 'success',
                                            width: '300px',
                                            text: "Expenese  Update Success ",
                                            timer: 3000
                                        });
                                        // 
                                        $("#Amount").val("");
                                        $("#Purpose").val("");
                                        $("#SlipFile").val("");
                                        GetApplyExpenese("Processing");
                                    } else {
                                        Swal.fire({
                                            icon: 'info',
                                            width: '300px',
                                            text: "Expenese  Not Update  ",
                                            timer: 3000
                                        });
                                    }
                                },
                                xhr: function () {
                                    var fileXhr = $.ajaxSettings.xhr();
                                    if (fileXhr.upload) {

                                    }
                                    return fileXhr;
                                }
                            });
                        }
                    } else {
                        Swal.fire('Please Select File');

                    }
                }

            });
        });

        //
        //get GetApplyExpenese
        function GetApplyExpenese(Type) {
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
             formData.append("Type", Type);
             $.ajax({
                 url: 'WebServerFile/Employee_MasterService.asmx/GetApplyExpeneseSP',
                 type: 'POST',
                 data: formData,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (data) {
                     if (data[0].response == "Fail") {
                         Swal.fire({
                             icon: 'info',
                             title: 'info',
                             width: '300px',
                             text: 'Data Not Found.!',
                             timer: 1500
                         })
                     } else {
                         $("#TableTbody").empty();
                         var j = 1;
                         for (var i = 0; i < data.length; i++) {

                             if (data[i].ApprovedStatus == 'Processing') {

                                 jQuery('<tr><td style=" display :none;"> ' + data[i].URL + '</td> <td style=" display :none;"> ' + data[i].id + '</td> <td>' + j + '</td><td>' + data[i].Amount + '</td><td>' + data[i].Purpose + '</td> <td>' + data[i].ApprovedStatus + '</td> <td>' + data[i].ApprovedName + '</td> <td>' + data[i].PaymentStatus + '</td>'
                                 + '<td><a  data-bs-toggle="tooltip" id="Edit"' + j + ' onclick="EditFun(' + j + ')" data-bs-placement="top" title="" data-bs-original-title="Edit"><i class="fa fa-edit"></i></a> &nbsp; &nbsp;'
                                + '<a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp;'
                                + ' <a  id="Delete"' + j + ' onclick="DeleteFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Delete"><i class="fa fa-trash-alt"></i></a> </td>     </tr>').appendTo("#TableTbody");

                             } else {

                                 jQuery('<tr><td style=" display :none;"> ' + data[i].URL + '</td> <td style=" display :none;"> ' + data[i].id + '</td> <td>' + j + '</td><td>' + data[i].Amount + '</td><td>' + data[i].Purpose + '</td> <td>' + data[i].ApprovedStatus + '</td> <td>' + data[i].ApprovedName + '</td> <td>' + data[i].PaymentStatus + '</td>'
                                + ' <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    </td>     </tr>').appendTo("#TableTbody");
                                 
                             }
                             j++;
                             // end for loop
                         }
                     }
                 }
             });
        }
        function DowFun(j) {
            var x = document.getElementById("datatables-dashboard-projects").rows[j].cells.item(0).innerText;
            $.ajax({
                url: x,
                method: 'GET',
                xhrFields: {
                    responseType: 'blob'
                },
                success: function (data) {
                    var a = document.createElement('a');
                    var url = window.URL.createObjectURL(data);
                    a.href = url;
                    a.download = 'myfile.pdf';
                    document.body.append(a);
                    a.click();
                    a.remove();
                    window.URL.revokeObjectURL(url);
                }
                // calling download function
            })
        }
        function EditFun( j) {
            var id = document.getElementById("datatables-dashboard-projects").rows[j].cells.item(1).innerText;
            var Amount = document.getElementById("datatables-dashboard-projects").rows[j].cells.item(3).innerText;
            var Purpose = document.getElementById("datatables-dashboard-projects").rows[j].cells.item(4).innerText;
           $("#Amount").val(Amount);
           $("#Purpose").val(Purpose);
           $("#BtnSave").text("Update");
           $("#Mid").val(id);
        }
        function DeleteFun(j) {
           // formData
                      var formData = new FormData();
                        formData.append("id", document.getElementById("datatables-dashboard-projects").rows[j].cells.item(1).innerText);
                        $.ajax({
                            url: 'WebServerFile/Employee_MasterService.asmx/DeleteExpenese',
                            type: 'POST',
                            data: formData,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (Result) {
                                if (Result == 'Save') {
                                    Swal.fire({
                                        icon: 'success',
                                        width: '300px',
                                        text: "Expenese  Delete Success ",
                                        timer: 3000
                                    });
                                    GetApplyExpenese("Processing");
                                } else {
                                    Swal.fire({
                                        icon: 'info',
                                        width: '300px',
                                        text: "Expenese  Delete Success ",
                                        timer: 3000
                                    });
                                }
                            },
                            xhr: function () {
                                var fileXhr = $.ajaxSettings.xhr();
                                if (fileXhr.upload) {
                                  
                                }
                                return fileXhr;
                            }
                        })
            
        }
        function DropFun() {
            var b = $(".s").find(":selected").val();
            if (b == 0 || b == '0') {
                Swal.fire({
                    icon: 'info',
                    width: '300px',
                    text: "Please Select a valid option ",
                    timer: 3000
                });
            } else {
                GetApplyExpenese(b);
            }
        }

        //

        function Fun_Other() {
            var Type = $("#Exp_Type option:selected").val();
            if (Type == "Select") {
                Swal.fire({
                    icon: 'info',
                    width: '300px',
                    text: "Please Select a valid option ",
                    timer: 3000
                });
            } else {
                if (Type == "Other") {
                    $(".My").show();
                } else {
                    $(".My").hide();
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="text" style="display:none"  id="Mid"/>
    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Employee Expenses</h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
        </div>
    </div>


    <div class="row">

        <div class="col-12 col-lg-12 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <h5 class="card-title mb-0">New Expense</h5>
                </div>
                <div class="card-body">

                    <div class="row mt-4">
                        <div class="col-md-3">
                            <label class="form-label">Type of Expenses </label>
                            <select class="form-control numberonly" onchange="Fun_Other()" id="Exp_Type">
                            </select>
                        </div>
                        <div class="col-md-3 my" >
                            <label class="form-label">Enter Expenese Type </label>
                            <input type="text" class="form-control" id="Type_Exp">
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Amount</label>
                            <input type="text" class="form-control numberonly" id="Amount">
                        </div>


                        <div class="col-md-3">
                            <label class="form-label">Purpose</label>
                            <input type="text" class="form-control" id="Purpose">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Attach Slip</label>
                            <input type="file" id="SlipFile" class="form-control" />
                        </div>

                    </div>

                    <div class="row mt-4">

                        <div class="col-md-12 ">

                            <button id="BtnSave" type="submit" class="btn btn-primary float-end "><i class="fa fa-save"></i>Save</button>
                        </div>

                    </div>


                </div>
            </div>
        </div>

    </div>

    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Summery</h5>

            <div class="input-group input-group-sm" style="width: 200px; float: right;">
                <select class="form-select s" style="border-radius: 4px;" onchange="DropFun()" >
                    <option value="0">Select Expenese</option>
                    <option value="Processing">Panding</option>
                    <option value="Reject">Reject</option>
                    <option value="Approved">Approved</option>
                </select>
            </div>
        </div>
        <table id="datatables-dashboard-projects" class="table table-striped my-0">
            <thead>
                <tr>
                    <th>S.No.</th>
                    <th class="d-none d-xl-table-cell">Amount</th>
                    <th class="d-none d-xl-table-cell">Purpose</th>
                    <th class="d-none d-md-table-cell">Approved Status</th>
                    <th class="d-none d-md-table-cell">Approved By</th>
                    <th class="d-none d-md-table-cell">Payment Status</th>
                        <th class="d-none d-md-table-cell">Option</th>
                </tr>
            </thead>
            <tbody id="TableTbody">

            </tbody>
        </table>
    </div>
</asp:Content>

