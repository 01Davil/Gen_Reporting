<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_GenerateSalary.aspx.cs" Inherits="Admin_GenerateSalary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(function () {
            GetSalary();
        });

        $("#ApprovedSalary").click(function (e) {
            e.preventDefault();
            $.ajax({
                type: "POST",
                url: "Admin_GenerateSalary.aspx/ApprovedSalary",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "Done") {

                        Swal.fire({
                            icon: 'success',
                            title: 'success',
                            width: '300px',
                            text: 'Salary Approved!'

                        })
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        Swal.fire({
                            icon: 'success',
                            title: 'success',
                            width: '300px',
                            text: 'Salary Not Approved!'
                        })
                    }
                },
                error: function (data) {
                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: ' Function Error !'
                    })
                }
            });
        });



        $("#SalaryBtnUpdate").click(function (e) {
            e.preventDefault();
            debugger;
            objaa = {
                Code: $("#Code").val(),
                TBasic: $("#TBasic").val(),
                THra: $("#THra").val(),
                PF_E: $("#PF_E").val(),
                PF_ER: $("#PF_ER").val(),
                ESICNO: $("#TESICNO").val(),
                ESIC_E: $("#ESIC_E").val(),
                ESIC_ER: $("#ESIC_ER").val(),
                ArrearAllowance: $("#ArrearAllowance").val(),
                BonusAllowance: $("#BonusAllowance").val(),
                OtherAdvanceDeduction: $("#OtherAdvanceDeduction").val(),
                OtherAllowance: $("#OtherAllowance").val(),
                RateAllowance: $("#RateAllowance").val(),
                RateExtraAllowance: $("#RateExtraAllowance").val(),
                RateMedicalAllowance: $("#RateMedicalAllowance").val(),
                RateSpecialAllowance: $("#RateSpecialAllowance").val(),
                RateBonus: $("#RateBonus").val(),
                RateDA: $("#RateDA").val(),
                TA: $("#TA").val(),
                Conveyance: $("#Conveyance").val(),
                CTC: $("#CTC").val(),
                TDS: $("#TDS").val(),
                Voucher: $("#Voucher").val(),
                Deducted: $("#Deducted").val(),
                NetSalary: $("#NetSalary").val(),
                GrossPay: $("#GrossPay").val()
            }

            $.ajax({
                type: "POST",
                url: "Hr_GenerateSalary.aspx/UpdateEmployeeSalarySp",
                data: JSON.stringify(objaa),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "Done") {
                        $('#EmployeeSalaryModal').modal('hide');


                        Swal.fire({
                            icon: 'success',
                            title: 'success',
                            width: '300px',
                            text: ' Salary Update !'
                        })

                        GetSalary();
                    } else {

                        Swal.fire({
                            icon: 'success',
                            title: 'success',
                            width: '300px',
                            text: '  Salary Not Update !'
                        })
                    }
                },
                error: function (data) {

                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: 'Error !'
                    })
                }
            });
        });

  
    });
    //

    function GetSalary() {
        $("#BanlSlipTable").empty();
        $.ajax({
            type: "POST",
            url: "Admin_GenerateSalary.aspx/ShowSalaryhistory",
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
                       + '       </tr>').appendTo("#BanlSlipTable");

                    j++;

                }
            },
            error: function (data) {

            }
        });
    }
    function EditBg(j) {
        // 2,3,4
        $("#Code").val(document.getElementById("BanlSlipTable").rows[j].cells.item(1).innerText);
        $("#Name").val(document.getElementById("BanlSlipTable").rows[j].cells.item(2).innerText);
     //
        $("#TBasic").val(document.getElementById("BanlSlipTable").rows[j].cells.item(5).innerText);
        $("#THra").val(document.getElementById("BanlSlipTable").rows[j].cells.item(6).innerText);
        $("#PF_E").val(document.getElementById("BanlSlipTable").rows[j].cells.item(22).innerText);
        $("#PF_ER").val(document.getElementById("BanlSlipTable").rows[j].cells.item(24).innerText);
      $("#TESICNO").val(document.getElementById("BanlSlipTable").rows[j].cells.item(28).innerText);
        $("#ESIC_E").val(document.getElementById("BanlSlipTable").rows[j].cells.item(21).innerText);
        $("#ESIC_ER").val(document.getElementById("BanlSlipTable").rows[j].cells.item(23).innerText);
        $("#ArrearAllowance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(9).innerText);
        $("#BonusAllowance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(10).innerText);
        $("#OtherAdvanceDeduction").val(document.getElementById("BanlSlipTable").rows[j].cells.item(20).innerText);
        $("#OtherAllowance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(11).innerText);
        $("#RateAllowance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(8).innerText);
        $("#RateExtraAllowance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(12).innerText);
        $("#RateMedicalAllowance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(13).innerText);
        $("#RateSpecialAllowance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(14).innerText);
        $("#RateBonus").val(document.getElementById("BanlSlipTable").rows[j].cells.item(15).innerText);
        $("#RateDA").val(document.getElementById("BanlSlipTable").rows[j].cells.item(16).innerText);
        $("#TA").val(document.getElementById("BanlSlipTable").rows[j].cells.item(17).innerText);
        $("#Conveyance").val(document.getElementById("BanlSlipTable").rows[j].cells.item(17).innerText);
        $("#CTC").val(document.getElementById("BanlSlipTable").rows[j].cells.item(27).innerText);
        $("#TDS").val(document.getElementById("BanlSlipTable").rows[j].cells.item(19).innerText);
        //$("#Voucher").val(document.getElementById("BanlSlipTable").rows[j].cells.item(29).innerText);
        $("#Deducted").val(document.getElementById("BanlSlipTable").rows[j].cells.item(25).innerText);
        $("#NetSalary").val(document.getElementById("BanlSlipTable").rows[j].cells.item(26).innerText);
        $("#GrossPay").val(document.getElementById("BanlSlipTable").rows[j].cells.item(18).innerText);
        $('#EmployeeSalaryModal').modal('show');
    }
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <div class="card flex-fill">
        <div class="card-header">
                       <div class="input-group input-group-sm" style="width: 200px; float: left;">
                    <h4 class="btn btn-primary float-end ">Approved Salary</h4>
                </div>
                        <div class="input-group input-group-sm" style="width: 200px; float: right;">
                    <a href="#" class="btn btn-primary float-end " onclick="BankSlipToExcel('BanlSlipTable', 'user-data')"><i class="fa fa-file-excel"></i>Download  Excel </a>

                </div>
        </div>
           
         
    <div style="overflow-x: auto; height: auto; text-align: center; margin-top: -20px;">

        <table class="table table-hover" id="BanlSlipTable">
        </table>
    </div>
    </div>
            <div class="row mb-2" style="s">

               <div class="col-lg-3">
            <div class="form-group">
                <button class="btn btn-warning form-control" type="submit" id="ApprovedSalary">Approved Salary</button>
            </div>
        </div>
        </div>

    <%-- Employee Salary --%>
    <div class="modal fade" id="EmployeeSalaryModal">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <form>
                    <div class="modal-header px-4">
                        <h5 class="modal-title" id="H2">Salary Details</h5>
                        <button type="button" class="btn-close btn btn-primary btn-pill" data-bs-dismiss="modal"
                            aria-label="Close">
                            <i class="bi bi-x-circle-fill"></i>
                        </button>
                    </div>
                    <div class="modal-body px-4">

                        <div class="row mb-2">


                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label for="lastName">
                                        Employee Code</label>
                                    <input type="text" class="form-control  " id="Code" disabled />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="userName">
                                        Employee Name</label>
                                    <input type="text" class="form-control" id="Name" disabled />
                                </div>
                            </div>

                            
                        </div>
                        <hr />
                        <div class="row mb-2">
                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Basic 
                                    </label>
                                    <input type="text" class="form-control numberonly" id="TBasic"  value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        HRA  Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="THra" value="0"  />
                                </div>
                            </div>

                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Conveyance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="Conveyance" value="0"  />
                                </div>
                            </div>
                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="RateAllowance" value="0" />
                                </div>
                            </div>

                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Arrear Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="ArrearAllowance" name="ArrearAllowance" value="0"   />
                                </div>
                            </div>
                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Bonus Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="BonusAllowance" value="0"  />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Other Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="OtherAllowance" value="0"  />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Extra Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="RateExtraAllowance" value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Medical Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="RateMedicalAllowance" value="0"  />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Special Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="RateSpecialAllowance" value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Bonus
                                    </label>
                                    <input type="text" class="form-control numberonly" id="RateBonus"  value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        DA
                                    </label>
                                    <input type="text" class="form-control numberonly" id="RateDA"  value="0" />
                                </div>
                            </div>


                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        TA
                                    </label>
                                    <input type="text" class="form-control numberonly" id="TA" value="0"  />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Total Gross
                                    </label>
                                    <input type="text" class="form-control numberonly" id="GrossPay"  value="0" />
                                </div>
                            </div>
                        <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        TDS
                                    </label>
                                    <input type="text" class="form-control numberonly" id="TDS"  value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Other Advance Deduction
                                    </label>
                                    <input type="text" class="form-control numberonly" id="OtherAdvanceDeduction" value="0" />
                                </div>
                            </div>

                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        ESIC_E Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="ESIC_E" value=""  value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        PF_E Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="PF_E"  value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        ESIC_ER Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="ESIC_ER" value="0"  />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        PF_ER  Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="PF_ER" value="0"  />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Deducted
                                    </label>
                                    <input type="text" class="form-control numberonly" id="Deducted" value="0"  />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        NetSalary
                                    </label>
                                    <input type="text" class="form-control numberonly" id="NetSalary"  value="0" />
                                </div>
                            </div>
                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        CTC
                                    </label>
                                    <input type="text" class="form-control numberonly" id="CTC" value="0" />
                                </div>
                            </div>
                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        ESIC NO
                                    </label>
                                    <input type="text" class="form-control " id="TESICNO"  value="0" />
                                </div>
                            </div>
                            
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Voucher
                                    </label>
                                    <input type="text" class="form-control numberonly" id="Voucher" value="0"  />
                                </div>
                            </div>
                            <%-- End --%>
                            <hr />
                            <button type="submit" id="SalaryBtnUpdate" class="btn btn-primary btn-pill form-control">
                                Update Salary
                            </button>

                        </div>

                    </div>

                </form>
            </div>
        </div>
    </div>

    
<%--    <div class="modal fade" id="EmployeeSalaryModal2">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <form>
                    <div class="modal-header px-4">
                        <h5 class="modal-title" id="">Please  select the month to generate salary ?</h5>
                        <button type="button" class="btn-close btn btn-primary btn-pill" data-bs-dismiss="modal"
                            aria-label="Close">
                            <i class="bi bi-x-circle-fill"></i>
                        </button>
                    </div>
                    <div class="modal-body px-4">

                        <div class="row mb-2">

                            <div class="col-lg-4">
                             <div class="form-group">
                                 <label>Select Year</label>
                                 <select class="btn btn-primary dropdown-toggle form-control" id="YearDrop" onchange="GetMonthByYear()">
                                 </select>
                             </div>
                         </div>

                         <div class="col-lg-4">
                             <div class="form-group">
                                 <label>Select Month</label>
                                 <select class="btn btn-primary dropdown-toggle form-control" id="MonthDrop">
                                 </select>
                             </div>
                         </div>
                            <div class="col-lg-4 p-4">
                             <div class="form-group">
                                 <button type="submit"  id="Conbtn" class="form-control btn btn-primary">Are You Confirm</button>
                             </div>
                         </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>--%>
</asp:Content>
