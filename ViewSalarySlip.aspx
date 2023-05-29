<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewSalarySlip.aspx.cs" Inherits="ViewSalarySlip" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Salary Slip</title>
         <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
      <link rel="shortcut icon" href="img/Gen.png" />
    <link href="css/light.css" rel="stylesheet" />
    <style>
            body{
                padding: 0;
                margin: 0;
                background-color: #efefef;
                font-family: 'Poppins', sans-serif !important;
                font-size: 12px;
            }
            td{
                padding-left: 2px;
                padding-right: 2px;
                box-sizing: border-box;
            }
            .main{
                width:  650pt;
                height: 740pt;
                background-color: #fff;
                color: #222;
                margin-left: auto;
                margin-right: auto;
                position: relative;
                box-sizing: border-box;
                padding: 20px;
            }
            .header{
                width: auto;
                height: 34pt;
                line-height: 34pt;
                text-align: center;
            }
            .ht{
                width: 277pt;
                border: 1px solid #333;
                margin: 0;
                padding: 0;
            }
            .ht td, th{
                border-bottom: 1px solid #333 !important;

            }
            
            .br{
                border-right: 1px solid #333;
            }
            .tc{
                text-align: center;
            }
            .tr{
                text-align: right;
            }
            .tl{
                text-align: left;
            }

        </style>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="JsDB/jquery.js"></script>
 <script src="PdfJS/html2canvas.min.js"></script>
<script src="PdfJS/html2pdf.min.js"></script>
<script src="PdfJS/jquery.min.js"></script>
<script src="PdfJS/jspdf.debug.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            setTimeout(function () {

                    $.ajax({
                        type: "POST",
                        url: "ViewSalarySlip.aspx/GetDetails",
                        data: '{ }',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            xmlDoc = r.d;
                            if (xmlDoc.length > 0) {
                                $("#d1").text("PAYROLL SLIP FOR THE MONTH OF  " + " : " + xmlDoc[0].SalaryDate);
                                $("#d2").text("PAYROLL DETAILS " + " : " + xmlDoc[0].SalaryDate);
                                $("#DUE").text(xmlDoc[0].SalaryDate);
                                $("#empid").text(xmlDoc[0].Code);
                                $("#empName").text(xmlDoc[0].Name);
                                $("#Designation").text(xmlDoc[0].Designation);
                                $("#DOJ").text(xmlDoc[0].DOJ);
                                $("#Department").text(xmlDoc[0].Department);
                                $("#BankAccount").text(xmlDoc[0].AccountNo);
                                $("#bankName").text(xmlDoc[0].BankName);
                                $("#Pan").text(xmlDoc[0].PanNo);
                                $("#BasicDA").text(xmlDoc[0].BasicDA);
                                $("#Conveyance").text(xmlDoc[0].Conveyance);
                                $("#SpecialAllowance").text(xmlDoc[0].SpecialAllowance);
                                $("#OtherAllowance").text(xmlDoc[0].OtherAllowance);
                                $("#GrossPay1").text(xmlDoc[0].GrossPay);
                                $("#GrossPay2").text(xmlDoc[0].GrossPay);
                                $("#PDay").text(xmlDoc[0].PDay);
                                $("#Net1").text("Payment Details : Transfer through Bank by NEFT of Rs  " + "    " + xmlDoc[0].NetSalary);
                                $("#Net2").text(xmlDoc[0].NetSalary);
                                $("#ESI").text(xmlDoc[0].ESI);
                                $("#EPF").text(xmlDoc[0].EPF);
                                $("#TDS").text(xmlDoc[0].TDS);
                                $("#OtherAdvanceDeduction").text(xmlDoc[0].OtherAdvanceDeduction);
                                $("#Deducted").text(xmlDoc[0].Deducted);
                                ///

                            } else {
                                alert("Date Not Found :");
        
                            }
                        }
                    });
            }, 1000);

            });

    </script>

    </head>
    <body>
            <div class="card flex-fill">
        <div class="card-header">
     
         <button class="btn btn-sm btn-primary float-end 0" id="generatePDF" type="submit"><i class="fa fa-print"></i> Print </button>

        </div>

    </div>
          <div class="main" id="pdfdiv">
        <div class="header">
             <img src="img/logoNew.png" style="width: 100px;">

        </div>
        <table style="width: 555pt; border: 1px solid #333;" cellpadding="0" cellspacing="0">
            <thead>
                <tr>
                    <th id="d1" colspan="2" style="text-align: center; height: 20pt; background-color: #e4e2fe;"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <table class="ht" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>Employee ID</td>
                                <td>:</td>
                                <td id="empid">0</td>
                            </tr>
                            <tr>
                                <td>Name of Employee</td>
                                <td>:</td>
                                <td id="empName">Abhishek Sharma</td>
                            </tr>
                            <tr>
                                <td>Designation</td>
                                <td>:</td>
                                <td id="Designation">Dot Net </td>
                            </tr>
                            <tr>
                                <td>Date of Joining</td>
                                <td>:</td>
                                <td id="DOJ">22/04/2017</td>
                            </tr>
                            <tr>
                                <td>Department</td>
                                <td>:</td>
                                <td id="Department">Software</td>
                            </tr>
                            <tr>
                                <td>Bank Account No.</td>
                                <td>:</td>
                                <td id="BankAccount">ICI02158855156</td>
                            </tr>
                            <tr>
                                <td>Bank Name &amp; Branch</td>
                                <td>:</td>
                                <td id="bankName">ICICI Bank Noida</td>
                            </tr>
                        </table>

                    </td>
                    <td>
                        <table class="ht" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>Work Station</td>
                                <td>:</td>
                                <td>Nangal Raya, New Delhi</td>
                            </tr>
                            <tr>
                                <td>PAN No. of Employee</td>
                                <td>:</td>
                                <td id="Pan">0</td>
                            </tr>
                            <tr>
                                <td>Due Date</td>
                                <td>:</td>
                                <td id="DUE">0 </td>
                            </tr>
                            <tr>
                                <td>&nbsp; </td>
                                <td></td>
                                <td>&nbsp; </td>
                            </tr>
                            <tr>
                                <td>&nbsp; </td>
                                <td></td>
                                <td>&nbsp; </td>
                            </tr>
                            <tr>
                                <td>&nbsp; </td>
                                <td></td>
                                <td>&nbsp; </td>
                            </tr>
                            <tr>
                                <td>&nbsp; </td>
                                <td></td>
                                <td>&nbsp; </td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </tbody>
        </table>

        <table style="width: 555pt; margin-top: 20pt;" cellpadding="0" cellspacing="0">
            <thead>
                <tr>
                    <th  id="d2"colspan="3" style="text-align: center; height: 20pt; border: 1px solid #333; background-color: #e4e2fe;"></th>
                </tr>
                <tr>
                    <td colspan="3">&nbsp; </td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <table class="ht" style="width: 260pt; float: left; border: 1px solid #333;" cellpadding="0" cellspacing="0">
                            <tr>
                                <th colspan="2">Working Days Payable</th>
                            </tr>
                            <tr>
                                <td class="br">Gross Days Payable</td>
                                <td id="GrossPay1">0</td>
                            </tr>
                            <tr>
                                <td class="br">Leave Deductions (in days)</td>
                                <td>0</td>
                            </tr>
                            <tr>
                                <td class="br">Net Days Payable</td>
                                <td id="PDay">0</td>
                            </tr>
                        </table>
                        <table style="width: 260pt; float: left;" cellpadding="0" cellspacing="0">

                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                        <table class="ht" style="width: 260pt; float: left; border: 1px solid #333;" cellpadding="0" cellspacing="0">
                            <tr>
                                <th class="tl br">EARNINGS</th>
                                <th class="br">GROSS RATE</th>
                                <th class="tr">AMOUNT</th>
                            </tr>

                            <tr>
                                <td class="br">Basic+DA</td>
                                <td class="br"></td>
                                <td class="tr" id="BasicDA">0</td>
                            </tr>
                            <tr>
                                <td class="br">House Rent Allowance</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Conveyance Allowance</td>
                                <td class="br"></td>
                                <td class="tr" id="Conveyance">0</td>
                            </tr>
                            <tr>
                                <td class="br">Other Allowance</td>
                                <td class="br"></td>
                                <td class="tr" id="OtherAllowance">0</td>
                            </tr>
                            <tr>
                                <td class="br">Other Deductions Mediclaim policy</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Medical Reimbursements</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Children Education Allowance</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Hostel Allowance</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Leave Travel Allowance</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Special Allowance</td>
                                <td class="br"></td>
                                <td class="tr" id="SpecialAllowance">0</td>
                            </tr>
                            <tr>
                                <td class="br">Miscellaneous Allowance</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Bonus/Incentives/Otheres</td>
                                <td class="br"></td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td>&nbsp; </td>
                                <td></td>
                                <td>&nbsp; </td>
                            </tr>
                            <tr>
                                <td class="br"><strong>GROSS RERNINGS (A)</strong></td>
                                <td class="br"></td>
                                <td class="tr" id="GrossPay2"><strong>0</strong></td>
                            </tr>
                            <tr>
                                <td>&nbsp; </td>
                                <td></td>
                                <td>&nbsp; </td>
                            </tr>
                            <tr>
                                <td class="br tc"><strong>NET PAYABLE AMOUNT ( A - B )</strong></td>
                                <td class="br"></td>
                                <td class="tr"><strong id="Net2">0</strong></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>

                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table style="width: 260pt; float: right;">

                            <tr>
                                <td>&nbsp;<br>
                                    <br>
                                    <br>
                                    <br>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 260pt; float: left;" cellpadding="0" cellspacing="0">

                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                        <table class="ht" style="width: 260pt; float: left; border: 1px solid #333;" cellpadding="0" cellspacing="0">
                            <tr>
                                <th class="tc br">DEDUCTIONS</th>
                                <th class="tr">AMOUNT</th>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="tr">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="br">Contribution to ESI</td>
                                <td class="tr" id="ESI">0</td>
                            </tr>
                            <tr>
                                <td class="br">Contribution to EPF</td>
                                <td class="tr" id="EPF">0</td>
                            </tr>
                            <tr>
                                <td class="br">Tax Deducted at Source</td>
                                <td class="tr" id="TDS">0</td>
                            </tr>
                            <tr>
                                <td class="br">Salary in Advance</td>
                                <td class="tr"id="OtherAdvanceDeduction" >0</td>
                            </tr>
                            <tr>
                                <td class="br">Professional Tax</td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td class="br">Other Deductions</td>
                                <td class="tr">0</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="tr">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="tr">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="tr">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="tr">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="tr">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="tr">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="br tl"><strong>TOTAL DEDUCTIONS (B)</strong></td>
                                <td class="tr"><strong id="Deducted">0</strong></td>
                            </tr>
                            <tr>
                                <td style="border: none;">&nbsp;</td>
                                <td style="border: none;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="border: none;">&nbsp;</td>
                                <td style="border: none;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>

        <table style="width: 555pt; margin-top: 20pt;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <i><b id="Net1"></b></i>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="tc"><strong>For GENESIS GAS SOLUTIONS PRIVATE LIMITED</strong></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="tc"><h6>* Your salary details are strictly private and confiential and details in this letter must not be disclosed and discussed with others.</h6></td>
            </tr>
            <tr>
                <br />
                <td class="tc"><h6>* <b>  System generated slip and does not required stamp OR signatures. </b></h6></td>
            </tr>


        </table>
    </div>
     
    </body>
    

 <script type="text/javascript">
     
     var dateObj = new Date();
     var month = dateObj.getUTCMonth() + 1;
     var day = dateObj.getUTCDate();
     var year = dateObj.getUTCFullYear();

     newdate ="SalarySlip" +month + "/" + year+".pdf";
    

    const options = {
      margin: 0,
      filename: newdate,    
      image: { 
        type: 'pdf', 
        quality: 100
      },
      html2canvas: { 
        scale: 1 
      },
      jsPDF: { 
        unit: 'in', 
        format: 'a4',
         orientation: 'portrait'
      }
    }
    
    $('#generatePDF').click(function (e) {   
      e.preventDefault();
      const element = document.getElementById('pdfdiv');
      html2pdf().from(element).set(options).save();
    });
  
    </script>
</html>

