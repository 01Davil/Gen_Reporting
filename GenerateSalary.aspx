<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="GenerateSalary.aspx.cs" Inherits="GenerateSalary" %>


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
             const monthNames = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
            ];

            const d = new Date();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/WebService.asmx/Check_SalaryGenerated',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                   // alert(data[0].response);

                    if (data[0].response == '1' || data[0].response == 1) {
                        $("#div1").show();
                        $("#div2").hide();
                        var a = "Attendance for " + monthNames[d.getMonth()] + " month  has not been generated.";
                        $("#MyText").html(a);

                    } else if (data[0].response == '2' || data[0].response == 2) {
                        $("#div1").show();
                        $("#div2").hide();
                        var a = "Attendance for " + monthNames[d.getMonth()] + " month  has not approved yet.";
                        $("#MyText").html(a);
                    }
                    else if (data[0].response == '3' || data[0].response == 3) {
                        $("#div1").hide();
                        $("#div2").show();
                        GetSalary("NA");
                    }

                    else if (data[0].response == '4' || data[0].response == 4) {
                    
                        $("#div1").show();
                        $("#div2").show();
                        $("#ApprovedSalary").hide();
                        var a = " " + monthNames[d.getMonth()] + " month Salary has already been generated.";
                        $("#MyText").html(a);
                        GetSalary("NA");
                    }
                    else if (data[0].response == '5' || data[0].response == 5) {

                        $("#div2").show();
                        $("#div1").show();
                        $("#ApprovedSalary").hide();
                        var a = " " + monthNames[d.getMonth()] + " month Salary has Approved .";
                        $("#MyText").html(a);
                        GetSalary("NA");
                    }
                    else {
                        $("#div2").show();
                        $("#div1").hide();
                        GetSalary("NA");
                     
                    }
                }

            })

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

            $("#ApprovedSalary").click(function (e) {
                e.preventDefault();
                 var formData = new FormData();
           formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
        
            $.ajax({
                url: 'WebServerFile/WebService.asmx/Update_SalarGenerated',  //
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    
                    if (data[0].response == 'Fail') {
                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "No details found.",
                            timer: 3000
                        });
                    } else {
                        // Done
                        Swal.fire({
                            icon: 'success',
                            width: '300px',
                            text: "Salary Generate  success",
                            timer: 3000
                        });
                        $("#ApprovedSalary").hide();
                    }
                }

            });

            })

        });


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

        function GetSalary(EmailID) {
            $("#BanlSlipTable").empty();
            var obj = {
                EmailId: EmailID
            }
            $.ajax({
                type: "POST",
                url: "GenerateSalary.aspx/ShowSalary",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    xmlDoc = response.d;
                    $("#BanlSlipTable").append("<thead class='thead-dark text-center'  style='position: sticky; top: -10px; margin-top:-12px !important; z-index: 2;' >" +
                        " <th>Sno</th> <th>EmpCode</th> <th>Name</th>  "
                      + " <th> Present Day (PaidDays)</th> <th> Absent Day</th> "
                       + " <th>Basic</th> <th>HRA</th> <th>Conveyance</th>  <th>Allowance</th>  <th>ArrearAllowance</th>  <th>BonusAllowance</th> <th>OtherAllowance</th>  <th>ExtraAllowance</th> <th>MediAllowance</th> <th>SpecialAllowance</th>     <th>Bonus</th>  <th>DA</th> <th>TA</th>     <th>TotalGross</th> <th>TDS</th> <th>OtherAdvanceDeduction</th>   <th>ESIC_E</th> <th>PF_E</th> <th>ESC_ER</th><th>PF_ER</th>  <th>Total Deduction</th>  <th>NetPay</th>  <th>CTC</th>   <th>ESIC No</th>   "
                     + "    </thead>");
                    //<th>Edit</th>
                    var j = 1;
                    for (var i = 0; i <= xmlDoc.length - 1; i++) {
                        jQuery('<tr> <td>' + j + '</td> <td>' + xmlDoc[i].EmpCode + '</td> <td>' + xmlDoc[i].EmpName + '</td> '
                            + ' <td>' + xmlDoc[i].PDay + '</td>    <td>' + xmlDoc[i].ADay + '</td>  '

                           + ' <td>' + xmlDoc[i].Basic + '</td>   <td>' + xmlDoc[i].HRA + '</td>  <td>' + xmlDoc[i].Conveyance + '</td> <td>' + xmlDoc[i].Allowance + '</td> <td>' + xmlDoc[i].ArrearAllowance + '</td> <td>' + xmlDoc[i].BonusAllowance + '</td> <td>' + xmlDoc[i].Others + '</td> <td>' + xmlDoc[i].ExtraAllowance + '</td> <td>' + xmlDoc[i].MediAllowance + '</td> <td>' + xmlDoc[i].SpecialAllowance + '</td>     <td>' + xmlDoc[i].Bonus + '</td><td>' + xmlDoc[i].DA + '</td>      <td>' + xmlDoc[i].TA + '</td>   <td>' + xmlDoc[i].TotalGross + '</td>  <td>' + xmlDoc[i].TDS + '</td> <td>' + xmlDoc[i].OtherAdvanceDeduction + '</td>      <td>' + xmlDoc[i].ESIC_E + '</td>  <td>' + xmlDoc[i].EPF_E + '</td>  <td>' + xmlDoc[i].EPF_ER + '</td>      <td>  ' + xmlDoc[i].ESIC_ER + '</td>   <td>  ' + xmlDoc[i].Deducted + '</td>  <td>  ' + xmlDoc[i].NetSalary + '</td>  <td>  ' + xmlDoc[i].CTC + '</td>   <td>' + xmlDoc[i].ESICNO + '</td> '
                           + '    </tr>').appendTo("#BanlSlipTable");
                        // <td><button type="button" class="btn btn-warning form-control"  id="update"' + j + ' onclick="EditBg(' + j + ')" > <i class="bi bi-pencil-square"></i>Edit </button></td>   
                        j++;

                    }
                },
                error: function (data) {

                }
            });
        }

        function SearchBtn() {

            if ($("#SearchText").val()=="")
            {
                GetSalary("NA");

            }else{
            GetSalary($("#SearchText").val());
        }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>GENERATE SALARY</h3>
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
    <%--  --%>
    <div id="div1">

        <div class="card flex-fill">
            <div class="card-header" style="text-align: center; color: red;">
                <h1 id="MyText"></h1>
            </div>
        </div>
    </div>
    <%--  --%>

    <div id="div2">
        <div class="card flex-fill">
            <div class="card-header">
                <br />
            </div>

            <div class="card-body">

                <div class="row mt-4">


                    <div class="col-md-3">
                        <input list="select" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                        <datalist class="MeClass" id="select">
                        </datalist>
                    </div>

                    <div class="col-md-3">
                        <a href="#" class="btn btn-primary float-center" onclick="SearchBtn()"><i class="fa fa-file-excel"></i>Search... </a>

                    </div>

                    <div class="col-md-3">

                        <button class="btn btn-warning form-control" type="submit" id="ApprovedSalary">Approval For Salary</button>
                    </div>

                    <div class="col-md-2">
                        <a href="#" class="btn btn-primary float-end " onclick="BankSlipToExcel('BanlSlipTable', 'user-data')"><i class="fa fa-file-excel"></i>Download  Excel </a>

                    </div>
                </div>
            </div>
        </div>


        <div class="card flex-fill">
            <div class="card-header">

                <br />
            </div>
            <div style="overflow-x: auto; height: 400px; text-align: center; margin-top: -20px;">

                <table id="BanlSlipTable" class="table table-striped my-0">
                </table>
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
                                    <input type="text" class="form-control numberonly" id="TBasic" value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        HRA  Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="THra" value="0" />
                                </div>
                            </div>


                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Conveyance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="Conveyance" value="0" />
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
                                    <input type="text" class="form-control numberonly" id="ArrearAllowance" name="ArrearAllowance" value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Bonus Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="BonusAllowance" value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Other Allowance
                                    </label>
                                    <input type="text" class="form-control numberonly" id="OtherAllowance" value="0" />
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
                                    <input type="text" class="form-control numberonly" id="RateMedicalAllowance" value="0" />
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
                                    <input type="text" class="form-control numberonly" id="RateBonus" value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        DA
                                    </label>
                                    <input type="text" class="form-control numberonly" id="RateDA" value="0" />
                                </div>
                            </div>


                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        TA
                                    </label>
                                    <input type="text" class="form-control numberonly" id="TA" value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Total Gross
                                    </label>
                                    <input type="text" class="form-control numberonly" id="GrossPay" value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        TDS
                                    </label>
                                    <input type="text" class="form-control numberonly" id="TDS" value="0" />
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
                                    <input type="text" class="form-control numberonly" id="ESIC_E" value="" value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        PF_E Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="PF_E" value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        ESIC_ER Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="ESIC_ER" value="0" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        PF_ER  Amount
                                    </label>
                                    <input type="text" class="form-control numberonly" id="PF_ER" value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Deducted
                                    </label>
                                    <input type="text" class="form-control numberonly" id="Deducted" value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        NetSalary
                                    </label>
                                    <input type="text" class="form-control numberonly" id="NetSalary" value="0" />
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
                                    <input type="text" class="form-control " id="TESICNO" value="0" />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-4">
                                    <label for="event">
                                        Voucher
                                    </label>
                                    <input type="text" class="form-control numberonly" id="Voucher" value="0" />
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


    <div class="modal fade" id="EmployeeSalaryModal2">
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
                                    <button type="submit" id="Conbtn" class="form-control btn btn-primary">Are You Confirm</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
