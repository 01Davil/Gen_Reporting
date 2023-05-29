<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="Emp_Assign.aspx.cs" Inherits="Emp_Assign" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            // 
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }

            GetAssignWork();
            //Save Assign work 
               $("#BtnSave").click(function (e) {
                e.preventDefault();
                var WorkEmail = $("#EmpEmail").val();
                var ProjectName = $("#ProjectName").val();
                var TaskName = $("#TaskName").val();
                var TaskDeaDline = $("#TaskDeadline").val();
                var TaskDetails = $("#TaskDetails").val();
                var AssignEmail = "<%= Session["LoginEmail"].ToString()%>";

                if (ProjectName == " " && TaskName == " " && TaskDeaDline == "" && TaskDetails == "") {
                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: 'Enter All information.!'
                    });
                } else {
                    var formData = new FormData();
                    formData.append("WorkEmail", WorkEmail);
                    formData.append("ProjectName", ProjectName);
                    formData.append("TaskName", TaskName);
                    formData.append("TaskDeaDline", TaskDeaDline);
                    formData.append("TaskDetails", TaskDetails);
                    formData.append("AssignEmail", AssignEmail);
                    $.ajax({
                        url: 'WebServerFile/Employee_MasterService.asmx/SaveAssignWork',
                        type: 'POST',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            //alert(data);
                            $("#EmpEmail").val("");
                            $("#ProjectName").val("");
                            $("#TaskName").val("");
                            $("#TaskDeadline").val("");
                            $("#TaskDetails").val("");
                            if (data == 1) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'success',
                                    width: '300px',
                                    text: 'Employee Work Assignment Successful.!'
                                })
                                //Calling Function get Details List
                                GetAssignWork();
                                //
                                $("#EmpEmail").val("");
                                $("#ProjectName").val("");
                                $("#TaskName").val("");
                                $("#TaskDeadline").val("");
                                $("#TaskDetails").val("");
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'error',
                                    width: '300px',
                                    text: 'Employee Work Assignment Unsuccessful.!'
                                })
                            }
                        }

                    });
                }
            });
            
          
 
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

                        var ddlCustomers = $("[id*=select]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {

                            ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                        });

                    }

                });
            });
            
            $('#SearchText').on('change', function () {              
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/Employee_MasterService.asmx/GetEmployeeDetails',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        $("#EmpName").val(data[0].EmpName);
                        $("#EmpEmail").val(data[0].officeEmail);
                        $("#EmpDep").val(data[0].Department);
                    }

                });
            });

            /// Get Assign Employee Name List
            $("#ProjectSearch").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#ProjectSearch").val());
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
            
            $('#ProjectSearch').on('change', function () {
                alert($("#ProjectSearch").val());
                //var formData = new FormData();
                //formData.append("Num", $("#SelectName").val());
                //$.ajax({
                //    url: 'WebServerFile/Emp_WorkService.asmx/GetEmployeeDetails',
                //    type: 'POST',
                //    data: formData,
                //    cache: false,
                //    contentType: false,
                //    processData: false,
                //    success: function (data) {
                //        $("#EmpName").val(data[0].EmpName);
                //        $("#EmpEmail").val(data[0].officeEmail);
                //        $("#EmpDep").val(data[0].Department);
                //    }

                //});
            });
           
 
            // End
        });
        // function :  get employee List Assign Work 
        function GetAssignWork() {
            $("#ShowTableWork").empty();
             var formData = new FormData();
                formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                  formData.append("EmpEmail", "Default");
                  formData.append("Type", "A");
                  $.ajax({
                      url: 'WebServerFile/Employee_MasterService.asmx/GetEmployeeAssignWorkList',
                      type: 'POST',
                      data: formData,
                      cache: false,
                      contentType: false,
                      processData: false,
                      success: function (data) {
                          //console.log(data[0].response);
                          if (data[0].response == "Fail") {
                              Swal.fire({
                                  icon: 'error',
                                  title: 'error',
                                  width: '300px',
                                  text: 'Data Not Found.!'
                              })
                          } else {
                              var j = 1;
                              for (var i = 0; i < data.length; i++) {
                                  $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td class="d-none d-xl-table-cell" style="width:200px !important">' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td>' + data[i].Status + '</td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option> <option value="Update">Update</option> <option value="Complete">Complete</option> </select></td>  </tr>')
                                  j++;
                              }
                          }
                      }
                  });
        }
        function EmployeeFunWorking(id) {
            var a = "#" + id;
            var b = ($(a).find(":selected").val());
            alert(a + ": " + b);
            
        }

    </script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row mb-2 mb-xl-3" >
        <div class="col-auto d-none d-sm-block">
            <h3>Employee Work</h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
        </div>
    </div>


    <div class="row" id="DivWork">

        <div class="col-12 col-lg-12 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <h5 class="card-title mb-0">Assign Work</h5>
                </div>
                <div class="card-body">

                    <div class="row">
                        <div class="col-md-12">
                            <%--<label class="form-label">Task Details</label>--%>

                            <input list="select" id="SearchText" class="form-control" placeholder="Enter Employee Name" name="select" />
                            <datalist class="MeClass" id="select">
                            </datalist>
                        </div>

                    </div>
                    <hr class="mt-4">

                    <div class="row mt-4">

                        <div class="col-md-4">
                            <label class="form-label">Employee Name</label>
                            <input type="text" id="EmpName" class="form-control" disabled />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Employee Email</label>
                            <input type="text" id="EmpEmail" class="form-control" disabled />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Employee Department</label>
                            <input type="text" id="EmpDep" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-4">
                            <label class="form-label">Project Name</label>
                            <input type="text" id="ProjectName" class="form-control" value=" " placeholder="Project Name" />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Task Name</label>
                            <input type="text" id="TaskName" class="form-control" value=" " placeholder="Task Name" />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Task Deadline</label>
                            <input type="date" id="TaskDeadline" class="form-control" />
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <label class="form-label">Task Details</label>
                            <textarea class="form-control" id="TaskDetails" rows="2" placeholder="Task Details"></textarea>
                        </div>

                    </div>
                    <div class="row mt-4 mb-4">
                        <div class="col-md-12">

                            <button class="btn btn-primary float-end" type="submit" id="BtnSave">Assign Task</button>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Previous Task List</h5>
            <div class="input-group input-group-sm" style="width: 250px; float: right;">
                <input list="select2" type="text" id="ProjectSearch" class="form-control" placeholder="Search" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>
        </div>
        <div style="width: auto;height: auto;overflow-x: auto;overflow-y: auto;">
        <table id="datatables-dashboard-projects" class="table table-striped my-0  table-hover table-responsive">
            <thead>
                <tr>
                    <th>S.No.</th>
                    <th class="d-none d-xl-table-cell">Employee Name</th>
                    <th class="d-none d-xl-table-cell">Project Name</th>
                    <th class="d-none d-xl-table-cell">Task Name</th>
                    <th class="d-none d-xl-table-cell">Work</th>
                    <th class="d-none d-md-table-cell">Deadline</th>
                    <th class="d-none d-md-table-cell">Current Status</th>
                    <th class="d-none d-md-table-cell">Update Status</th>
                </tr>
            </thead>
            <tbody id="ShowTableWork">
            </tbody>
        </table>
    </div>
    </div>
    <%-- modal --%>
      <div id="WorkModal" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modal </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>This is a simple Bootstrap modal. Click the "Cancel button", "cross icon" or "dark gray area" to close or hide the modal.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>



