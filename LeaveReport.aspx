<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="LeaveReport.aspx.cs" Inherits="LeaveReport" %>


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
        }
        function GetEmployeeLeave(YearNo, MonthNo, Email) {
            $(".loaderbg").show();
            $("#BanlSlipTable").empty();
            var formData = new FormData();
            formData.append("YearNo", YearNo);
            formData.append("MonthNo", MonthNo);
            formData.append("Email", Email);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/GetLeaveReport',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $("#BanlSlipTable").empty();
                    if (data[0].response == "Fail") {
                        Swal.fire({
                            icon: 'info',
                            title: 'info',
                            width: '300px',
                            text: 'Data Not Found.!',
                            timer: 1500
                        });
                        $(".loaderbg").hide();

                    } else {
                        var j = 1;
                        jQuery('<thead><tr><th>S.No.</th> <th class="d-none d-xl-table-cell">Employee Name</th>  <th class="d-none d-xl-table-cell">Leave Type</th>  <th class="d-none d-xl-table-cell">From Date</th><th class="d-none d-xl-table-cell">To Date</th> <th class="d-none d-xl-table-cell">Total Day</th>  <th class="d-none d-md-table-cell">Purpose</th>   <th class="d-none d-md-table-cell">Leave Status</th>   <th class="d-none d-md-table-cell">Approved / Reject</th> <th class="d-none d-md-table-cell">Available CL</th> <th class="d-none d-md-table-cell">Available SL</th>  <th class="d-none d-md-table-cell">Available EL</th> <th class="d-none d-md-table-cell">Used CL</th> <th class="d-none d-md-table-cell">Used SL</th> <th class="d-none d-md-table-cell">Used EL</th> </tr></thead>').appendTo("#BanlSlipTable");
                        for (var i = 0; i < data.length; i++) {

                            if (data[i].Status == "Approved") {

                                jQuery('<tbody> <tr> <td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].empName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TypeLeave + '</td>  <td class="d-none d-xl-table-cell">' + data[i].FromDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].ToDate + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TotalDay + '</td> <td class="d-none d-xl-table-cell">' + data[i].Purpose + '</td> <td class="d-none d-xl-table-cell"> <span class="badge bg-success">' + data[i].Status + '</span> </td>  <td class="d-none d-xl-table-cell">' + data[i].Approve_Name + '</td>  <td class="d-none d-xl-table-cell">' + data[i].CL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].SL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].EL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UCL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].USL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UEL + '</td>     </tr> </tbody>').appendTo("#BanlSlipTable");

                            } else if (data[i].Status == "Reject") {

                                jQuery('<tbody> <tr> <td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].empName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TypeLeave + '</td>  <td class="d-none d-xl-table-cell">' + data[i].FromDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].ToDate + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TotalDay + '</td> <td class="d-none d-xl-table-cell">' + data[i].Purpose + '</td> <td class="d-none d-xl-table-cell"> <span class="badge bg-danger">' + data[i].Status + '</span> </td>  <td class="d-none d-xl-table-cell">' + data[i].Approve_Name + '</td>  <td class="d-none d-xl-table-cell">' + data[i].CL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].SL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].EL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UCL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].USL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UEL + '</td>     </tr> </tbody>').appendTo("#BanlSlipTable");

                               // jQuery('<tbody> <tr><td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].FDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].TDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].Purpose + '</td> <td class="d-none d-xl-table-cell">  <span class="badge bg-danger">' + data[i].LeaveStatus + ' </span> </td>  <td class="d-none d-xl-table-cell">' + data[i].ApprovedName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].Leave + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UsedLeave + '</td>     </tr> </tbody>').appendTo("#BanlSlipTable");
                                //Processing
                            }else{
                                jQuery('<tbody> <tr> <td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].empName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TypeLeave + '</td>  <td class="d-none d-xl-table-cell">' + data[i].FromDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].ToDate + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TotalDay + '</td> <td class="d-none d-xl-table-cell">' + data[i].Purpose + '</td> <td class="d-none d-xl-table-cell"> <span class="badge bg-warning">' + data[i].Status + '</span> </td>  <td class="d-none d-xl-table-cell">' + data[i].Approve_Name + '</td>  <td class="d-none d-xl-table-cell">' + data[i].CL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].SL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].EL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UCL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].USL + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UEL + '</td>     </tr> </tbody>').appendTo("#BanlSlipTable");

                                //jQuery('<tbody> <tr><td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].FDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].TDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].Purpose + '</td> <td class="d-none d-xl-table-cell">  <span class="badge bg-warning">' + data[i].LeaveStatus + '</span> </td>  <td class="d-none d-xl-table-cell">' + data[i].ApprovedName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].Leave + '</td>  <td class="d-none d-xl-table-cell">' + data[i].UsedLeave + '</td>     </tr> </tbody>').appendTo("#BanlSlipTable");
                    }
                    j++;


                        }
                        $(".loaderbg").hide();

                    }
                }
            });
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Leave Report</h3>
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
                        <a href="#" class="btn btn-primary float-center" onclick="SearchBtn()">  Search... </a>

                    </div>

                </div>
            </div>
            </div>

    <%--<div class="card flex-fill">
        <div class="card-header">


            <div class="input-group input-group-sm m-1" style="width: 200px; float: left;">

                <select id="YearDrop" class="form-select mb-3" style="border-radius: 4px;" onchange="GetMonthByYear()"></select>
            </div>

            <div class="input-group input-group-sm m-1" style="width: 200px; float: left;">
                <select id="MonthDrop" class="form-select mb-3" style="border-radius: 4px;" onchange="GetDetailsMonthBy()"></select>

            </div>
            <div class="input-group input-group-sm m-1" style="width: 200px; float: left;">
                <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>
        </div>



    </div>--%>

    <div class="card flex-fill">
        <div class="card-header">
            <br />
        </div>
        <div style="width: auto; height: auto; overflow-x: auto; overflow-y: auto;">

            <table id="BanlSlipTable" class="table table-striped text-center">
                
            </table>
        </div>
    </div>
</asp:Content>


