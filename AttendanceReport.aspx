<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="AttendanceReport.aspx.cs" Inherits="AttendanceReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <script src="JsDB/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //$(function(){
            //    GetEmployeeLeave(0,0,'NA');
            //});
            var input = document.getElementById('SearchText');
            input.addEventListener('keydown', function (event) {
                const key = event.key;
                if (key === "Backspace") {
                    if ($("#SearchText").length > 0) {
                        var MonthNo = $("#MonthDrop option:selected").val();
                        var YearNo = $("#YearDrop option:selected").text();

                        GetEmployeeLeave(YearNo, MonthNo, "NA");
                    }
                }
            });



            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                         var now = today.toLocaleString().toUpperCase();
                $(".cv").text(now);

            }
            ///
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
                        var ddlCustomers = $("[id*=select2]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {
                            ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                        });

                    }

                });
            });

            $('#SearchText').on('change', function () {
                var MonthNo = $("#MonthDrop option:selected").val();
                var YearNo = $("#YearDrop option:selected").text();
                var Name = $("#SearchText").val();
                if (YearNo == "Select Year" || MonthNo == undefined) {
                    Swal.fire({
                        icon: 'info',
                        width: '300px',
                        text: "pleace select Year & Month.",
                        timer: 3000
                    });
                } else {
                    if (Name != " " || Name.length != 0) {
                        GetEmployeeLeave(YearNo, MonthNo, Name);
                    }
                }
            });

            // end main


            ////
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
   

            // end doc
        });
        function GetMonthByYear() {

            var ddlCustomers = $("[id*=MonthDrop]");
            ddlCustomers.empty();
            var YearNo = $("#YearDrop option:selected").text();
            $.ajax({
                type: "POST",
                url: "MasterPage.aspx/GetMonthWithYear",
                data: '{ YearNo :  "' + YearNo + '"}',
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

        function GetDetailsMonthBy() {
            var MonthNo = $("#MonthDrop option:selected").val();
            var YearNo = $("#YearDrop option:selected").text();
            if(MonthNo == "select Month" || MonthNo==0 || YearNo=="select Year"){
                Swal.fire({
                    icon: 'info',
                    //title: 'info',
                    width: '300px',
                    text: "Please select Year & Month",
                    timer: 3000
                });
            }else{
                GetEmployeeLeave(YearNo, MonthNo, 'NA');
            }
           // 
        }

        ///

        function GetEmployeeLeave(Year, Month, EmailID) {
            $(".loaderbg").show();
            var formData = new FormData();
            formData.append("Year", Year);
            formData.append("Month", Month);
            formData.append("EmailID", EmailID);
            $.ajax({
                url: 'WebServerFile/AdminWebService.asmx/GetLeaveReport',
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
                        $(".loaderbg").hide();
                    } else {
                        for (var i = 0; i < data.length; i++) {

                            $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TotalPresent + '</td> <td>' + data[i].TotalAbsent + '</td><td>' + data[i].EL + '</td> <td>' + data[i].SL + '</td> <td>' + data[i].CL + '</td>  <td>' + data[i].EM + '</td> <td>' + data[i].WFH + '</td>  </tr>');

                            j++;
                        }
                        $(".loaderbg").hide();
                    }
                }
            });
          

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>ATTENDANCE REPORT</h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
            
                <button class="btn btn-primary shadow-sm">
                    <i class="align-middle" data-feather="refresh-cw">&nbsp;</i>
                </button>
        </div>
    </div>

    <div class="card flex-fill">
        <div class="card-header">
                 <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: left;">
                <h5>Leave Report</h5>
            </div>


                    <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                     <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>
 
            <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                <select id="MonthDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                </select>
            </div>
                            <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                <select id="YearDrop" class="form-select" style="border-radius: 4px;" onchange="GetMonthByYear()">
                </select>
            </div>
        </div>
               <table id="datatables-dashboard-projects" class="table table-striped my-0">
    <thead>
                <tr>
                    <th>S.No.</th>
                    <th class="d-none d-xl-table-cell">Employee Name</th>
                    <th class="d-none d-xl-table-cell">Total Present </th>
                    <th class="d-none d-xl-table-cell">Total Absent </th>
                    <th class="d-none d-xl-table-cell">CL</th>
                    <th class="d-none d-xl-table-cell">EL</th>
                    <th class="d-none d-xl-table-cell">SL</th>
                    <th class="d-none d-xl-table-cell">EM</th>
                    <th class="d-none d-xl-table-cell">WFH</th>
                </tr>
            </thead>
            <tbody id="ShowTableWork"></tbody>
        </table>
    </div>
</asp:Content>