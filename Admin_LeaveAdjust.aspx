<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_LeaveAdjust.aspx.cs" Inherits="Admin_LeaveAdjust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(function(){
                GetEmployeeLeave('NA');
            });

            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }
            ///
            $("#SearchText").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/Employee_MasterService.asmx/GetNameList',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        var ddlCustomers = $("[id*=select2]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {
                            ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                        });

                    }

                });
            });

            $('#SearchText').on('change', function () {
                var Name = $("#SearchText").val();
                    GetEmployeeLeave( Name);
               });
        });

            // end main


            ////
        //    $(function () {
        //        $.ajax({
        //            type: "POST",
        //            url: "MasterPage.aspx/GetYear",
        //            data: '{ }',
        //            contentType: "application/json; charset=utf-8",
        //            dataType: "json",
        //            success: function (r) {
        //                xmlDoc = r.d;
        //                var ddlCustomers = $("[id*=YearDrop]");
        //                ddlCustomers.empty().append('<option selected="selected" value="0">Select Year</option>');
        //                for (var i = 0; i <= xmlDoc.length - 1; i++) {
        //                    ddlCustomers.append($("<option></option>").val(xmlDoc[i].MonthNo).html(xmlDoc[i].MonthName));
        //                }

        //            }
        //        });
        //    });
   

        //    // end doc
        //});
        //function GetMonthByYear() {

        //    var ddlCustomers = $("[id*=MonthDrop]");
        //    ddlCustomers.empty();
        //    var YearNo = $("#YearDrop option:selected").text();
        //    $.ajax({
        //        type: "POST",
        //        url: "MasterPage.aspx/GetMonthWithYear",
        //        data: '{ YearNo :  "' + YearNo + '"}',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (r) {
        //            xmlDoc = r.d;
        //            var ddlCustomers = $("[id*=MonthDrop]");
        //            ddlCustomers.empty().append('<option selected="selected" value="0">Select Month</option>');
        //            for (var i = 0; i <= xmlDoc.length - 1; i++) {
        //                ddlCustomers.append($("<option></option>").val(xmlDoc[i].MonthNo).html(xmlDoc[i].MonthName));
        //            }

        //        }
        //    });
        //}

        //function GetDetailsMonthBy() {
        //    var MonthNo = $("#MonthDrop option:selected").val();
        //    var YearNo = $("#YearDrop option:selected").text();
        //    if(MonthNo == "select Month" || MonthNo==0 || YearNo=="select Year"){
        //        Swal.fire({
        //            icon: 'info',
        //            //title: 'info',
        //            width: '300px',
        //            text: "Please select Year & Month",
        //            timer: 3000
        //        });
        //    }else{
        //        GetEmployeeLeave(YearNo, MonthNo, 'NA');
        //    }
        //   // 
        //}

        ///

        function GetEmployeeLeave(EmailID) {

            var formData = new FormData();
            formData.append("EmailID", EmailID);
            $.ajax({
                url: 'WebServerFile/AdminWebService.asmx/ShowAdjustLeaveDay',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $("#ShowTableWork").empty();
                    var j = 1;
                    if (data[0].response == 'Fail') {

                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "No details found.",
                            timer: 3000
                        });
                    } else {
                        if (data[0].key == '1' || data[0].key == 1) {
                            // show
                            // ShowTableWork
                            jQuery(' <thead><tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">Total Present </th><th class="d-none d-xl-table-cell">Total Absent </th> <th class="d-none d-xl-table-cell"> Adjust Day</th><th class="d-none d-xl-table-cell">Enter Adjust Day No</th><th class="d-none d-xl-table-cell">Save</th></tr></thead>').appendTo("#ShowTableWork");
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {

                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TotalPresent + '</td> <td>' + data[i].TotalAbsent + '</td><td>' + data[i].AdjustDay + '</td> <td> <input  type="text"/></td>   <td><span class="badge bg-warning">Save</span></td>    </tr>')
                                j++;
                            }
                        }
                        else {
                            // hide
                            //alert("Not ");
                            jQuery(' <thead><tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">Total Present </th><th class="d-none d-xl-table-cell">Total Absent </th>  <th class="d-none d-xl-table-cell"> EL</th> <th class="d-none d-xl-table-cell"> SL </th>  <th class="d-none d-xl-table-cell"> CL</th> <th class="d-none d-xl-table-cell"> EM</th> <th class="d-none d-xl-table-cell"> W.F.H </th><th class="d-none d-xl-table-cell"> Adjust Day</th> <th class="d-none d-xl-table-cell"> Enter Adjust Day</th> <th class="d-none d-xl-table-cell"> Save </th> </tr></thead>').appendTo("#ShowTableWork");
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                                //$("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TotalPresent + '</td> <td>' + data[i].TotalAbsent + '</td><td>' + data[i].AdjustDay + '</td>  </tr>')
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TotalPresent + '</td> <td>' + data[i].TotalAbsent + '</td><td>' + data[i].EL + '</td> <td>' + data[i].SL + '</td> <td>' + data[i].CL + '</td>  <td>' + data[i].EM + '</td> <td>' + data[i].WFH + '</td> <td>' + data[i].AdjustDay + '</td> <td> <div class="input-group input-group-sm m-lg-1" style="width: 200px; "> <input type="text" id=' + j + ' class="text-center form-control "  placeholder ="Enter Day Number " style="border-radius: 4px;"/></div> </td >     <td> <a  class="btn btn-success btn-sm"  id="update"' + j + ' onclick="AddPDayEmployee(' + data[i].SNo + ', ' + j + ') " > <i class="bi bi-save"></i>Save </a>  </td>   </tr>');

                                j++
                            }
                        }
                    }
                }
            });
        }
        // 

        function AddPDayEmployee(Sno, j) {
            var i = "#" + j;
            var dayNo = $(i).val();
            if (dayNo.length == 0 || dayNo == "") {
                Swal.fire({
                    icon: 'info',
                    width: '300px',
                    text: "Please Enter Day Number",
                    timer: 3000
                });
            } else {
                if ($.isNumeric(dayNo)) {
                    var formData = new FormData();
                    formData.append("LoginSno", "<%= Session["LoginSno"].ToString()%>");
                    formData.append("EmpSno", Sno);
                    formData.append("DayNo", dayNo);
                    $.ajax({
                        url: 'WebServerFile/AdminWebService.asmx/SaveAdjustLeaveDay',
                        type: 'POST',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            var j = 1;
                            if (data[0].response == 'Fail') {
                                Swal.fire({
                                    icon: 'info',
                                    width: '300px',
                                    text: "Leave  Not  adjusted."
                                });
                            } else if (data[0].response == 'success') {
                                Swal.fire({
                                    icon: 'success',
                                    width: '300px',
                                    text: "Leave success adjust"
                                });
                                GetEmployeeLeave('NA');
                            } else {
                                Swal.fire({
                                    icon: 'warning',
                                    width: '300px',
                                    text: "Adjust Day's to Current Day's"
                                });
                                GetEmployeeLeave('NA');

                            }

                        }
                    });

                } else {
                    Swal.fire({
                        icon: 'info',
                        width: '300px',
                        text: "Please enter a valid number.",
                        timer: 3000
                    });
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Leave Adjust </h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
        </div>
    </div>

    <div class="card flex-fill">
        <div class="card-header">
                 <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: left;">
                <h5>Leave Adjust</h5>
            </div>


                    <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                     <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>
 
<%--            <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                <select id="MonthDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                </select>
            </div>
                            <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                <select id="YearDrop" class="form-select" style="border-radius: 4px;" onchange="GetMonthByYear()">
                </select>
            </div>--%>
        </div>
               <table id="ShowTableWork" class="table table-striped my-0">
   
        </table>
    </div>
</asp:Content>
