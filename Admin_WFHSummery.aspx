<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_WFHSummery.aspx.cs" Inherits="Admin_WFHSummery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            
            GetDefalutLeave("NA", '0');

            var input = document.getElementById('SearchText');
            input.addEventListener('keydown', function (event) {
                const key = event.key;
                if (key === "Backspace") {
                    GetDefalutLeave("NA", "0");
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
                        ddlCustomers.empty().append('<option selected="selected" value="0">select Year</option>');
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].MonthNo).html(xmlDoc[i].MonthName));
                        }

                    }
                });
            });
            
            //
            /// Search Employee Name List
            $("#SearchText").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/Hr_MasterWebService.asmx/GetNameList',
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
                GetDefalutLeave($("#SearchText").val(), '0');
            });

            // end main
        });
        // get month List
        function GetMonthList() {

            var ddlCustomers = $("[id*=MonthDrop]");
            ddlCustomers.empty();
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
        function GetDefalutLeave(Emp, MonthNo) {
            debugger;
            var formData = new FormData();
            formData.append("Emp", Emp);
            formData.append("MonthNo",MonthNo);
            $.ajax({
                url: 'WebServerFile/AdminWebService.asmx/GetApplyWFH',
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
                        $("#ShowTableWork").empty(); 
                        $("#ShowThead").empty();
                        jQuery(' <tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">From Date</th> <th class="d-none d-xl-table-cell">To Date</th><th class="d-none d-xl-table-cell">Total Day</th><th class="d-none d-md-table-cell">Purpose</th><th class="d-none d-md-table-cell"> Status</th>  <th class="d-none d-md-table-cell"> Option</th>   </tr>').appendTo("#ShowThead");
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].LeaveStatus == "Processing") {
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>   <td><span class="badge bg-warning">Processing</span></td>   <td> <select  class="form-control"   onchange="EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr>')
                            } else if (data[i].LeaveStatus == "Approved") {
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>      <td><span class="badge bg-success">Approved</span></td>    <td> </td></tr>')
                            } else {
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>      <td><span class="badge bg-danger">Reject</span></td>   <td> </td>  </tr>')
                            }
                            j++;
                        }
                    }

                }

            });
        }
        // fun
        function GetDetailsMonthBy() {
            var MonthNo = $("#MonthDrop option:selected").val();
            var e = $("#SearchText").val();
            if (e == '') {
                GetDefalutLeave("NA", MonthNo);
            } else {
                GetDefalutLeave($("#SearchText").val(), MonthNo);
            }
            
        }
        function EmployeeFunWorking(id) {
            // Drop
            var a = "#Drop" + id;
            var Status = $("  " + a + " option:selected").val();

            if (Status == 0 || status == '0') {
                //
                Swal.fire({
                    icon: 'info',
                    //title: 'info',
                    width: '300px',
                    text: "Please Select a valid option",
                    timer: 3000
                });
            } else {
                // update 
                var formData = new FormData();
                formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                formData.append("Name", "<%= Session["LoginName"].ToString()%>");
                 formData.append("Id", id);
                 formData.append("Status", Status);
                 var a = "WFH Leave" + " " + Status + " success ";
                 $.ajax({
                     url: 'WebServerFile/AdminWebService.asmx/UpdateWFHStatus',
                     type: 'POST',
                     data: formData,
                     cache: false,
                     contentType: false,
                     processData: false,
                     success: function (data) {
                         Swal.fire({
                             icon: 'success',
                             width: '300px',
                             text: a,
                             timer: 3000
                         });
                         GetDefalutLeave("NA", '0');
                     }
                     
                 });
             }
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="card flex-fill">
        <div class="card-header">
            <h5  class="card-title mb-0" style="display: block; width: 240px; float: left;">Work From Home Summary</h5>
            <%--<div class="input-group input-group-sm" style="width: 250px; float: left;">
       
            </div>--%>
            
            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">
                  <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>
            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">
                <select id="MonthDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                </select>
            </div>
            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">
                <select id="YearDrop" class="form-select" style="border-radius: 4px;" onchange="GetMonthList()">
                </select>
            </div>

        </div>
        <table id="datatables-dashboard-projects" class="table table-striped my-0">
    <thead id="ShowThead">

            </thead>
            <tbody id="ShowTableWork"></tbody>
        </table>
    </div>
</asp:Content>





