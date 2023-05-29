<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fnfview.aspx.cs" Inherits="Fnfview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta charset="UTF-8">
        <title>Salary Slip</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
            body{
                padding: 0;
                margin: 0;
                background-color: #efefef;
                font-family: 'Poppins', sans-serif !important;
                font-size: 12px;
                line-height: 12px;
            }

            .main{
                width:  595pt;
                height: 840pt;
                background-color: #fff;
                color: #222;
                margin-left: auto;
                margin-right: auto;
                position: relative;
                box-sizing: border-box;
                padding: 20px;
            }
            .header-table-ss{
                width: 555pt;
                height: 90pt;
            }

            .bt{
                border-top: 1px solid #333;
            }
            .bb{
                border-bottom: 1px solid #333;
            }
            .bl{
                border-left: 1px solid #333;
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
                text-align: left !important;
            }

            .cd{
                color: #fff;
                background-color: #47336e;
            }
            .data td{padding-top: 5px; padding-bottom: 5px; font-size: 14px; text-align: center; border: 1px solid #333; line-height: 16px;}
            .fs14{font-size: 14px;}
            .bg{background-color: #e4e2fe;}
            .input-box{
                height: 80px;
                width: 300px;
                position: fixed;
                z-index: 99;
                background-color: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 1px 1px 10px 1px rgba(0, 0, 0, .1);
                top: 50%;
                left: 50%;
                margin-left: -150px;
                margin-top: -50px;
                display: none;
            }
            .input-box input{
                height: 30px;
                background-color: #efefef;
                border-radius: 8px;
                outline: none;
                border: 1px solid #47336e;
                color: #333;
                width: 286px;
                padding-left: 10px;
            }
            .input-box button{
                height: 32px;
                margin-top: 15px;
                width: 100%;
                text-align: center;
                background-color: #47336e;
                color: #fff;
                outline: none;
                border-radius: 8px;
                line-height: 26px;
                font-weight: 600;
                border: 1px solid #47336e;
                cursor: pointer;
                transition: all .3s;
            }
            .input-box button:hover{
                background-color: #5f4494;
            }

        </style>
 <script src="assets/jquery-3.6.4.min.js" type="text/javascript"></script>
        
       

 <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="JsDB/jquery.js"></script>
 <script src="PdfJS/html2canvas.min.js"></script>
<script src="PdfJS/html2pdf.min.js"></script>
<script src="PdfJS/jquery.min.js"></script>
<script src="PdfJS/jspdf.debug.js"></script>
    <script type="text/javascript">

        //window.onload = function () {
        //    $('.input-box').css('display', 'block');
        //};
        $(document).ready(function () {

            setTimeout(function () {
                debugger;
                    $.ajax({
                        type: "POST",
                        url: "Fnfview.aspx/GetFnf",
                        data: '{}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            xmlDoc = r.d;
                            if (xmlDoc.length > 0) {
                                $("#N").text(xmlDoc[0].Name);
                                $("#E").html(xmlDoc[0].EmpCode);
                                $("#D").html(xmlDoc[0].DOJ);
                                $("#S").text(xmlDoc[0].SAL);
                                $("#RD").text(xmlDoc[0].RES);
                                $("#ANS").text(xmlDoc[0].ANUAL);
                                $("#LW").text(xmlDoc[0].LAST);
                                $("#NPA").text(xmlDoc[0].NET);
                                $("#NSM").text(xmlDoc[0].NETM);
                                $("#NSW").text(xmlDoc[0].NETMW);
                                $("#G").text(xmlDoc[0].GRA);
                                $("#GW").text(xmlDoc[0].GRW);
                                $("#LA").text(xmlDoc[0].LOA);
                                $("#LAW").text(xmlDoc[0].LOAW);
                                $("#FPA").text(xmlDoc[0].FINPA);
                                $("#FW").text(xmlDoc[0].FINPW);                               
                                $("#NH").text(xmlDoc[0].NE);
                                $("#FA").text(xmlDoc[0].FAW);
                                $("#N1").text(xmlDoc[0].N1);
                           

                            } else {
                               alert("Data not Found:");
        

                            }
                        }
                    });
            }, 1000);

        });
         
                       
   
        </script>
    </head>
<body>

      


      <div class="main" id="pdfdiv2">
            <div class="header-table-ss" style="margin-bottom:40px !important; float: left;">
                <table style="width: 100%;">
                    <tr>
                        <td class="tl" style="width: 50%;"><img src="assets/logo.jpg" style="height: 36px; margin-top:-15px !important; margin-bottom:10px !important ;" ></td>
                        <td style="width: 50%;">
                            <table>
                                <tr>
                                    <td colspan="2">
                                        <strong style="font-size: 16px;">GENESIS GAS SOLUTIONS PRIVATE LIMITED</strong>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-size:12px !important;">
                                        CIN No.<br>
                                        GSTIN<br>
                                        Regd. Office<br><br>
                                        Phone<br>
                                        E-mail<br>
                                        Website<br>


                                    </td>
                                  <td style="font-size:12px !important;">
                                        &nbsp; : U93090DL2017PTC315609<br>
                                        &nbsp; : 07AAGCG7792L1ZW<br>
                                        &nbsp; : Building No. 10, DDA Commercial Complex,<br> &nbsp;  &nbsp; Nangal Raya, New Delhi-46<br>
                                        &nbsp; : 91-11-49063994<br>
                                        &nbsp; : info@genesis-in.com<br>
                                        &nbsp; : www.genesis-in.com<br>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>


         


            <table class="ht data" style="width: 555pt; border: 1px solid #333; margin-top: 10pt;" cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <th colspan="4" style="height: 26pt;" class="bb cd tc fs14">  The following statement implies the Full & Final Settlement of <span class="ename" id="N1">Name Here</span>
                        </th>
                    </tr>
                    <tr>
                        <td>Name</td>  
                        <td><span class="ename" id="N">Name Here</span></td> 
                        <td>EMP Code</td> 
                        <td> 
                            <span class="empcode" id="E">Emp Code</span> 
                          <%--  <div class="input-box">
                            <input type="text" placeholder="Emp Code Here" id="empcode_box" for="empcode" >
                            <button type="button" id="save">SAVE</button>
                            </div>--%>
                        </td>
                    </tr>

                    <tr>
                        <td>Date of Joining</td>  
                        <td><span id="D">DOJ</span></td> 
                        <td>Actual CTC Salary</td> 
                        <td> 
                            <span id="S">Salary</span> 
                        </td>
                    </tr>

                    <tr>
                        <td>Resigned / Superannuation on</td>  
                        <td><span id="RD">R Date</span></td> 
                        <td>Actual Net Salary</td> 
                        <td> 
                            <span id="ANS">Salary</span> 
                        </td>
                    </tr>
                    
                    <tr>
                        <td>Last Working Day</td>  
                        <td id="LW">31st March 2023</td> 
                        <td rowspan="2" class="bg"><strong>NET PAYLABLE AMOUNT</strong></td> 
                        <td rowspan="2" class="bg"> 
                            <h3 id="NPA">31,850</h3>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>  
                        <td>&nbsp;</td> 
                        
                    </tr>
                    
                    <tr><td colspan="4"><br></td></tr>
                    
                    <tr>
                        <td> A. Net salary for the month of May' 23 </td>
                        <td> <strong id="NSM">60,800</strong> </td>
                        <td colspan="2" id="NSW"> SIXTY THOUSAND EIGHT HUNDRED RUPEES ONLY </td>
                    </tr>
                    <tr>
                        <td> B. Gratuity </td>
                       <td> <strong id="G">60,800</strong> </td>
                        <td colspan="2" id="GW"> SIXTY THOUSAND EIGHT HUNDRED RUPEES ONLY </td>
                    </tr>
                    <tr>
                        <td> C. Loan Amount </td>
                        <td><strong id="LA"> 60,800</strong> </td>
                        <td colspan="2" id="LAW"> SIXTY THOUSAND EIGHT HUNDRED RUPEES ONLY </td>
                    </tr>
                    
                    <tr>
                        <td> <strong>FINAL PAYABLE AMOUNT</strong> </td>
                        <td> <strong id="FPA">60,800</strong> </td>
                        <td colspan="2" id="FW">SIXTY THOUSAND EIGHT HUNDRED RUPEES ONLY </td>
                    </tr>
                    
                    <tr><td colspan="4"><br></td></tr>
                    
                    <tr>
                        <td class="bg"> <strong>Prepared By</strong> </td>
                        <td class="bg"> <strong>Verified By</strong> </td>
                        <td class="bg" colspan="2"> <strong>Approved By</strong> </td>
                    </tr>
                       
                       <tr>
                        <td> <strong>SONIA <br />(HR- Generalist)</strong> </td>
                        <td> <strong>ANSHUMALI BHUSHAN  (CEO)</strong> </td>
                        <td colspan="2"> <strong>INDRAJEET <br />(CTO)</strong> </td>
                    </tr>
                    
                    <tr>
                        <td><img src="assets/hr.jpg" style="height: 100px;" /></td>
                        <td><img src="assets/ceo.jpg" style="height: 100px;" /></td>
                        <td colspan="2"><img src="assets/cto.jpg" style="height: 100px;" /></td>
                    </tr>
                    
                     <tr><td colspan="4" class="cd"><h4>D E C L A R A T I O N</h4></td></tr>
                     <tr><td colspan="4"><strong>RECEIVED <span id="FA">THIRTY SIX THOUSAND FOUR HUNDRED FIFTY</span> TOWARDS FULL & FINAL<br> SETTLEMENT OF MY ACCOUNT</strong></td></tr>
                      <tr><td colspan="4"><strong>I CERTIFY THAT THIS SETTLEMENT IS MADE SUBSEQUENT TO MY RESIGNATION </strong></td></tr>
                     
                     <tr>
                         <td colspan="2" class="tl"> <strong>DATE: </strong><br><br><strong>PLACE: </strong></td>
                         <td colspan="2" ><strong>ACCEPTED BY</strong><br> <br> <hr> <br> <strong class="ename" id="NH">Name Here</strong></td>
                     </tr>


                </thead>
                <tbody>

                </tbody>
            </table>






            
        </div>


        <div class="card-header">
      <button type="button" id="fdownload" class="btn btn-primary" style="font-size: 14px; height:35px; line-height:35px; padding-left:15px; padding-right:15px; background-color:#47336e; outline:none; border:none; border-radius:6px; color:#fff; position:fixed; right:40px; bottom:40px;  display: block;">Download Pdf</button>
    

        </div>

</body>


    <script type="text/javascript">
  

        //const options = {
        //    margin: 0,
        //    filename: 'F& F Settlement.pdf',    //name the output file
        //    image: {
        //        type: 'pdf',     //image type
        //        quality: 100
        //    },
        //    html2canvas: {
        //        scale: 1
        //    },
        //    jsPDF: {
        //        unit: 'cm',
        //        format: 'a4',
        //        orientation: 'Portrait',

        //    }
        //}

      

        //$("#fdownload").click(function () {
        //    const element = document.getElementById('pdfdiv2');   //id for content area
        //    html2pdf().from(element).set({
        //        outputSize: '1024kb',
        //    }).save();
        //});
        $("#fdownload").click(function () {
            var element = document.getElementById('pdfdiv2');
            var opt = {
                margin: 0,
                filename: 'myfile.pdf',
                image: { type: 'jpeg', quality: 0.1},
                html2canvas: { scale:2 },
                jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
            };

            // New Promise-based usage:
            //html2pdf().from(element).set(opt).save();

            // Old monolithic-style usage:
            html2pdf(element, opt);
        });
       
    </script>
</html>
