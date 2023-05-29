<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="demo.aspx.cs" Inherits="approvewfh" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // show Time
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                         var now = today.toLocaleString().toUpperCase();;
                $(".cv").text(now);

            }
            // end 
            // Default Get WFH LEave
            $(function () {
                GetDefalutLeave("NA", "NA", "NA");
            });
            var input = document.getElementById('SearchText');
            input.addEventListener('keydown', function (event) {
                const key = event.key;
                if (key === "Backspace") {

                    GetDefalutLeave("NA", "NA", "NA");
                }
            });


            //
            /// Search Employee Name List
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
                        var ddlCustomers = $("[id*=select2]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {
                            ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                        });

                    }

                });
            });

            $('#SearchText').on('change', function () {
                //GetDefalutLeave($("#SearchText").val(), "EmpTO");
                var F = $("#FDate").val();
                var T = $("#TDate").val();

                if (F == "" || T== " ") {

                    GetDefalutLeave("NA", "NA", $("#SearchText").val());
                } else {
                    GetDefalutLeave(F, T, "NA");
                }
            });
            //
            $("#TDate").change(function () {
                var F = $("#FDate").val();
                var T = $("#TDate").val();
                var Name = $("#SearchText").val();
                if (Name != "" || Name.length != 0) {
                    GetDefalutLeave(F, T, Name);
                } else {
                    if (F == "") {
                        Swal.fire({
                            icon: 'error',
                            title: 'error',
                            width: '300px',
                            text: "please select from Date"
                        })
                        $("#TDate").val(' ');
                    } else {
                        GetDefalutLeave(F, T, "NA");
                    }
                }
            });
            // end main
        });

        function GetDefalutLeave(FDate, TDate, Emp) {
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("Email", Emp);
            formData.append("FDate", FDate);
            formData.append("TDate", TDate);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/View_WFH',
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
                        $("#ShowTableWork").empty();
                    } else {
                        $("#ShowTableWork").empty();
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].LeaveStatus == "Processing") {
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>   <td><span class="badge bg-warning">Processing</span></td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr>')
                            } else if (data[i].LeaveStatus == "Approved") {
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>      <td><span class="badge bg-success">Approved</span></td>   <td> </td> </tr>')
                            } else {
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>      <td><span class="badge bg-danger">Reject</span></td>   <td> </td> </tr>')
                            }
                            j++;
                        }
                    }

                }

            });
        }
        // fun

        function EmployeeFunWorking(id) {
            // Drop
            var a = "#Drop" + id;
            alert(a);
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
                    url: 'WebServerFile/WebService.asmx/UpdateWFHStatuss',
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
                            GetDefalutLeave("All", "0");
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
        //

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
                                    <span class="btn btn-light bg-white shadow-sm " >
                                        <i class="align-middle mt-n1" data-feather="calendar"></i> <strong class="cv">2022/10/12 - 12:11:47</strong>
                                    </span>
                                </div>

                                <button class="btn btn-primary shadow-sm">
                                    <i class="align-middle" data-feather="refresh-cw">&nbsp;</i>
                                </button>
                            </div>
                        </div>
 

    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">List</h5>




            <div class="input-group input-group-sm p-2" style="width: 250px; float: right;">
                <input list="select2" type="text" title="Enter Employee Name" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>


            <div class="input-group input-group-sm p-2" style="width: 250px; float: right;">
                <%--<input id="reportrange" class="form-control form-select"/>--%>

                <input type="date" id="TDate" class="form-control" title="To Date"   style="border-radius: 4px;" />
            <%--onchange="ShowList()"--%>
            </div>

            <div class="input-group input-group-sm p-2" style="width: 250px; float: right;">

                <input type="date" id="FDate" class="form-control" title="From Date" style="border-radius: 4px;" />

            </div>


        </div>
        <table id="datatables-dashboard-projects" class="table table-striped my-0">
            <thead>
                <tr>
                    <th>S.No.</th>
                    <th class="d-none d-xl-table-cell">Employee Name</th>
                    <th class="d-none d-xl-table-cell">From Date</th>
                    <th class="d-none d-xl-table-cell">TO Date</th>
                    <th class="d-none d-xl-table-cell">Total Day</th>
                    <th class="d-none d-md-table-cell">Purpose</th>
                    <th class="d-none d-md-table-cell">Leave Status</th>
                    <th class="d-none d-md-table-cell">Option</th>
                </tr>
            </thead>
            <tbody id="ShowTableWork"></tbody>
        </table>
    </div>
       </div>
  <%--  <script>
        $(document).ready(function () {
            $('.MYDate').daterangepicker({
                dateFormat: 'YYYY-MM-DD'

            });
        });

    </script>--%>
  <%--  <script type="text/javascript">
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
    </script>--%>
</asp:Content>


