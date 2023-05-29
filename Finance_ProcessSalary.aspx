<%@ Page Title="" Language="C#" MasterPageFile="~/Finance_MasterPage.master" AutoEventWireup="true" CodeFile="Finance_ProcessSalary.aspx.cs" Inherits="Finance_ProcessSalary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ApprovedSalary").click(function () {
                $.ajax({
                    type: "POST",
                    url: "Finance_ProcessSalary.aspx/ApprovedSalary",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert(response.d);
                        if (response.d == "Done") {
                            Swal.fire({
                                icon: 'success',
                                title: 'success',
                                width: '300px',
                                text: '  Salary Verify !'
                            })
                      
                        } else {
                            Swal.fire({
                                icon: 'success',
                                title: 'success',
                                width: '300px',
                                text: '  Salary Not Verify !'
                            })
                        }
                    },
                    error: function (data) {
                        Swal.fire({
                            icon: 'success',
                            title: 'success',
                            width: '300px',
                            text: '  Salary Not  Verify !'
                        })
                    }
                });
                setTimeout(function () {
                    location.reload();
                }, 3000);
            });

            $(function () {
                $("#BanlSlipTable").empty();
                $.ajax({
                    type: "POST",
                    url: "Finance_ProcessSalary.aspx/ShowSalaryhistory",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        xmlDoc = response.d;
                        $("#BanlSlipTable").append("<thead class='thead-dark text-center'  style='position: sticky; top: -10px; margin-top:-12px !important; z-index: 2;' >" +
                            " <th>Sno</th> <th>EmpCode</th> <th>Name</th>  "
                          + " <th> Present Day (PaidDays)</th> <th> Absent Day</th> "
                           + " <th>Basic</th> <th>HRA</th> <th>Conveyance</th>  <th>Allowance</th>  <th>ArrearAllowance</th>  <th>BonusAllowance</th> <th>OtherAllowance</th>  <th>ExtraAllowance</th> <th>MediAllowance</th> <th>SpecialAllowance</th>     <th>Bonus</th>  <th>DA</th> <th>TA</th>     <th>TotalGross</th> <th>TDS</th> <th>OtherAdvanceDeduction</th>   <th>ESIC_E</th> <th>PF_E</th> <th>ESC_ER</th><th>PF_ER</th>  <th>Total Deduction</th>  <th>NetPay</th>  <th>CTC</th>   <th>ESIC No</th>   "
                         + "    </thead>");
                        var j = 1;
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            jQuery('<tr> <td>' + j + '</td> <td>' + xmlDoc[i].EmpCode + '</td> <td>' + xmlDoc[i].EmpName + '</td> '
                                + ' <td>' + xmlDoc[i].PDay + '</td>    <td>' + xmlDoc[i].ADay + '</td>  '

                               + ' <td>' + xmlDoc[i].Basic + '</td>   <td>' + xmlDoc[i].HRA + '</td>  <td>' + xmlDoc[i].Conveyance + '</td> <td>' + xmlDoc[i].Allowance + '</td> <td>' + xmlDoc[i].ArrearAllowance + '</td> <td>' + xmlDoc[i].BonusAllowance + '</td> <td>' + xmlDoc[i].Others + '</td> <td>' + xmlDoc[i].ExtraAllowance + '</td> <td>' + xmlDoc[i].MediAllowance + '</td> <td>' + xmlDoc[i].SpecialAllowance + '</td>     <td>' + xmlDoc[i].Bonus + '</td><td>' + xmlDoc[i].DA + '</td>      <td>' + xmlDoc[i].TA + '</td>   <td>' + xmlDoc[i].TotalGross + '</td>  <td>' + xmlDoc[i].TDS + '</td> <td>' + xmlDoc[i].OtherAdvanceDeduction + '</td>      <td>' + xmlDoc[i].ESIC_E + '</td>  <td>' + xmlDoc[i].EPF_E + '</td>  <td>' + xmlDoc[i].EPF_ER + '</td>      <td>  ' + xmlDoc[i].ESIC_ER + '</td>   <td>  ' + xmlDoc[i].Deducted + '</td>  <td>  ' + xmlDoc[i].NetSalary + '</td>  <td>  ' + xmlDoc[i].CTC + '</td>   <td>' + xmlDoc[i].ESICNO + '</td> '
                               + '  <td>     </tr>').appendTo("#BanlSlipTable");

                            j++;

                        }
                    },
                    error: function (data) {
                        $("#BanlSlipTable").hide();
                    }
                });


            });
        });
        function BankSlipToExcel(tableID, filename = 'ExcelSlip') 
            {
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Process Salary</h5>
             
                    <div class="input-group input-group-sm" style="width: 200px; float: right;">
                    <a href="#" class="btn btn-primary float-end " onclick="BankSlipToExcel('BanlSlipTable', 'user-data')"><i class="fa fa-file-excel"></i>Download  Excel </a>

                </div>
        </div>
        <div style="overflow-x: auto; height: auto; text-align: center; margin-top: -20px;">

            <table id="BanlSlipTable" class="table table-striped my-0">
            </table>

        </div>
    </div>
    <div class="row mb-2" style="s">

        <div class="col-lg-3">
            <div class="form-group">
                <button class="btn btn-warning form-control" type="submit" id="ApprovedSalary">Verify salary</button>
            </div>
        </div>
    </div>

</asp:Content>

