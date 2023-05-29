<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="SalaryHistory.aspx.cs" Inherits="SalaryHistory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
       <script src="JsDB/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString().toUpperCase();;
                $(".cv").text(now);

            }

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

            $("#SearchText").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/Webservice.asmx/Get_EmployeOfficeEmailList',
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

            //$('#SearchText').on('change', function () {
            //    var MonthNo = $("#MonthDrop option:selected").val();
            //    var YearNo = $("#YearDrop option:selected").text();
            //    var Name = $("#SearchText").val();
            //    if (YearNo == "Select Year" || MonthNo == undefined) {
            //        Swal.fire({
            //            icon: 'info',
            //            width: '300px',
            //            text: "pleace select Year & Month.",
            //            timer: 3000
            //        });
            //    } else {
            //        GetEmployeeLeave(YearNo, MonthNo, Name);
            //    }
            //});
            // end document
        });
        //onchange year 
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

        // get all data 
        function GetDetailsMonthBy() {
            //debugger
            var MonthNo = $("#MonthDrop option:selected").val();
            var YearNo = $("#YearDrop option:selected").text();
            if (MonthNo == "select Month" || MonthNo == 0 || YearNo == "select Year") {
                Swal.fire({
                    icon: 'info',
                    //title: 'info',
                    width: '300px',
                    text: "Please select Year & Month",
                    timer: 3000
                });
            } else {
                GetEmployeeLeave(YearNo, MonthNo, 'NA');
            }
            // 
        }

        // 
        function GetEmployeeLeave(Year, Month, EmailID) {
            $("#BanlSlipTable").empty();
            var obj = {
                YearNo: Year,
                MonthNo: Month,
                EmailId: EmailID
            }
            $.ajax({
                type: "POST",
                url: "SalaryHistory.aspx/ShowSalaryhistory",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    xmlDoc = response.d;
                    if (xmlDoc.length > 0) {
                        $("#BanlSlipTable").append("<thead class='thead-dark text-center'  style='position: sticky; top: -10px; margin-top:-12px !important; z-index: 2;' >" +
                            " <th>Sno</th> <th>EmpCode</th> <th>Name</th>   <th> Present Day (PaidDays)</th> <th> Absent Day</th>  <th>Year-Month</th> "
                          //  + " <th>Rate_Basic</th> <th>Rate_HRA</th>  <th>Rate_Conveyance</th> <th>Rate_Allowance</th> <th>Rate_ArrearAllowance</th> <th>Rate_BonusAllowance</th> <th>Rate_OtherAllowance</th> <th>Rate_ExtraAllowance</th>  <th>Rate_MediAllowance</th> <th>Rate_SpecialAllowance</th>     <th>Rate_Bonus</th>    <th>Rate_DA</th>  <th>Rate_TA</th> <th>TotalGross</th> "
                           + " <th>Basic</th> <th>HRA</th> <th>Conveyance</th>  <th>Allowance</th>  <th>ArrearAllowance</th>  <th>BonusAllowance</th> <th>OtherAllowance</th>  <th>ExtraAllowance</th> <th>MediAllowance</th> <th>SpecialAllowance</th>     <th>Bonus</th>  <th>DA</th> <th>TA</th>     <th>TotalGross</th> <th>TDS</th> <th>OtherAdvanceDeduction</th>   <th>ESIC_E</th> <th>PF_E</th> <th>ESC_ER</th><th>PF_ER</th>  <th>Total Deduction</th>  <th>NetPay</th>  <th>CTC</th>   <th>ESIC No</th>   </thead>");
                        //  + "  <th>Acc_Holder_Name</th> <th>Bank_Name </th>  <th>Branch_Name </th>   <th>IFSC_Code</th> <th>AccountNo</th>   
                        var j = 1;
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            jQuery(' <tbody> <tr class="p-2 m-4"> <td>' + j + '</td> <td>' + xmlDoc[i].EmpCode + '</td> <td>' + xmlDoc[i].EmpName + '</td>  <td>' + xmlDoc[i].PDay + '</td>    <td>' + xmlDoc[i].ADay + '</td>   <td>' + Year + "-" + Month + '</td> '
                              //  + ' <td>' + xmlDoc[i].Rate_Basic + '</td><td>' + xmlDoc[i].Rate_HRA + '</td>      <td>' + xmlDoc[i].Rate_Conveyance + '</td>   <td>' + xmlDoc[i].Rate_Allowance + '</td> <td>' + xmlDoc[i].Rate_ArrearAllowance + '</td> <td>' + xmlDoc[i].Rate_BonusAllowance + '</td> <td>' + xmlDoc[i].Rate_OtherAllowance + '</td> <td>' + xmlDoc[i].Rate_ExtraAllowance + '</td> <td>' + xmlDoc[i].Rate_MediAllowance + '</td> <td>' + xmlDoc[i].Rate_SpecialAllowance + '</td>    <td>' + xmlDoc[i].Rate_Bonus + '</td>  <td>' + xmlDoc[i].Rate_DA + '</td>  <td>' + xmlDoc[i].Rate_TA + '</td>  <td>' + xmlDoc[i].Rate_TotalGross + '</td>    '

                               + ' <td>' + xmlDoc[i].Basic + '</td>   <td>' + xmlDoc[i].HRA + '</td>  <td>' + xmlDoc[i].Conveyance + '</td> <td>' + xmlDoc[i].Allowance + '</td> <td>' + xmlDoc[i].ArrearAllowance + '</td> <td>' + xmlDoc[i].BonusAllowance + '</td> <td>' + xmlDoc[i].Others + '</td> <td>' + xmlDoc[i].ExtraAllowance + '</td> <td>' + xmlDoc[i].MediAllowance + '</td> <td>' + xmlDoc[i].SpecialAllowance + '</td>     <td>' + xmlDoc[i].Bonus + '</td><td>' + xmlDoc[i].DA + '</td>      <td>' + xmlDoc[i].TA + '</td>   <td>' + xmlDoc[i].TotalGross + '</td>  <td>' + xmlDoc[i].TDS + '</td> <td>' + xmlDoc[i].OtherAdvanceDeduction + '</td>      <td>' + xmlDoc[i].ESIC_E + '</td>  <td>' + xmlDoc[i].EPF_E + '</td>  <td>' + xmlDoc[i].EPF_ER + '</td>      <td>  ' + xmlDoc[i].ESIC_ER + '</td>   <td>  ' + xmlDoc[i].Deducted + '</td>  <td>  ' + xmlDoc[i].NetSalary + '</td>  <td>  ' + xmlDoc[i].CTC + '</td>   <td>' + xmlDoc[i].ESICNO + '</td> </tr>  </tbody>').appendTo("#BanlSlipTable");
                              //  + ' <td>' + xmlDoc[i].AccHolderName + '</td>   <td>' + xmlDoc[i].BName + '</td>   <td>' + xmlDoc[i].BRName + '</td>    <td>' + xmlDoc[i].IFSCCode + '</td>   <td>' + xmlDoc[i].AccountNo + '</td>      

                            j++;

                        }
                    } else {
                        Swal.fire({
                            icon: 'info',
                            title: 'info',
                             width: '300px',
                            text: "No Details Found"
                        });
                        $("#BanlSlipTable").empty();
                    }
                },
                error: function (data) {

                }
            });

        }
        function BankSlipToExcel(tableID, filename) {
            filename = "ExcelSlip";
            var downloadurl;
            var dataFileType = 'application/vnd.ms-excel';
            var tableSelect = document.getElementById(tableID);
            var tableHTMLData = tableSelect.outerHTML.replace(/ /g, '%20');
            // Specify file name
            filename = filename ? filename + '.xls' : 'export_excel_data.xls';

            // Create download link element
            downloadurl = document.createElement("a");

            document.body.appendChild(downloadurl);

            if (navigator.msSaveOrOpenBlob) {
                var blob = new Blob(['\ufeff', tableHTMLData], {
                    type: dataFileType
                });
                navigator.msSaveOrOpenBlob(blob, filename);
            } else {
                // Create a link to the file
                downloadurl.href = 'data:' + dataFileType + ', ' + tableHTMLData;

                downloadurl.download = filename;

                downloadurl.click();

            }

        }

        function SearchBtn() {
            var MonthNo = $("#MonthDrop option:selected").val();
            var YearNo = $("#YearDrop option:selected").text();
            var Name = $("#SearchText").val();
            if (YearNo == "Select Year" || MonthNo == undefined) {
                Swal.fire({
                    icon: 'info',
                    width: '300px',
                    text: "Please Select Year and Month !",
                    timer: 3000
                });
            } else {
                if (Name == " " || Name.length == 0) {
                    GetEmployeeLeave(YearNo, MonthNo, "NA");
                } else {
                    GetEmployeeLeave(YearNo, MonthNo, Name);
                }
            }
        }
    </script>

    <style type="text/css">
        .g {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid p-0">

        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>HISTORY SALARY</h3>
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
                <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Salary Slip Search</h5>
            </div>

            <div class="card-body">

                <div class="row mt-4">
                    <div class="col-md-3">
                        <select id="YearDrop" class="form-select mb-3" style="border-radius: 4px;" onchange="GetMonthByYear()"></select>
                    </div>
                    <div class="col-md-3">
                        <select id="MonthDrop" class="form-select mb-3" style="border-radius: 4px;" onchange="GetDetailsMonthBy()"></select>
                    </div>
                    <div class="col-md-3">
                        <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                        <datalist class="MeClass" id="select2">
                        </datalist>
                    </div>
                    
                    <div class="col-md-3">
                        <a href="#" class="btn btn-primary float-center" onclick="SearchBtn()"><i class="fa fa-file-excel"></i>  Search... </a>

                    </div>

                </div>
            </div>
        </div>
        <div class="card flex-fill">
            <div class="card-header">
            <a href="#" class="btn btn-primary float-end " onclick="BankSlipToExcel('BanlSlipTable', 'user-data')"><i class="fa fa-file-excel"></i>  Excel </a>

            </div>
            <div style="width: auto; height: auto; overflow-x: auto; overflow-y: auto;">
                <table id="BanlSlipTable" class="table table-striped my-0 " style="text-align:center;">
                    </table>
            </div>
        </div>
    </div>

</asp:Content>
