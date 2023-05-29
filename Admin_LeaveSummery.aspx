<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_LeaveSummery.aspx.cs" Inherits="Admin_LeaveSummery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            // Default Get WFH LEave
            $(function () {
                GetDefalutLeave("All", "0", "Processing");
            });
            var input = document.getElementById('SearchText');
            input.addEventListener('keydown', function (event) {
                const key = event.key;
                if (key === "Backspace") {
                    GetDefalutLeave("All", "0", "Processing");
                }
            });

            $(function () {
                $.ajax({
                    type: "POST",
                    url: "MasterPage.aspx/GetMonth",
                    data: '{ }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;
                        var ddlCustomers = $("[id*=MonthDrop]");
                        ddlCustomers.empty().append('<option selected="selected" value="0">All Month</option>');
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
                    url: 'WebServerFile/Employee_MasterService.asmx/GetNameList',
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
                GetDefalutLeave($("#SearchText").val(), "EmpTO", "Processing");
            });

            // end main
        });
        function GetDefalutLeave(Emp, MonthNo,Type) {
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("Emp", Emp);
            formData.append("MonthNo", MonthNo);
            formData.append("Type", Type);
            $.ajax({
                url: 'WebServerFile/AdminWebService.asmx/GetLeaveSummery',
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
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {

                            if (data[i].Status == "Processing") {
                                $("#my").show();
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td>   <td><span class="badge bg-warning">Processing</span></td>    <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr>')

                            } else if (data[i].Status == "Reject") {
                                $("#my").hide();
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td>  <td><span class="badge bg-danger">Reject</span></td>   <td></td> </tr>')

                            } else {
                                $("#my").hide();
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td>  <td><span class="badge bg-success">Approved</span></td>   <td></td> </tr>')

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
                GetDefalutLeave("MonthTO", MonthNo, "Processing");
            } else {
                GetDefalutLeave($("#SearchText").val(), MonthNo, "Processing");
            }
        }
         function EmployeeFunWorking(id) {
            // Drop
            var a = "#Drop" + id;
            var Status = $("  " + a + " option:selected").val().trim();

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
                // 
                 $.ajax({
                     url: 'WebServerFile/AdminWebService.asmx/ApproveLevae',
                     type: 'POST',
                     data: formData,
                     cache: false,
                     contentType: false,
                     processData: false,
                     success: function (data) {
                         if (data = "1") {
                             Swal.fire({
                                 icon: 'success',
                                 //title: 'info',
                                 width: '300px',
                                 text: "Leave Approved success",
                                 timer: 3000
                             });
                             GetDefalutLeave("All", "0", "Processing");
                         } else {
                             Swal.fire({
                                 icon: 'info',
                                 //title: 'info',
                                 width: '300px',
                                 text: " Leave Not Approved",
                                 timer: 3000
                             });
                         }
                     },
                         xhr: function () {
                             var fileXhr = $.ajaxSettings.xhr();
                             if (fileXhr.upload) {
                                  
                             }
                             return fileXhr;
                         }

                 });
             }
         }
        // 
        function GetDetailsLeaveType() {
            // dd
            var LeaveType = $("#dd option:selected").val();
            GetDefalutLeave("all", "0", LeaveType)
        }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">LEAVE STATUS</h5>
            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">
             <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>

            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">

                <select id="dd" class="form-select ms-3"  onchange="GetDetailsLeaveType()" style="width: 250px;">
                    <option value="0">Leave of Type</option>
                    <option value="Processing">Processing</option>
                    <option value="Approved">Approved</option>
                    <option value="Reject">Reject</option>
                </select>
                
            </div>
            
            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">
                <select id="MonthDrop" class="form-select" style="border-radius: 4px; width: 250px;" onchange="GetDetailsMonthBy()">
                </select>
                </div>
                  
        </div>
        <table id="datatables-dashboard-projects" class="table table-striped my-0">
    <thead>
                <tr>
                    <th>S.No.</th>
                    <th class="d-none d-xl-table-cell">Employee Name</th>
                    <th class="d-none d-xl-table-cell">Leave Type</th>
                    <th class="d-none d-xl-table-cell">From Date</th>
                    <th class="d-none d-xl-table-cell">TO Date</th>
                    <th class="d-none d-xl-table-cell">Total Day</th>
                    <th class="d-none d-md-table-cell">Purpose</th>
                    <th class="d-none d-md-table-cell">Leave Status</th>
                    <th class="d-none d-md-table-cell" id="my">Option</th>
                </tr>
            </thead>
            <tbody id="ShowTableWork"></tbody>
        </table>
    </div>
</asp:Content>

