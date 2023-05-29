<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="MyTask.aspx.cs" Inherits="MyTask" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
    <script src="JsDB/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            getMyTask("NA", "Processing");
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString().toUpperCase();
                $(".cv").text(now);

            }
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
                    url: 'WebServerFile/WebService.asmx/UpdateAssignWork',
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
                            getMyTask("NA", "Processing");
                            Swal.fire({
                                icon: 'success',
                                title: 'success',
                                width: '300px',
                                text: 'Assign Work Update'
                            });

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

        function getMyTask(Date,Type) {

            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("Type", Type);
            formData.append("Date", Date);
            //"Processing"
            $.ajax({
                url: 'WebServerFile/WebService.asmx/GetEmployeeAssignDetails',
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
                        $("#tableTbody").empty();
                    } else {
                        $("#tableThead").empty();
                        $("#tableTbody").empty();

                        $("#tableThead").append('<tr> <th>S.No.</th><th class="d-none d-xl-table-cell">Project Name</th><th class="d-none d-xl-table-cell">Task Name</th><th class="d-none d-xl-table-cell">Work</th> <th class="d-none d-md-table-cell">Deadline</th> <th>Current Status</th> <th> Update Work Status </th>  </tr>  ');
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].Status == "Complete") {
                                jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td> <span class="badge bg-success">Complete</span> </td>   <td> </td>  </tr>').appendTo("#tableTbody");
                                j++;
                            } else if (data[i].Status == "Processing") {
                                jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td> <span class="badge bg-danger">Assinged</span> </td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option> <option value="Work In progress">Work In progress</option> <option value="Complete">Complete</option> </select></td>  </tr>').appendTo("#tableTbody");
                                j++;
                            }
                            else {
                                jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td> <span class="badge bg-warning">Work In progress</span> </td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option> <option value="Work In progress">Work In progress</option> <option value="Complete">Complete</option> </select></td>  </tr>').appendTo("#tableTbody");
                                j++;

                            }
                        }
                    }
                }
            });

        }

        function SearchBtn() {
            getMyTask($("#reportrange").val(), $("#DropType").find(":selected").val());
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
            <br />
        </div>

        <div class="card-body">

            <div class="row mt-4">

                <div class="col-md-3">

                    <input id="reportrange" name="from" type="text" class="form-control mb-3" />
                </div>


                <div class="col-md-3">
                    <select id="DropType" class="form-select" style="border-radius: 4px;"">
                 
                        <option value="Processing">Pending</option>
                        <option value="Work in Progress">Work in Progress  </option>
                        <option value="Complete">Complete</option>
                    </select>
                </div>


                <div class="col-md-3">
                    <a href="#" class="btn btn-primary float-center" onclick="SearchBtn()"> Search... </a>

                </div>

            </div>
        </div>
    </div>

    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Task List</h5>

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
