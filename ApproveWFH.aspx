<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ApproveWFH.aspx.cs" Inherits="ApproveWFH" %>

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
            // get apply Employee Apply WFH
            GetLeave("NA", "NA", "Processing");

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

        });

        function GetLeave(Date, Email, Type) {
            //alert(Date, Email, Type);

            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("Date", Date);
            formData.append("Email", Email);
            formData.append("Type", Type);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/Get_WFH',
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
                            text: "No details found."
               
                        });
                        $("#TableTbody").empty();
                        $("#TableThead").empty();
                    } else {
                        $("#TableTbody").empty();
                        $("#TableThead").empty();
                        if (Type == "Processing") {
                            jQuery('<tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">From Date </th><th class="d-none d-xl-table-cell">TO Date</th><th class="d-none d-md-table-cell">Total Day</th><th class="d-none d-md-table-cell">Purpose</th> <th>Leave Status</th>  <th> Option</th>  </tr>').appendTo("#TableThead");

                        } else if (Type == "Approved") {
                            jQuery('<tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">From Date </th><th class="d-none d-xl-table-cell">TO Date</th><th class="d-none d-md-table-cell">Total Day</th><th class="d-none d-md-table-cell">Purpose</th> <th>Leave Status</th>  <th> Approvel By</th>  </tr>').appendTo("#TableThead");

                        } else {
                            jQuery('<tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">From Date </th><th class="d-none d-xl-table-cell">TO Date</th><th class="d-none d-md-table-cell">Total Day</th><th class="d-none d-md-table-cell">Purpose</th> <th>Leave Status</th>  <th> Reject By</th>  </tr>').appendTo("#TableThead");

                        }
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].LeaveStatus == "Processing") {
                                $("#TableTbody").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>   <td><span class="badge bg-warning">Processing</span></td>   <td> <select  class="form-control"   onchange="ApprovalLeave(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr>')
                            } else if (data[i].LeaveStatus == "Approved") {
                                $("#TableTbody").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>      <td><span class="badge bg-success">Approved</span></td>   <td>' + data[i].ApprovedName + '</td>  </tr>')
                            } else {
                                $("#TableTbody").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>      <td><span class="badge bg-danger">Reject</span></td>   <td>' + data[i].ApprovedName + '</td>  </tr>')
                            }
                            j++;
                        }
                    }

                }

            });
        }
        function GetDate() {
         var Date=   $("#reportrange").val();
         var Email = $("#SearchText").val();
         var Type = $("#DD option:selected").val();
         if (Email == "" || Email.length == 0) {
             GetLeave(Date, "NA", Type);

         } else {
             GetLeave(Date, Email, Type);

         }
         //return false;
        }
        function ApprovalLeave(id) {
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
                formData.append("Id", id);
                formData.append("Status", Status);
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/UpdateWFHStatus',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data[0].response == "Save") {
                            Swal.fire({
                                icon: 'success',
                                width: '300px',
                                text: "WFH Leave Update success",
                                timer: 3000
                            });
                            GetLeave("NA", "NA", "Processing");

                        } else {
                            Swal.fire({
                                icon: 'info',
                                title: 'info',
                                width: '300px',
                                text: "WFH Leave Not Update",
                                timer: 3000
                            });
                        }
                    }

                });
            }
        }
    </script>

    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div class="container-fluid p-0">

            <div class="row mb-2 mb-xl-3">
                <div class="col-auto d-none d-sm-block">
                    <h3>Work From Home APPROVAL</h3>
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
                    <%--<h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Attendance Summary</h5>--%>
                </div>
                <div class="card-body">

                    <div class="row mt-4">
                        <div class="col-md-3">
                            <label class="form-label">Select Dates:</label>
                            <input id="reportrange" class="form-control form-select" />
                        </div>

                    <div class="col-md-3">
                        <label class="form-label">Enter official mail id</label>
                        <input list="select" type="text" id="SearchText" class="form-control"  style="border-radius: 4px;" />
                        <datalist class="MeClass" id="select">
                        </datalist>
                    </div>

                        <div class="col-md-3">
                            <label class="form-label">Select Type of Approval.</label>
                            <select class="form-select mb-3" id="DD">
                                <option selected value="Processing">Pending</option>
                                <option value="Approved">Approved</option>
                                <option value="Reject">Reject</option>
                            </select>
                        </div>

                        <div class="col-md-2 pt-4">
                            <a href="#" onclick="GetDate()" class="btn btn-primary float-end w-100 mt-1"><i class="fa fa-search"></i>Search </a>
                        </div>
                    </div>

                </div>

            </div>
            <div class="card flex-fill">

                <div class="card-header">
                    <h5 id="ShowLeaveType" class="card-title mb-0" style="display: block; width: 240px; float: left;">Summary</h5>
                    <h5 class="" style="float: right;"><i class="fa-solid fa-arrows-rotate"></i></h5>
                </div>
                <table id="datatables-dashboard-projects" class="table table-striped my-0">
                    <thead id="TableThead">
                    </thead>
                    <tbody id="TableTbody">
                    </tbody>
                </table>
            </div>
        </div>


        <script type="text/javascript">
            $(function () {
                //debugger;
                var start = moment().subtract(29, 'days');
                var end = moment();
                //Y-m-d
                function cb(start, end) {
                    $('#reportrange span').html(start.format('MM/D/YYYY') + ' - ' + end.format('MM/D/YYYY'));
                }

                $('#reportrange').daterangepicker({
                    startDate: start,
                    endDate: end,
                    ranges: {
                        'Today': [moment(), moment()],
                        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                        'This Month': [moment().startOf('month'), moment().endOf('month')],
                        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                    }
                }, cb);

                cb(start, end);

            });
        </script>
</asp:Content>

