<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="AddAttendance.aspx.cs" Inherits="AddAttendance" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
       <script src="JsDB/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }
            //$(function () {
            //    GetAttendacne(0, 0, "NA");
            //})
            var input = document.getElementById('SearchText2');
            input.addEventListener('keydown', function (event) {
                const key = event.key;
                if (key === "Backspace") {
                    if ($("#SearchText2").legth > 0) {
                        GetAttendacne(0, 0, "NA");
                    }
                }
            });

            $(function () {
                $.ajax({
                    type: "POST",
                    url: "MasterPage.aspx/GetYear",
                    data: '{ }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;
                        var ddlCustomers = $("[id*=YearDrop]");
                        ddlCustomers.empty().append('<option selected="selected" value="0">Select Year</option>');
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].MonthNo).html(xmlDoc[i].MonthName));
                        }

                    }
                });
            });

            // Get Employee Name List
            /// Search Employee Name List
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
            /// Search Employee Name List & Search Table
            $("#SearchText2").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText2").val());
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/Get_EmployeOfficeEmailList',
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
            // 
            $('#SearchText2').on('change', function () {
                var Name = $("#SearchText2").val();
                var MonthNo = $("#MonthDrop option:selected").val(); // YearNo
                var YearNo = $("#YearDrop option:selected").text(); // 
                if (MonthNo == undefined || MonthNo == "undefined" || YearNo == " " || YearNo == "Select Year") {
                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: 'Please select Year & Month'
                    });
                } else {
                    if (Name == "" || Name.length == 0) {
                        GetAttendacne(0, 0, "NA");
                    } else {
                        GetAttendacne(YearNo, MonthNo, Name);
                    }
                }

            });

            // Save Attendance
            $("#BtnSave").click(function (e) {
                e.preventDefault();
                var Name = $("#SearchText").val().trim();
                var Date = $("#AttDate").val();
                var Purpose = $("#Purpose").val();
                if (Name == ' ' || Date == "" || Purpose == "") {
                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: 'Enter All information.!'
                    });
                } else {
                    var formData = new FormData();
                    formData.append("EmpEmail", Name);
                    formData.append("Date", Date);
                    formData.append("Purpose", Purpose);
                    formData.append("ApplySno", "<%= Session["LoginSno"].ToString()%>");
                    $.ajax({
                        url: 'WebServerFile/WebService.asmx/SaveAttendance',
                        type: 'POST',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            if (data == "Save") {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'success',
                                    width: '300px',
                                    text: 'Employee Attendance Save Successful.!'
                                });
                                GetAttendacne(0, 0, "NA");
                                $("#SearchText").val("");
                                $("#AttDate").val("");
                                $("#Purpose").val("");
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'error',
                                    width: '300px',
                                    text: 'Employee Attendance Not Save Successful.'
                                })
                            }
                        }
                        // end ajax

                    });
                }
            });


            /// Main ENd
        });
        //
        function GetMonthBy() {
            var YearNo = $("#YearDrop option:selected").text();
            $.ajax({
                type: "POST",
                url: "MasterPage.aspx/GetMonthWithYear",
                data: '{YearNo : "' + YearNo + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    xmlDoc = r.d;
                    var ddlCustomers = $("[id*=MonthDrop]");
                    ddlCustomers.empty().append('<option selected="selected" value="0">Select Month</option>');
                    for (var i = 0; i <= xmlDoc.length - 1; i++) {
                        ddlCustomers.append($("<option></option>").val(xmlDoc[i].MonthNo).html(xmlDoc[i].MonthName));
                    }

                }
            });
        }
        // get Attendance Emplpyee 
        function GetAttendacne(YearNo, MonthNo, EmpName) {
            var formData = new FormData();
            formData.append("YearNo", YearNo);
            formData.append("MonthNo", MonthNo);
            formData.append("EmpName", EmpName);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/GetAttendanceManuall',
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
                        $("#TableTbody").empty();
                    } else {
                        $("#TableTbody").empty();
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                            jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].AttendanceDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].Purpose + '</td>   </tr>').appendTo("#TableTbody");
                            j++;
                        }
                    }
                }
            });
        }

        // function 
        function CheckDate() {
            const d1 = new Date();
            var D1 = d1.getMonth();

            var d2 = new Date($("#AttDate").val());
            var D2 = d2.getMonth();
            if (D1 != D2) {
                Swal.fire({
                    icon: 'info',
                    title: 'info',
                    width: '300px',
                    text: 'Pleace Enter Current Month Date!'
                });
            }
        }

        // get employee month by
        function GetDetailsMonthBy() {
            var Name = $("#SearchText2").val();
            var MonthNo = $("#MonthDrop option:selected").val();
            var YearNo = $("#YearDrop option:selected").text();

            if (Name == ' ' || Name.length == 0) {
                GetAttendacne(YearNo, MonthNo, "NA");
            } else {
                GetAttendacne(YearNo, MonthNo, Name);
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid p-0">

        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>ADD Attendance</h3>
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
                        <br />
                    </div>
                    <div class="card-body">

                        <div class="row mt-4">

                            <div class="col-md-3">
                                <label class="form-label">Employee Name</label>
                                <input list="select" id="SearchText" class="form-control" placeholder="Enter Employee Name" name="select" />
                                <datalist class="MeClass" id="select">
                                </datalist>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Attendance Date</label>
                                <input type="text" class="form-control" id="AttDate" />

                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Attendance Purpose</label>
                                <input type="text" class="form-control" id="Purpose">
                            </div>
                            <div class="col-md-2 pt-4">
                                <button class="btn btn-primary float-end w-100 mt-1" id="BtnSave" type="submit"><i class="fa fa-plus"></i>Add </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>




        <div class="card flex-fill">
            <div class="card-header">
                <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Attendance Results</h5>
                <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                    <input list="select2" id="SearchText2" class="form-control" placeholder="Enter Employee Name" name="select" />
                    <datalist class="MeClass" id="select2">
                    </datalist>
                </div>

                <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                    <select id="MonthDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                    </select>
                </div>
                <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                    <select id="YearDrop" class="form-select" style="border-radius: 4px;" onchange="GetMonthBy()">
                    </select>

                </div>

            </div>
            <table id="datatables-dashboard-projects" class="table table-striped my-0">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th class="d-none d-xl-table-cell">Employee Code</th>
                        <th class="d-none d-xl-table-cell">Attendance Date</th>
                        <th class="d-none d-xl-table-cell">Purpose</th>
                    </tr>
                </thead>
                <tbody id="TableTbody">
                    <%--<tr>
                        <td>01</td>
                        <td class="d-none d-xl-table-cell">GEN/4521561/044</td>
                        <td class="d-none d-xl-table-cell">1/11/2022</td>
                        <td class="d-none d-md-table-cell">Thumb machine not working properly</td>
                    </tr>--%>
                </tbody>
            </table>
        </div>


    </div>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.2.js"></script>
<script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            //$("#AttDate").daterangepicker({
            //        minDate: new Date()
            //    //startDate: new Date()
            //});
            var date = new Date();
            var currentMonth = date.getMonth();
            var currentDate = date.getDate();
            var currentYear = date.getFullYear();
            $('#AttDate').datepicker({
                minDate: new Date(currentYear, currentMonth, currentDate)
            });
        });
    </script>

</asp:Content>
