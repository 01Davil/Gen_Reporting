<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ApprovalAttendance.aspx.cs" Inherits="ApprovalAttendance" %>


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
            $("#SaveBtn").click(function (e) {
                e.preventDefault();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/WebService.asmx/ApprovalAttendance',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    //alert(data[0].response);
                    if (data[0].response == "Yes") {
                        
                        Swal.fire({
                            icon: 'success',
                            width: '300px',
                            text: "Attendance Approved success",
                            timer: 3000
                        });
                        setTimeout(function () {
                            location.reload();
                        }, 1000)
                    }
                    
                }

            })
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
                        var ddlCustomers = $("[id*=select2]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {
                            ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                        });

                    }

                });
            });

            $('#SearchText').on('change', function () {
                var Name = $("#SearchText").val();
                if (Name == "" || Name.length < 5) {
                    GetEmployeeLeave('NA');
                } else {
                    GetEmployeeLeave(Name);
                }
            });


            const monthNames = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
            ];

            const d = new Date();
            // Check_AttebdanceGenerated
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/WebService.asmx/Admin_Check_AttendanceGenerated',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                  //  alert(data[0].response);
                    if (data[0].response == '1' || data[0].response == 1) {
                        $("#div1").show();
                        $("#div2").hide();
                        $("#SaveBtn").hide();
                        var a = " " + monthNames[d.getMonth()] + " month attendance not generated yet.";
                        $("#MyText").html(a);
                    } else if (data[0].response == '3' || data[0].response == 3) {
                        $("#div2").show();
                        $("#div1").show();
                        $("#SaveBtn").hide();
                        var a = " " + monthNames[d.getMonth()] + " month attendance has already been approved.";
                        $("#MyText").html(a);
                        GetEmployeeLeave('NA');
                    }
                    else {
                        $("#div2").show();
                        $("#SaveBtn").show();
                        $("#div1").hide();
                        GetEmployeeLeave('NA');
                    }
                }

            })
        })

     function GetEmployeeLeave(EmailID) {

            var formData = new FormData();
            formData.append("EmailID", EmailID);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/ShowAdjustLeaveDay',
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
                        $("#ShowTableWork").empty();

                    } else {
                        $("#ShowTableWork").empty();

                            jQuery('<thead><tr> <th>S.No.</th> <th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">Total Present </th><th class="d-none d-xl-table-cell">Total Absent </th> <th class="d-none d-xl-table-cell"> Adjust Day</th><th class="d-none d-xl-table-cell">Enter Adjust Day No</th><th class="d-none d-xl-table-cell">Save</th></tr></thead>').appendTo("#ShowTableWork");

                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                           
                                if (data[i].ApprovedStatus == "0" || data[i].ApprovedStatus == 0) {
                             
                                    $("#ShowTableWork").append('<tr> <td >' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TotalPresent + '</td> <td class="d-none d-xl-table-cell">' + data[i].TotalAbsent + '</td class="d-none d-xl-table-cell"> <td>' + data[i].AdjustDay + '</td class="d-none d-xl-table-cell"> <td> <div class="input-group input-group-sm m-lg-1" style="width: 200px; "> <input type="text" id=' + j + ' class="text-center form-control "  placeholder ="Enter Day Number " style="border-radius: 4px;"/></div> </td >     <td class="d-none d-xl-table-cell"> <a  class="btn  btn-sm"  id="update"' + j + ' onclick="AddPDayEmployee(' + data[i].id + ', ' + j + ') " > <i class="bi bi-save"></i>Save </a>  </td>   </tr>');

                                } else {
                                    
                                    $("#ShowTableWork").append('<tr> <td>' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].TotalPresent + '</td> <td class="d-none d-xl-table-cell">' + data[i].TotalAbsent + '</td> <td class="d-none d-xl-table-cell">' + data[i].AdjustDay + '</td> <td class="d-none d-xl-table-cell"> <br/>  <br/> </td >     <td class="d-none d-xl-table-cell">  <br/> <br/> </td>   </tr>');

                                }
                                j++;
                            }


                    }
                }
            });
        }
        // 

        function AddPDayEmployee(id, j) {
          //  alert(id)
            var i = "#" + j;
            var dayNo = $(i).val();
            if (dayNo.length == 0 || dayNo == "") {
                Swal.fire({
                    icon: 'info',
                    width: '300px',
                    text: "Please Enter Day Number",
                    timer: 3000
                });
            } else {
                if ($.isNumeric(dayNo)) {
                    var formData = new FormData();
                    formData.append("LoginSno", "<%= Session["LoginSno"].ToString()%>");
                    formData.append("id", id);
                    formData.append("DayNo", dayNo);
                    $.ajax({
                        url: 'WebServerFile/WebService.asmx/SaveAdjustLeaveDay',
                        type: 'POST',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            var j = 1;
                            if (data[0].response == 'Fail') {
                                Swal.fire({
                                    icon: 'info',
                                    width: '300px',
                                    text: "Leave  Not  adjusted."
                                });
                            } else if (data[0].response == 'success') {
                                Swal.fire({
                                    icon: 'success',
                                    width: '300px',
                                    text: "Leave success adjust"
                                });
                                GetEmployeeLeave('NA');
                            } else {
                                Swal.fire({
                                    icon: 'warning',
                                    width: '300px',
                                    text: "Adjust Day's to Current Day's"
                                });
                                GetEmployeeLeave('NA');

                            }

                        }
                    });

                } else {
                    Swal.fire({
                        icon: 'info',
                        width: '300px',
                        text: "Please enter a valid number.",
                        timer: 3000
                    });
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>ATTENDANCE APPROVAL and ADJUST</h3>
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
    <div id="div1">

        <div class="card flex-fill">
            <div class="card-header" style="text-align: center; color: red;">
                <h1 id="MyText"></h1>
            </div>
        </div>
    </div>
    <div id="div2">
        
        <div class="card flex-fill">
            <div class="card-header">
              
                  <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                   <button type="submit" id="SaveBtn" class="btn btn-primary btn-sm">Approved Attendance</button>
                </div>
              
                  
                <div class="input-group input-group-sm m-lg-1" style="width: 200px; float: right;">
                    <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                    <datalist class="MeClass" id="select2">
                    </datalist>
                </div>
                
              
            </div>
            <table id="ShowTableWork" class="table table-striped my-0 text-center">
            </table>
        </div>
    </div>
</asp:Content>
