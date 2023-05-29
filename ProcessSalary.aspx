<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ProcessSalary.aspx.cs" Inherits="ProcessSalary" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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


            const monthNames = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
            ];

            const d = new Date();
            // Check_AttebdanceGenerated
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/WebService.asmx/AccountCheck_SalaryGenerated',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    if (data[0].response == '1' || data[0].response == 1) {
                        $("#div2").show();
                        $("#div1").hide();
                        var a = " " + monthNames[d.getMonth()] + " month Salary has not been generated.";
                        $("#MyText").html(a);
                    } else if (data[0].response == '2' || data[0].response == 2) {
                        $("#div2").show();
                        $("#div1").hide();
                        $("#MyText").html("  " + monthNames[d.getMonth()] + " month Salary has not been approved");
                    }
                    else {
                        $("#div2").hide();
                        $("#div1").show();
                        GetSalary();
                    }
                }

            })

        });
        ///////

        function GetSalary() {
            $("#BanlSlipTable").empty();
            $.ajax({
                type: "POST",
                url: "ProcessSalary.aspx/ShowSalaryhistory",
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


        }
        //////////

        function BankSlipToExcel(tableID, filename) {
            filename = 'ExcelSlip';
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

    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Process Salary</h3>
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


    <div id="div2">

        <div class="card flex-fill">
            <div class="card-header" style="text-align: center; color: red;">
                <h1 id="MyText"></h1>
            </div>
        </div>
    </div>
    <div id="div1">
        
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

