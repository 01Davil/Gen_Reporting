<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<%--  Noted :  --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="JsDB/jquery.js"></script>

    <script>
        $(document).ready(function () {
            $(function () {
                $("#Box1").attr("style", "display:none!important");
                $("#Box2").attr("style", "display:none!important");
                $("#Box3").attr("style", "display:none!important");
                $("#Box4").attr("style", "display:none!important");
                $("#Box5").attr("style", "display:none!important");
                $("#Box6").attr("style", "display:none!important");
                $("#Box7").attr("style", "display:none!important");
                $("#Box8").attr("style", "display:none!important");
                $("#Box9").attr("style", "display:none!important");

                var LoginType = "<%= Session["LoginType"].ToString()%>";
                var RoleID = "<%= Session["LoginRoleId"].ToString()%>";

                //alert(LoginType+" ," + RoleID);

                if (LoginType == 101 || LoginType == "101") {
                    $("#Box1").show();
                    $("#Box2").show();
                    $("#Box3").show();
                    $("#Box6").show();
                    $("#Box7").show();
                    $("#Box1Text").html(" <h5 class='card-title mb-0'>Request For Approval </h5>");

                } else if (LoginType == 102 || LoginType == "102") {
                    $("#Box1").show();
                    $("#Box2").show();
                    // $("#Box3").show();
                    $("#Box4").show();
                    // $("#Box5").show();
                    $("#Box6").show();
                    $("#Box7").show();
                    $("#Box8").show();
                    $("#Box9").show();
                    
                    $("#Box1Text").html(" <h5 class='card-title mb-0'>My Task </h5");
                }
                else if (LoginType == 103 || LoginType == "103") {
                     $("#Box1").show();
                    //$("#Box2").show();
                    $("#Box3").show();
                    $("#Box4").show();
                    // $("#Box5").show();
                    $("#Box6").show();
                    $("#Box7").show();
                    $("#Box8").show();
                    $("#Box9").show();
                    $("#Box1Text").html(" <h5 class='card-title mb-0'>My Task </h5");
                }
                else if (LoginType == 104 || LoginType == "104") {

                    if (RoleID == 3 || RoleID == "3") {
                        $("#Box1").show();
                        //$("#Box2").show();
                        $("#Box3").show();
                        $("#Box4").show();
                        $("#Box5").show();
                        $("#Box6").show();
                        $("#Box7").show();
                        $("#Box8").show();
                        $("#Box9").show();
                        $("#Box1Text").html(" <h5 class='card-title mb-0'>Request For Approval</h5");
                    } else if (RoleID == 4 || RoleID == "4") {
                        $("#Box1").show();
                        //$("#Box2").show();
                        //$("#Box3").show();
                        $("#Box4").show();
                        $("#Box5").show();
                        $("#Box6").show();
                        $("#Box7").show();
                        $("#Box8").show();
                        $("#Box9").show();
                        $("#Box1Text").html(" <h5 class='card-title mb-0'>Request For Approval </h5>");
                    }
                    else if (RoleID == 5 || RoleID == "5") {
                        // $("#Box1").show();
                        //$("#Box2").show();
                        //$("#Box3").show();
                        $("#Box4").show();
                        $("#Box5").show();
                        $("#Box6").show();
                        $("#Box7").show();
                        $("#Box8").show();
                        $("#Box9").show();
                    }
                    else {
                        $("#Box1").attr("style", "display:none!important");
                        $("#Box2").attr("style", "display:none!important");
                        $("#Box3").attr("style", "display:none!important");
                        $("#Box4").attr("style", "display:none!important");
                        $("#Box5").attr("style", "display:none!important");
                        $("#Box6").attr("style", "display:none!important");
                        $("#Box7").attr("style", "display:none!important");
                        $("#Box8").attr("style", "display:none!important");
                        $("#Box9").attr("style", "display:none!important");
                    }

                }
                else if (LoginType == 109 || LoginType == "109") {
                    // $("#Box1").show();
                    //$("#Box2").show();
                    $("#Box3").show();
                    $("#Box4").show();
                    // $("#Box5").show();
                    $("#Box6").show();
                    $("#Box7").show();
                    $("#Box8").show();
                    $("#Box9").show();
                }
                else if (LoginType == 108 || LoginType == "108") {

                    if (RoleID == 4 || RoleID == "4") {
                        $("#Box1").show();
                        //$("#Box2").show();
                        $("#Box3").show();
                        $("#Box4").show();
                        // $("#Box5").show();
                        $("#Box6").show();
                        $("#Box7").show();
                        $("#Box8").show();
                        $("#Box9").show();
                    } else //if (RoleID == 4 || RoleID == "4") 
                    {
                        // $("#Box1").show();
                        //$("#Box2").show();
                        $("#Box3").show();
                        $("#Box4").show();
                        // $("#Box5").show();
                        $("#Box6").show();
                        $("#Box7").show();
                        $("#Box8").show();
                        $("#Box9").show();
                    }


                }
                else {
                    $("#Box1").attr("style", "display:none!important");
                    $("#Box2").attr("style", "display:none!important");
                    $("#Box3").attr("style", "display:none!important");
                    $("#Box4").attr("style", "display:none!important");
                    $("#Box5").attr("style", "display:none!important");
                    $("#Box6").attr("style", "display:none!important");
                    $("#Box7").attr("style", "display:none!important");
                    $("#Box8").attr("style", "display:none!important");
                    $("#Box9").attr("style", "display:none!important");

                }

            })


            // this function Celling Page load
            $(function () {
                GetMeetingList();
                GetEvent();
                Get_RequestForApproval();
                GetEmployeeStatus();
                LeaveStatus();
                Get_WFH();
                GetTask();
                Get_Tender();
            })
        })

        // this function Celling After 7 sec Interval
        setInterval(function () {

            Get_RequestForApproval
            //GetMeetingList();
            //GetEvent();
            ////Get_Request();
            GetEmployeeStatus();
            //GetTask();
        }, 50000)


        /****************************************************************************************************************************/
        /****************************************************************************************************************************/


        function GetMeetingList() {
            $("#AdminShowMeeting").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Dashboard.asmx/GetMeetingList',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {
                        var List = " <img src='img/noMeeting.jpg' width='100%' />  ";
                        $("#AdminShowMeeting").append(List);
                    } else {
                        var j = 1;
                        var List1;
                        for (var i = 0; i < data.length; i++) {
                            List1 = "<div class='d-flex align-items-start'><img src='img/avatars/avatar.jpg' width='36' height='36' class='rounded-circle me-2' alt='Ashley Briggs'>"
                                          + "<div class='flex-grow-1'><small class='float-end'>" + data[i].date + "</small><strong> " + data[i].subject + " </strong><br>"
                                          + "   <small class='text-muted'>" + data[i].details + "</small><br>"
                                            + " </div></div><hr>";
                            $("#AdminShowMeeting").append(List1);
                            j++;
                        }
                    }
                }
            });
        }


        /****************************************************************************************************************************/
        /****************************************************************************************************************************/


        // this function get Event 
        function GetEvent() {
            $("#AdminEventsTbl").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Dashboard.asmx/GetEventList',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {

                        $("#eventDiv").empty();
                        var List = " <img src='img/noEvents.jpg' width='100%' /> ";
                        $("#eventDiv").append(List);
                        $("#eventTable").hide();

                    } else {
                        var j = 1;
                        var List1;
                        $("#eventDiv").hide();
                        for (var i = 0; i < data.length; i++) {
                            //List1 = "<li class='timeline-item'><strong>" +  + " </strong>   <span class='float-end text-muted text-sm'></span> <p> </p></li>";
                            List1 = " <tr> <td>" + data[i].EmpName + " </td><td> " + data[i].Type + "</td> <td class='text-end text-success'>" + data[i].Date + "</td></tr>"
                            $("#AdminEventsTbl").append(List1);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });

        }
        //


        /****************************************************************************************************************************/
        /****************************************************************************************************************************/


        function Get_RequestForApproval() {
       
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");            
            formData.append("Type", "Count");
            $.ajax({
                url: 'WebServerFile/Dashboard.asmx/Get_CountRequestForApproved',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {                          
                    if (data[0].response == "Fail") {
                        var List = " <img src='img/NoTask2.png' width='100%' />  ";
                        $("#myRequestCardbodyIMG").append(List);
                        $("#RequestForApprovalTable").empty();
                    } else {                              
            
                        $("#RequestForApprovalTable").empty();
                        var j = 1;                        
                        for (var i = 0; i < 5; i++) {                    
                            List1 = "<tr> <td> " + data[i].Type + " </td> <td class='text-end text-success'> <a href='#' onclick=Show_RequestForApproval(\"" + data[i].id + "\") >   " + data[i].Count + " </a> </td> </tr> <tr> </tr> ";
                            $("#RequestForApprovalTable").append(List1);
                            j++;                           
                        }
                    }
                }
            });
              }

         // modal open for request data  ViewRequestModal viewRequestHeading tblRequestData
        function Show_RequestForApproval(CounterId) {
         
          //   alert(CounterId);
                if (CounterId == 4) {
                    window.location.href = "ApprovalAttendance.aspx";
                } else if (CounterId == 5) {
                    window.location.href = "ApprovalSalary.aspx";
                }
                else if (CounterId == 6) {
                    window.location.href = "EPF.aspx";
                }

                else if (CounterId == 7) {
                    window.location.href = "ESIC.aspx";
                }
                else if (CounterId == 8) {
                    window.location.href = "GenerateAttendance.aspx";
                }
                else if (CounterId == 10) {
                    window.location.href = "ProcessSalary.aspx";
                }
                else if (CounterId == 9) {
                    window.location.href = "GenerateSalary.aspx";
                }

                else {

                    $("#tblRequestData").empty();
                    var formData = new FormData();
                    formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                    formData.append("CounterId", CounterId);
                    jQuery.ajax({
                        url: 'WebServerFile/Dashboard.asmx/Show_RequestForApproval',
                        type: 'POST',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            if (data[0].response != "Fail") {
                                if (CounterId == 1) {
                                    $("#ViewRequestModal").modal('show');
                                    $("#viewRequestHeading").text("Work From Status");
                                    $("#tblRequestData").append('<thead> <tr><th>S.No.</th><th class="d-none d-xl-table-cell">Employee Name</th><th class="d-none d-xl-table-cell">From Date </th><th class="d-none d-xl-table-cell">TO Date</th><th class="d-none d-md-table-cell">Total Day</th> <th>Leave Status</th>  <th> Option</th>  </tr> </thead>');
                                    var j = 1;
                                    var List1;
                                    for (var i = 0; i < data.length; i++) {
                                        $("#tblRequestData").append('   <tbody> <tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td> <td>' + data[i].FDate + '</td><td>' + data[i].TDate + '</td> <td>' + data[i].TotalDays + '</td> <td>' + data[i].Purpose + '</td>    <td> <select  class="form-control"   onchange="ApprovalWFH(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr>   </tbody>')
                                        j = j + 1;
                                    }
                                }
                                else if (CounterId == 2) {
                                    $("#ViewRequestModal").modal('show');
                                    $("#viewRequestHeading").text("Leave Status")
                                    $("#tblRequestData").append('<thead> <tr> <th>S.No.</th> <th class="d-none d-xl-table-cell">Employee Name</th> <th class="d-none d-xl-table-cell">Leave Type</th> <th class="d-none d-xl-table-cell">From Date</th> <th class="d-none d-xl-table-cell">TO Date</th> <th class="d-none d-xl-table-cell">Total Day</th> <th class="d-none d-md-table-cell">Purpose</th> <th class="d-none d-md-table-cell" id="my">Option</th> </tr> </thead>');
                                    var j = 1;
                                    var List1;
                                    for (var i = 0; i < data.length; i++) {
                                        $("#tblRequestData").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td>     <td> <select  class="form-control"   onchange="ApprovedLeave(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr> </tbody>');
                                        j = j + 1;
                                    }
                                }
                                else //if (CounterId == 3)
                                {
                                    $("#ViewRequestModal").modal('show');
                                    $("#viewRequestHeading").text("Expense Status")
                                    $("#tblRequestData").append('<thead> <tr> <th>S.No.</th> <th class="d-none d-xl-table-cell">Employee Name</th> <th class="d-none d-xl-table-cell">Expense Type</th>  <th class="d-none d-xl-table-cell">Amount</th> <th class="d-none d-xl-table-cell">Purpose</th>  <th class="d-none d-md-table-cell" id="my">Option</th> </tr> </thead>');
                                    var j = 1;
                                    var List1;
                                    for (var i = 0; i < data.length; i++) {
                                        //  $("#tblRequestData").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeExp + '</td> <td>' + data[i].ApplyDate + '</td><td>' + data[i].Amount + '</td> <td>' + data[i].Purpose + '</td>   <td><span class="badge bg-warning">Processing</span></td>    <td> <select  class="form-control"   onchange="ApprovedExpenese(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr> </tbody>');
                                        jQuery('<tbody> <td style=" display :none;"> ' + data[i].URL + '</td> <td style=" display :none;"> ' + data[i].id + '</td>'
                                        + '<tr> <td>' + j + '</td><td>' + data[i].EmpName + '</td> <td>' + data[i].TypeExp + '</td><td>' + data[i].Amount + '</td> <td>' + data[i].Purpose + '</td>    <td> <select  class="form-control"   onchange="ApprovedExpenese(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td> '
                                        //<a herf="#" class="btn btn-sm btn-primary" onclick="UpdatePayStatus(' + data[i].id + ')">Update Payment</a> 
                                      + '<td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; </td>'
                                      + '</tr>  </tbody> ').appendTo("#tblRequestData");

                                        j = j + 1;
                                    }
                                }



                            }
                            else {
                                //alert('No Record Found');
                                Swal.fire({
                                    icon: 'error',
                                    title: 'error',
                                    width: '300px',
                                    text: 'Data Not Found.!'
                                })
                            }
                        },
                        error: function (data) {
                            alert("fail");
                            //$('#load').hide();
                        }
                    });

                }
            
        }


        /****************************************************************************************************************************/
        /****************************************************************************************************************************/

        
       // 
       function ApprovedLeave(id) {
           // Drop

            var a = "#Drop" + id;
            var Status = $("  " + a + " option:selected").val().trim();
//            alert(id + " " + Status);
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
                     url: 'WebServerFile/WebService.asmx/ApproveLevae',
                     type: 'POST',
                     data: formData,
                     cache: false,
                     contentType: false,
                     processData: false,
                     success: function (data) {
                         if (data = "Save") {
                             Swal.fire({
                                 icon: 'success',
                                 //title: 'info',
                                 width: '300px',
                                 text: " Leave Update success",
                                 timer: 3000
                             });
                             Get_RequestForApproval();
                         } else {
                             Swal.fire({
                                 icon: 'info',
                                 //title: 'info',
                                 width: '300px',
                                 text: " Leave Not Update",
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

            function ApprovalWFH(id) {
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
                            Get_RequestForApproval();
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

        

         function ApprovedExpenese(id) {
             var a = "#Drop" + id;
             
           var Status = $("  " + a + " option:selected").val().trim();
           //            alert(id + " " + Status);
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
                   url: 'WebServerFile/WebService.asmx/ApprovedStatusExpenese',
                   type: 'POST',
                   data: formData,
                   cache: false,
                   contentType: false,
                   processData: false,
                   success: function (data) {
                       if (data = "Save") {
                           Swal.fire({
                               icon: 'success',
                               //title: 'info',
                               width: '300px',
                               text: " Leave Update success",
                               timer: 3000
                           });
                          // Show_RequestForApproval();
                           Get_RequestForApproval();
                       } else {
                           Swal.fire({
                               icon: 'info',
                               //title: 'info',
                               width: '300px',
                               text: " Leave Not Update",
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

              /****************************************************************************************************************************/
              /****************************************************************************************************************************/


              // get employee Status
              function GetEmployeeStatus() {
                  $("#AttendanceStatusAllEmployee").empty();
                  var formData = new FormData();
                  formData.append("Type", "EmployeeStatus");
                  $.ajax({
                      url: 'WebServerFile/Dashboard.asmx/EmployeeStatusAllType',
                      type: 'POST',
                      data: formData,
                      cache: false,
                      contentType: false,
                      processData: false,
                      success: function (data) {
                          if (data[0].response == "Fail") {
                              var List = "<tr> <td> <strong>No Details Found ?</strong>  </td> </tr>"
                              $("#AttendanceStatusAllEmployee").append(List);
                          } else {
                              var j = 1;
                              var List1;
                              for (var i = 0; i < data.length; i++) {
                                  List1 = "<tr> <td> " + data[i].Type + " </td> <td class='text-end text-success'> <a href='#' onclick=openAttmodel(\"" + j + "\") >   " + data[i].Count + " </a> </td> </tr> <tr> </tr> ";
                                  $("#AttendanceStatusAllEmployee").append(List1);
                                  j++;
                              } // end for loop 
                              // App
                          }
                      }
                  });
              }



              /****************************************************************************************************************************/
              /****************************************************************************************************************************/

              /// Attendance Status modal
              function openAttmodel(j) {
                  var type = j;
                  $("#tblAttendanceData").empty();
                  var formData = new FormData();
                  formData.append("Type", type);
                  jQuery.ajax({
                      url: 'WebServerFile/Hr_MasterWebService.asmx/EmployeeAttendanceStatus',
                      type: 'POST',
                      data: formData,
                      cache: false,
                      contentType: false,
                      processData: false,
                      success: function (data) {
                          if (data[0].response != "Fail") {
                              $("#ViewAttendanceModal1").modal('show');
                              if (type == 2) {
                                  $("#tblAttendanceData1").append('<thead> <tr> <th>S.No.</th> <th>Employee Name </th> <th class="d-none d-xl-table-cell">Departemnt </th>   </tr> </thead>');
                                  var j = 1;
                                  var List1;
                                  for (var i = 0; i < data.length; i++) {
                                      $("#tblAttendanceData1").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].Name + '</td>  <td>' + data[i].Department + '  </tr> </tbody>');
                                      j = j + 1;
                                  }
                              }
                              else if (type == 5) {
                                  $("#tblAttendanceData1").append('<thead> <tr> <th>S.No.</th> <th>Employee Name </th> <th class="d-none d-xl-table-cell">Days </th>  <th class="d-none d-xl-table-cell">Purpose </th> <th class="d-none d-xl-table-cell"> Leave Status </th>   <th class="d-none d-xl-table-cell">Approved By </th> </tr> </thead>');
                                  var j = 1;
                                  var List1;
                                  for (var i = 0; i < data.length; i++) {
                                      $("#tblAttendanceData1").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].Name + '</td>  <td>' + data[i].TotalDay + '</td><td>' + data[i].Purpose + '</td><td>' + data[i].Status + '</td><td>' + data[i].ApproveName + '  </tr> </tbody>');
                                      j = j + 1;
                                  }
                              }
                              else {

                                  $("#tblAttendanceData1").append('<thead> <tr> <th>S.No.</th> <th>Employee Name </th> <th class="d-none d-xl-table-cell">Login </th> <th class="d-none d-xl-table-cell">Logout</th><th class="d-none d-xl-table-cell">Attendance Type</th>  </tr> </thead>');
                                  var j = 1;
                                  var List1;
                                  for (var i = 0; i < data.length; i++) {
                                      $("#tblAttendanceData1").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].Name + '</td>  <td>' + data[i].LoginTime + '</td> <td>' + data[i].LogOutTime + '</td><td>' + data[i].AttType + '  </tr> </tbody>');
                                      j = j + 1;
                                  }
                              }

                          }
                          else {
                              //alert('No Record Found');
                              Swal.fire({
                                  icon: 'error',
                                  title: 'error',
                                  width: '300px',
                                  text: 'Data Not Found.!'
                              })
                          }
                      },
                      error: function (data) {
                          alert("fail");
                          //$('#load').hide();
                      }
                  });
              }

        /****************************************************************************************************************************/
        /****************************************************************************************************************************/


              function LeaveStatus() {
                  $("#LeaveStatusTbl").empty();
                  var formData = new FormData();
                  formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/GetAvailableLeave',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {

                    } else {
                        $("#UEL").text(data[0].UEL);
                        $("#UCL").text(data[0].UCL);
                        $("#USL").text(data[0].USL);
                        //Available
                        $("#AEL").text(data[0].EL);
                        $("#ACL").text(data[0].CL);
                        $("#ASL").text(data[0].SL);


                    }
                }
            });
        }


        /****************************************************************************************************************************/
        /****************************************************************************************************************************/


        function Get_WFH() {
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/GetAvailableWFH',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    $("#Available").text(data[0].Available);
                    $("#Used").text(data[0].Used);

                    $("#Pending").text(data[0].Pending);
                    $("#Approved").text(data[0].Approved);

                    $("#Reject").text(data[0].Reject);
                }
            });
        }



        /****************************************************************************************************************************/
        /****************************************************************************************************************************/



        function GetTask() {
            //debugger;
            $("#MyTaskimg").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("Type", "Processing");
            formData.append("Date", "NA");
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/GetEmployeeAssignDetails',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data[0].response == "Fail") {
                            var List = " <img src='img/NoTask2.png' width='100%' />  ";

                            $("#MyTaskimg").append(List);

                        } else {
                            for (var i = 0; i < 4; i++) {
                                var List1 = "<ul class='timeline'> <li class='timeline-item'> <strong title='Project Name'> " + data[i].ProjectName + "</strong>  <span class='float-end  text-sm btn-sm btn-warning'> " + data[i].Status + "</span>  <p title='Task Details'>" + data[i].TaskName + "</p> </li>  </ul>";
                                $("#MyTaskimg").append(List1);

                            }
                        }
                    }
                });
            }




            /****************************************************************************************************************************/
            /****************************************************************************************************************************/


            /// Attendance Status modal vishnu ViewAttendanceModal tblAttendanceData
            function openAttmodel(j) {
                debugger;
                var type = j;
                $("#tblAttendanceData").empty();
                var formData = new FormData();
                formData.append("Type", type);
                jQuery.ajax({
                    url: 'WebServerFile/Hr_MasterWebService.asmx/EmployeeAttendanceStatus',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data[0].response != "Fail") {
                            $("#ViewAttendanceModal").modal('show');
                            if (type == 2) {
                                $("#tblAttendanceData").append('<thead> <tr> <th>S.No.</th> <th>Employee Name </th> <th class="d-none d-xl-table-cell">Departemnt </th>   </tr> </thead>');
                                var j = 1;
                                var List1;
                                for (var i = 0; i < data.length; i++) {
                                    $("#tblAttendanceData").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].Name + '</td>  <td>' + data[i].Department + '  </tr> </tbody>');
                                    j = j + 1;
                                }
                            }
                            else if (type == 5) {
                                $("#tblAttendanceData").append('<thead> <tr> <th>S.No.</th> <th>Employee Name </th> <th class="d-none d-xl-table-cell">Days </th>  <th class="d-none d-xl-table-cell">Purpose </th> <th class="d-none d-xl-table-cell"> Leave Status </th>   <th class="d-none d-xl-table-cell">Approved By </th> </tr> </thead>');
                                var j = 1;
                                var List1;
                                for (var i = 0; i < data.length; i++) {
                                    $("#tblAttendanceData").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].Name + '</td>  <td>' + data[i].TotalDay + '</td><td>' + data[i].Purpose + '</td><td>' + data[i].Status + '</td><td>' + data[i].ApproveName + '  </tr> </tbody>');
                                    j = j + 1;
                                }
                            }
                            else {

                                $("#tblAttendanceData").append('<thead> <tr> <th>S.No.</th> <th>Employee Name </th> <th class="d-none d-xl-table-cell">Login </th> <th class="d-none d-xl-table-cell">Logout</th><th class="d-none d-xl-table-cell">Attendance Type</th>  </tr> </thead>');
                                var j = 1;
                                var List1;
                                for (var i = 0; i < data.length; i++) {
                                    $("#tblAttendanceData").append('<tbody> <tr><td>' + j + '</td> <td>' + data[i].Name + '</td>  <td>' + data[i].LoginTime + '</td> <td>' + data[i].LogOutTime + '</td><td>' + data[i].AttType + '  </tr> </tbody>');
                                    j = j + 1;
                                }
                            }

                        }
                        else {
                            //alert('No Record Found');
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                width: '300px',
                                text: 'Data Not Found.!'
                            })
                        }
                    },
                    error: function (data) {
                        alert("fail");
                        //$('#load').hide();
                    }
                });
            }



            /****************************************************************************************************************************/
            /****************************************************************************************************************************/

        // get tender 
        function Get_Tender() {                     
                $("#AdminTenderList").empty();
               var formData = new FormData();
               formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                  $.ajax({
                      url: 'WebServerFile/Dashboard.asmx/Get_TenderList',
                      type: 'POST',
                      data: formData,
                      cache: false,
                      contentType: false,
                      processData: false,
                      success: function (data) {
                       if (data[0].response == "Fail") {
                           $("#AdminTenderList").empty();                           
                           var List = "<tr> <td align='center'> NO Record Here </td> </tr>"
                           $("#AdminTenderList").append(List);
                       } else {

                           $("#T_PENDING").html(data[0].count);
                           $("#T_WIN").html(data[1].count);
                           $("#T_LOST").html(data[2].count);
                           
                           // var j = 1;
                          // var List1;
                           //for (var i = 0; i < data.length; i++) {                                
                           //    List1 = "<tr> <td> " + data[i].Name + " </td> <td class='text-center' > <b class='text-info'> " + data[i].count + " </b></tr> ";
                           //    $("#AdminTenderList").append(List1);
                           //    j++;
                           //}
                           //List2 = "<tr><td class='text-end text-danger'>&nbsp;</td>" + "<td class='text-end text-success'>&nbsp;</td> +</tr>" + "<tr> <td>&nbsp;</td>" + "<td class='text-end text-danger'>&nbsp;</td>" + "<td class='text-end text-success'>&nbsp;</td> +</tr>";
                           //$("#AdminTenderList").append(List2);

                           // end for loop 
                           // App
                       }
                   }
                  });
        }
        /****************************************************************************************************************************/
        /****************************************************************************************************************************/

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row">

            <div class="col-12 col-lg-4 d-flex" id="Box1">
            <div class="card flex-fill w-100">
                <div class="card-header" id="Box1Text">                   
                   
                </div>                                    
                <div class="card-body" id="">                    
                     <div id="myRequestCardbodyIMG"></div>                    
                     
                <table class="table table-striped my-0">
                  <%--  <thead>
                        <tr>
                            <th>Type</th>
                            <th class="text-end">Count</th>                                    
                        </tr>
                    </thead>--%>
                    <tbody id="RequestForApprovalTable"></tbody>
                </table>
                       </div> 
            </div>
        </div>
     
        <%-- End Request for Approval --%>


        <div class="col-12 col-xl-4 d-none d-xl-flex" id="Box2">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">All Employee Status</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
                                    <th>Type</th>
                                    <th class="text-end">Days</th>
                                </tr>
                            </thead>
                            <tbody id="AttendanceStatusAllEmployee">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%-- End Employee Status --%>


        <div class="col-12 col-xl-4 d-none d-xl-flex" id="Box3">
            <div class="card flex-fill w-100">
                <div class="card-header">
                      <a href="ListTener.aspx">  <span class="badge bg-info float-end" id="Span1">View All</span> </a>   
                    <h5 class="card-title mb-0">Tender Details</h5>
                </div>
                <div class="card-body d-flex pt-0">
                   <div class="card-body">
                    <ul class="timeline">
                        <li class="timeline-item">
                     
                              <strong class="text-end text-primary">PENDING</strong>
                            <span class="float-end text-sm text-primary" id="T_PENDING"></span>
                            <p><br /></p>
                        </li>
                        <li class="timeline-item">
                      

                                          <strong class="text-end text-info">WIN</strong>
                            <span class="float-end text-sm text-info" id="T_WIN"></span>
   
                            <p><br /></p>
                        </li>
                        <li class="timeline-item">
                                     <strong class="text-end text-warning">LOST</strong>
                            <span class="float-end text-sm text-warning" id="T_LOST"></span>
   
                            <p><br /></p>
                        </li>
                        


                    </ul>
                </div>

                    <%--  <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
                                    <th>Tender Category</th>
                                    <th>Count</th>
                                </tr>
                            </thead>
                            <tbody id="AdminTenderList">
                            </tbody>
                        </table>
                    </div>--%>
                </div>
            </div>
        </div>
        <%-- End Tander --%>

       <%-- <div class="col-12 col-lg-4 d-flex" id="Box4">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <a href="#" id="RequestBtn"><span class="badge bg-info float-end">View All Task</span> </a>
                    <h5 class="card-title mb-0">My Request </h5>
                </div>
                <div class="card-body" id="myRequestCardbody">
                    <div id="myRequestCardbodyIMG"></div>
                </div>
                <table class="table table-striped my-0" id="myRequesttbl"></table>
            </div>
        </div>--%>
        <%-- End Request BOX --%>


        <div class="col-12 col-lg-4 d-flex" id="Box5">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <a href="MyTask.aspx" id="myTaskBtn"><span class="badge bg-info float-end">View All Task</span> </a>
                    <h5 class="card-title mb-0">My Tasks</h5>
                </div>
                <div class="card-body">
                    <div id="MyTaskimg">
                    </div>
                </div>

            </div>
        </div>


        <%-- MY TASK --%>


        <div class="col-12 col-lg-4 d-flex" id="Box6">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Meetings</h5>
                </div>
                <div class="card-body">

                    <div id="AdminShowMeeting"></div>

                </div>
            </div>
        </div>

        <%-- End Meeting Box --%>

        <div class="col-12 col-xl-4 d-none d-xl-flex" id="Box7">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end" id="Span2">Today</span>
                    <h5 class="card-title mb-0">Events</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <br />
                        <div id="eventDiv" align="center">
                        </div>

                        <table class="table mb-0 mt-1" id="eventTable">
                            <thead>
                                <tr>
                                    <th>Employee Name</th>
                                    <th>Occasion</th>
                                    <th class="text-end">Date</th>
                                </tr>
                            </thead>
                            <tbody id="AdminEventsTbl">
                            </tbody>
                        </table>


                    </div>
                </div>
            </div>
        </div>


        <%-- End Event Box --%>
        <div class="col-12 col-lg-6 col-xl-4 d-flex" id="Box8">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <div class="card-actions float-end">
                        <div class="dropdown position-relative">
                            <a href="#" data-bs-toggle="dropdown" data-bs-display="static">
                                <i class="align-middle" data-feather="more-horizontal"></i>
                            </a>
                        </div>
                    </div>
                    <h5 class="card-title mb-0">My Leave Status</h5>
                </div>
                <div class="card-body">
                                 <div class="align-self-center w-100">
                     <table class="table mb-0 mt-1">
                                <thead>
                                    <tr>
                                        <th>Leave Type
                                        </th>
                                        <th class="text-end">Used
                                        </th>
                                        <th class="text-end">Available
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <i class="fas fa-square-full text-primary"></i>Casual Leave
                                        </td>
                                        <td class="text-end text-danger" id="UCL">3
                                        </td>
                                        <td class="text-end text-success" id="ACL"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <i class="fas fa-square-full text-warning"></i>Sick Leave
                                        </td>
                                        <td class="text-end text-danger" id="USL">1
                                        </td>
                                        <td class="text-end text-success" id="ASL"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <i class="fas fa-square-full text-danger"></i>Earned Leave
                                        </td>
                                        <td class="text-end text-danger" id="UEL">1
                                        </td>
                                        <td class="text-end text-success" id="AEL"></td>
                                    </tr>
                                    <tr>
                                        <%--        
                                        <td>
                                    <i class="fas fa-square-full text-dark"></i>Extra Leaves
                                        </td>
                                        <td class="text-end text-danger">
                                            2
                                        </td>
                                        <td class="text-end text-success">
                                            0
                                        </td>--%>
                                    </tr>
                                </tbody>
                            </table>
                                     </div>
              <%--      <ul class="timeline text-center">
                        <li class="timeline-item col-md-12" style="display: flex; justify-content: space-between;">
                            <div class="col-md-3">  <strong class="text-primary"> Status </strong> </div>
                            <div class="col-md-3"><strong class="text-primary"> CL </strong></div>
                            <div class="col-md-3"><strong class="text-primary"> SL </strong></div>
                            <div class="col-md-3"><strong class="text-primary"> EL </strong></div>
                            <p><br /></p>
                        </li>
                    </ul>--%>

                   <%--     <ul class="timeline">
                        <li class="timeline-item">
                    

                            <strong class="text-primary">Available</strong>
                            <span class=" text-sm text-primary" id="">0</span>
                            <span class=" text-sm text-primary" id="">0</span>
                            <span class=" text-sm text-primary" id="">0</span>
                            <p><br /></p>
                        </li>
                                     </ul>--%>
             
                </div>
            </div>
        </div>

        <%-- End Leave Status --%>

        <div class="col-12 col-lg-6 col-xl-4 d-flex" id="Box9">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <div class="card-actions float-end">
                        <div class="dropdown position-relative">
                            <a href="#" data-bs-toggle="dropdown" data-bs-display="static">
                                <i class="align-middle" data-feather="more-horizontal"></i>
                            </a>
                        </div>
                    </div>
                    <h5 class="card-title mb-0">My Work From Home Status</h5>
                </div>
                <div class="card-body">
                    <ul class="timeline">
                        <li class="timeline-item">
                     

                                        <strong class="text-end text-primary">Available</strong>
                            <span class="float-end text-sm text-primary" id="Available"></span>
                            <p><br /></p>
                        </li>
                        <li class="timeline-item">
                      

                                          <strong class="text-end text-info">Used</strong>
                            <span class="float-end text-sm text-info" id="Used"></span>
   
                            <p><br /></p>
                        </li>
                        <li class="timeline-item">
                                     <strong class="text-end text-warning">Pending</strong>
                            <span class="float-end text-sm text-warning" id="Pending"></span>
   
                            <p><br /></p>
                        </li>
                        <li class="timeline-item">
                            <strong class="text-end text-success">Approved</strong>
                            <span class="float-end text-sm text-success" id="Approved"></span>
                            <p><br /></p>
                        </li>

                        <li class="timeline-item">
                                    <strong class="text-end text-danger">Reject</strong>
                            <span class="float-end text-sm text-danger" id="Reject"></span>
     
                            <p><br /></p>
                        </li>


                    </ul>
                </div>
            </div>
        </div>

        <%-- End WFH STATUS --%>
    </div>

    <%-- ******************************************************************************************************************************************* --%>
    <%-- ******************************************************************************************************************************************* --%>
    <%-- ******************************************************************************************************************************************* --%>


    <%-- Modal View All Task --%>
    <div class="modal fade" id="ViewRequestModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Request </h5>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-1" style="margin-top: 0 !important;">

                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1 text-center" id="tblRequestData">
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                </div>
            </div>
        </div>
    </div>


    <%--start modal for attendance--%>
    <div class="modal fade" id="ViewAttendanceModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Employee Status </h5>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-1" style="margin-top: 0 !important;">

                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1" id="tblAttendanceData">
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                </div>
            </div>
        </div>
    </div>


     <%--start modal for attendance--%>     
    <div class="modal fade" id="ViewAttendanceModal1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title">Employee Status </h5>
             
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body m-1" style="margin-top:0 !important;">
              
                <div class="align-self-center w-100">                                        
                    <table class="table mb-0 mt-1" id="tblAttendanceData1">                    
                    </table>
                </div>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                
            </div>
            </div>
        </div>
    </div>

</asp:Content>

