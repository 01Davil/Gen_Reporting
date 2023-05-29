<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="Emp_MeTask.aspx.cs" Inherits="Emp_MeTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(function () {
                var formData = new FormData();
                formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                formData.append("Type", "Processing");
                $.ajax({
                    url: 'WebServerFile/Employee_MasterService.asmx/GetEmployeeAssignDetails',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data[0].response == "Fail") {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                width: '300px',
                                text: 'Data Not Found.!'
                            })
                        } else {
                            $("#tableThead").empty();
                            $("#tableTbody").empty();

                            $("#tableThead").append('<tr> <th>S.No.</th><th class="d-none d-xl-table-cell">Project Name</th><th class="d-none d-xl-table-cell">Task Name</th><th class="d-none d-xl-table-cell">Work</th> <th class="d-none d-md-table-cell">Deadline</th> <th>Current Status</th> <th> Update Status </th>  </tr>  ');
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                                jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td>' + data[i].Status + '</td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option> <option value="Work In progress">Work In progress</option> <option value="Complete">Complete</option> </select></td>  </tr>').appendTo("#tableTbody");
                                j++;
                            }
                        }
                    }
                });
            });
        });
        function EmployeeFunWorking(id) {
            var a = "#" + id;
            var b = $(a).find(":selected").val();

            if (b == "Work In progress" || b == "Complete" || b == "Processing") {
                // Work In progress, Complete
                var formData = new FormData();
                formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                formData.append("Id", id);
                formData.append("Type", b);
                $.ajax({
                    url: 'WebServerFile/Employee_MasterService.asmx/UpdateAssignWork',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data[0].response == "Fail") {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                width: '300px',
                                text: 'Not Update Work.!'
                            })
                        } else {
                            Swal.fire({
                                icon: 'success',
                                title: 'success',
                                width: '300px',
                                text: 'Assign Work Update'
                            });
                            $("#tableThead").empty();
                            $("#tableTbody").empty();

                            $("#tableThead").append('<tr> <th>S.No.</th><th class="d-none d-xl-table-cell">Project Name</th><th class="d-none d-xl-table-cell">Task Name</th><th class="d-none d-xl-table-cell">Work</th> <th class="d-none d-md-table-cell">Deadline</th> <th>Current Status</th> <th> Update Status </th>  </tr>  ');
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                                jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td>' + data[i].Status + '</td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option> <option value="Work In progress">Work In progress</option> <option value="Complete">Complete</option> </select></td>  </tr>').appendTo("#tableTbody");
                                j++;
                            }
                        }
                    }
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'error',
                    width: '300px',
                    text: 'Please Select a Valid Option!'
                })
            }
        }
        function GetEmployeeAssignWork() {
            var date =$("#reportrange").val();
            var b = $("#DropType").find(":selected").val();
            if (b != 0 || b != '0') {
                var formData = new FormData();
                formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                formData.append("Type", b);
                formData.append("Date", date);
                $.ajax({
                    url: 'WebServerFile/Employee_MasterService.asmx/GetDropAssignWork',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data[0].response == "Fail") {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                width: '300px',
                                text: 'Data Not Found !'
                            })
                        } else {
                            $("#tableThead").empty();
                            $("#tableTbody").empty();

                            if (b == "Complete") {
                                $("#tableThead").append(' <tr><th>S.No.</th><th class="d-none d-xl-table-cell">Project Name</th><th class="d-none d-xl-table-cell">Task Name</th> <th class="d-none d-xl-table-cell">Work</th> <th class="d-none d-md-table-cell">Deadline</th>   <th> 	Current Status</th> <th>Approved</th> </tr> ');
                                var j = 1;
                                for (var i = 0; i < data.length; i++) {
                                    jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td>' + data[i].Status + '</td>  <td>' + data[i].ApproveStatus + '</td>  </tr>').appendTo("#tableTbody");
                                    j++;
                                }
                            } else if (b == "Processing") {
                                $("#tableThead").append(' <tr> <th>S.No.</th><th class="d-none d-xl-table-cell">Project Name</th><th class="d-none d-xl-table-cell">Task Name</th><th class="d-none d-xl-table-cell">Work</th> <th class="d-none d-md-table-cell">Deadline</th> <th>Current Status</th> <th> Update Status </th>  </tr>  ');
                                var j = 1;
                                for (var i = 0; i < data.length; i++) {
                                    jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td>' + data[i].Status + '</td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option>  <option value="Work in Progress">Work in Progress </option> <option value="Complete">Complete</option> </select></td>  </tr>').appendTo("#tableTbody");
                                    j++;
                                }
                            } else {
                                $("#tableThead").append(' <tr> <th>S.No.</th><th class="d-none d-xl-table-cell">Project Name</th><th class="d-none d-xl-table-cell">Task Name</th><th class="d-none d-xl-table-cell">Work</th> <th class="d-none d-md-table-cell">Deadline</th> <th>Current Status</th> <th> Update Status </th>  </tr>  ');
                                var j = 1;
                                for (var i = 0; i < data.length; i++) {
                                    jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td>' + data[i].Status + '</td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option> <option value="Complete">Complete</option> </select></td>  </tr>').appendTo("#tableTbody");
                                    j++;
                                }

                            }

                        }
                    }

                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'error',
                    width: '300px',
                    text: 'Please Select a Valid Option !'
                })
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3 id="SetPageName">My Task</h3>
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
            <%--<h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Leave Summery</h5>--%>
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Previous Task List</h5>

            <div class="input-group input-group-sm" style="width: 250px; float: right;">
                <select id="DropType" class="form-select" style="border-radius: 4px;" onchange="GetEmployeeAssignWork()">
                    <option value="0">Select  type of work.</option>
                    <option value="Processing">Pending</option>
                    <option value="Work in Progress">Work in Progress  </option>
                    <option value="Complete">Complete</option>
                </select>
            </div>
            <div class="input-group input-group-sm" style="width: 20px; float: right;">
                <p></p>
                </div>
            <div class="input-group input-group-sm" style="width: 250px; float: right;">
            <input id="reportrange" class="form-control form-select"/>
            </div>
         
        </div>
        <table id="datatables-dashboard-projects" class="table table-striped my-0">
            <thead id="tableThead"></thead>
            <tbody id="tableTbody"></tbody>
        </table>
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

