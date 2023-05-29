﻿<%@ Page Title="" Language="C#" MasterPageFile="~/HRMasterPage.master" AutoEventWireup="true" CodeFile="Hr_HomePage.aspx.cs" Inherits="Hr_HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script src="JsDB/bootstrap.js"></script>
    <script src="JsDB/javascript.js"></script>
    <script>
        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }
            $(function () {
                EmployeeStatus();
                LeaveStatus();
                Get_HolidayList();
                GetMeetingList();
                GetEvent();
                TodayTask();
                GetNews();
            });
        });
        // get employee Status
        function EmployeeStatus() {
            $("#AttendanceStatusAllEmployee").empty();
            var formData = new FormData();
            formData.append("Type", "EmployeeStatus");
            $.ajax({
                url: 'WebServerFile/Hr_MasterWebService.asmx/EmployeeStatusAllType',
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
                            List1 = "<tr> <td> "+ data[i].Type +" </td> <td class='text-end text-success'> <a href='#' onclick=openAttmodel(\"" + j + "\") >   "+data[i].Count+" </a> </td> </tr> <tr> </tr> ";                            
                            $("#AttendanceStatusAllEmployee").append(List1);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });
        }
        /// Attendance Status modal
        function openAttmodel(type) {                                        
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
	                    $("#ASModal").modal('show');  
                        $("#tblASModal").empty();                                      	
	                    var j = 1;
	                    var List1; 
	                    for (var i = 0; i < data.length; i++) {
		                    List1 = "<tr><td>" + j + "</td><td>" + data[i].Name + "</td><td>" + data[i].AttendanceDate +"</td></tr>";
		                    $("#tblASModal").append(List1);
		                    j = j + 1;
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

        // get employee Status
        function LeaveStatus() {
            $("#LeaveStatusTbl").empty();
            var formData = new FormData();
            formData.append("Type", "LeaveStatus");
            $.ajax({
                url: 'WebServerFile/Hr_MasterWebService.asmx/EmployeeStatusAllType',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {

                        //var List = "<li class='timeline-item'><strong>No Details Found ?</strong>  <p></p></li>";
                        var List = "<tr> <td>  <strong>No Details Found ?</strong>  </td> </td>";
                        $("#LeaveStatusTbl").append(List);
                    } else {
                        var j = 1;
                        var List1;
                        for (var i = 0; i < data.length; i++) {
                           // List1 = "<li class='timeline-item'><strong>" + data[i].Type + " </strong>   <span class='float-end text-muted text-sm'> " + data[i].Count + "</span> <p> </p></li>"; <td class="text-end text-success">1</td>
                            if(data[i].Type == "Half Day"){
                                List1 = "<tr> <td> <i class='fas fa-square-full text-primary'></i> "+  data[i].Type  +"  </td> <td class='text-end text-success'> <a href='#' onclick=opencompmodel(\"" + 0 + "\") >  "+ data[i].Count +" </a></td>  </tr>";
                            }
                            else if(data[i].Type == "Casual Leave") {
                                List1 = "<tr> <td> <i class='fas fa-square-full text-warning'></i> "+  data[i].Type  +"  </td> <td class='text-end text-success'> <a href='javascript:;' onclick=opencompmodel(\"" + 1 + "\")> "+ data[i].Count +" </a></td>  </tr>";
                            }
                            else if(data[i].Type == "Sick Leave") {
                                List1 = "<tr> <td> <i class='fas fa-square-full text-dark'></i> "+  data[i].Type  +"  </td> <td class='text-end text-success'> <a href='javascript:;' onclick=opencompmodel(\"" + 2 + "\")> "+ data[i].Count +" </a></td>  </tr>";
                            }
                            else if(data[i].Type == "Earned Leave") {
                                List1 = "<tr> <td> <i class='fas fa-square-full text-danger'></i> "+  data[i].Type  +"  </td> <td class='text-end text-success'> <a href='javascript:;' onclick=opencompmodel(\"" + 3 + "\")>' "+ data[i].Count +" </a></td>  </tr>";
                                
                            }
                            else {
                                List1 = "<tr> <td> <strong> "+  data[i].Type  +" </strong>  </td> <td class='text-end text-success'> <a href='javascript:;' onclick=opencompmodel(\"" + 4 + "\")> "+ data[i].Count +" </a> </td>  </tr>";
                                 
                            }
                            $("#LeaveStatusTbl").append(List1);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });
        }

        // modal cdoe for leave status
        function opencompmodel(type) {                   
            //debugger
            var formData = new FormData();
            formData.append("Type", type);            
            jQuery.ajax({
                url: 'WebServerFile/Hr_MasterWebService.asmx/EmployeeLeaveStatus',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {         
                    if (data[0].response != "Fail") {
                        $("#LSModal").modal('show');                                        
                        $("#tblLSModal").empty();
                        var List1;                        
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                         var List1 = "<tr><td>" + j + "</td><td>" + data[i].Name + "</td><td>" + data[i].TotalDay + "</td><td>" + data[i].ApproveBy + "</td><td>" + data[i].FromDate + "</td><td>"+ data[i].ToDate+"</td><td>"+ data[i].status  +"</td></tr>";
                            $("#tblLSModal").append(List1);
                            j = j + 1;
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
                }
            });
        }
        // get HoliDay Lsit this month
        function Get_HolidayList() {
            $("#holidayListTbl").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("Type", "Month");
                  $.ajax({
                      url: 'WebServerFile/Employee_MasterService.asmx/Get_HolidayList',
                      type: 'POST',
                      data: formData,
                      cache: false,
                      contentType: false,
                      processData: false,
                      success: function (data) {
                          if (data[0].response == "Fail") {                              
                              $("#holidayListTbl").empty();
                              var List = "<tr> <td> <strong> No Holiday Available in this Month </strong>  </td> </tr>"
                              $("#holidayListTbl").append(List);
                              
                          } else {
                              var j = 1;
                              var List1;
                              if(data.length == 1)
                              {
                                    $("#btnHolidayList").hide();
                                    for (var i = 0; i < data.length; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> <tr> <td> &nbsp; </td> <td> &nbsp;</td> </tr> <tr> <td> &nbsp; </td> <td> &nbsp;</td> </tr> " ;
                                      $("#holidayListTbl").append(List3);
                                      j++;
                                    } 
                              }                              
                              else if(data.length == 2)
                                {
                                    $("#btnHolidayList").hide();
                                    for (var i = 0; i < data.length; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr>  </tr>" ;
                                      $("#holidayListTbl").append(List3);
                                      j++;
                                    } 
                                }
                                else if(data.length == 3)
                                {
                                   $("#btnHolidayList").hide();
                                    for (var i = 0; i < data.length; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                      $("#EmpHolidayListTbl").append(List3);
                                      j++;
                                    } 
                                }
                                else
                                {
                                    $("#btnHolidayList").show();
                                    for (var i = 0; i < 3; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                      $("#holidayListTbl").append(List3);
                                      j++;
                                    }
                                }                              
                          }
                      }
                  });
              }
              // open modal for holiday list
              function openFun(){
               $("#sizedModalLg").modal('show');
               $("#holidayListTbl1").empty();
                var formData = new FormData();
                formData.append("Type", "All");
                  $.ajax({
                      url: 'WebServerFile/Employee_MasterService.asmx/Get_HolidayList',
                      type: 'POST',
                      data: formData,
                      cache: false,
                      contentType: false,
                      processData: false,
                      success: function (data) {
                          if (data[0].response == "Fail") {                              
                              var List  = "<tr> <td> <strong> No Holiday </strong>  </td> </tr>"
                              $("#holidayListTbl1").append(List);
                          } else {
                              var j = 1;
                              var List1;                              
                                for (var i = 0; i < data.length; i++) {                                    
                                    List3 = "<tr> <td> "+ j +"  </td> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                    $("#holidayListTbl1").append(List3);
                                    j++;
                                } // end for loop                      
                              // App
                          }
                      }
                  });    
           }
              // Get Employee Event List
              function GetEvent() {
                  $("#EventsTbl").empty();
                  var formData = new FormData();
                  formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/Get_EventList',
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
                            List1=      " <tr> <td>"+data[i].EmpName+" </td><td> " + data[i].Type + "</td> <td class='text-end text-success'>" + data[i].Date + "</td></tr>"
                            $("#EventsTbl").append(List1);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });

        }
        // get Meeting List
        function GetMeetingList() {
            $("#ShowMeeting").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
               $.ajax({
                   url: 'WebServerFile/Employee_MasterService.asmx/Get_MeetingList',
                   type: 'POST',
                   data: formData,
                   cache: false,
                   contentType: false,
                   processData: false,
                   success: function (data) {
                       if (data[0].response == "Fail") {
                           var List = " <img src='img/noMeeting.jpg' width='100%' />  ";
                           $("#ShowMeeting").append(List);
                       } else {
                           var j = 1;
                           var List1;
                           for (var i = 0; i < data.length; i++) {                               
                               List1 ="<div class='d-flex align-items-start'><img src='img/avatars/avatar.jpg' width='36' height='36' class='rounded-circle me-2' alt='Ashley Briggs'>"
                                             +"<div class='flex-grow-1'><small class='float-end'>"+data[i].date+"</small><strong> "+data[i].subject+" </strong><br>"
                                             +"   <small class='text-muted'>"+data[i].details+"</small><br>"
                                               +" </div></div><hr>";
                               $("#ShowMeeting").append(List1);
                               j++;
                           } // end for loop 
                           // App
                       }
                   }
               });

           }
           // Today's Task
           // get employee Status
           function TodayTask() {
               $("#TodayTask").empty();
               var formData = new FormData();
               formData.append("Type", "TodayTask");
               $.ajax({
                   url: 'WebServerFile/Hr_MasterWebService.asmx/EmployeeStatusAllType',
                   type: 'POST',
                   data: formData,
                   cache: false,
                   contentType: false,
                   processData: false,
                   success: function (data) {
                       if (data[0].response == "Fail") {
                           var List = "<li class='timeline-item'><strong>No Details Found ?</strong>  <p></p></li>";
                           $("#TodayTask").append(List);
                       } else {
                           var j = 1;
                           var List1;
                           for (var i = 0; i < data.length; i++) {
                               List1 = "<li class='timeline-item'><strong>" + data[i].Type + " </strong>   <span class='float-end text-muted text-sm'> " + data[i].Date + "</span> <p> </p></li>";
                               $("#TodayTask").append(List1);
                               j++;
                           } // end for loop                            
                       }
                   }
               });
           }
           // 
           

           // getNews data
           function GetNews() {
              var List = " <img src='img/NoNews.jpg' width='100%' />  ";    
                $("#newsData").append(List);
           }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Dashboard</h3>
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

    <div class="row">
       <%-- <div class="col-12 col-lg-4 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Tasks</h5>
                </div>
                <table class="table table-striped my-0">
                    <thead>
                        <tr>
                            <th>Task</th>
                            <th class="d-none d-xl-table-cell w-75">% Done</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>GenReporting Home Page</td>
                            <td class="d-none d-xl-table-cell">
                                <div class="progress">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 43%;" aria-valuenow="43" aria-valuemin="0" aria-valuemax="100">43%</div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>en-gb</td>
                            <td class="d-none d-xl-table-cell">
                                <div class="progress">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 27%;" aria-valuenow="27" aria-valuemin="0" aria-valuemax="100">27%</div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>fr-fr</td>
                            <td class="d-none d-xl-table-cell">
                                <div class="progress">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 22%;" aria-valuenow="22" aria-valuemin="0" aria-valuemax="100">22%</div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>es-es</td>
                            <td class="d-none d-xl-table-cell">
                                <div class="progress">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 16%;" aria-valuenow="16" aria-valuemin="0" aria-valuemax="100">16%</div>
                                </div>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>--%>
        
        <%--  1st card  --%>
        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                   <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Leave Status</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
                                    <th>Leave Type</th>
                                    <th class="text-end">Used</th>                                    
                                </tr>
                            </thead>
                            <tbody id="LeaveStatusTbl">
                                <%--<tr>
                                    <td><i class="fas fa-square-full text-primary"></i>Casual Leave</td>
                                    <td class="text-end text-danger">3</td>
                                    <td class="text-end text-success">1</td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-square-full text-warning"></i>Sick Leave</td>
                                    <td class="text-end text-danger">1</td>
                                    <td class="text-end text-success">3</td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-square-full text-danger"></i>Earned Leave</td>
                                    <td class="text-end text-danger">1</td>
                                    <td class="text-end text-success">4</td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-square-full text-dark"></i>Extra Leaves</td>
                                    <td class="text-end text-danger">2</td>
                                    <td class="text-end text-success">0</td>
                                </tr>
                                <tr>
                                    <td><strong>Last Leave Status</strong></td>
                                    <td class="text-end text-danger">24/01/2023</td>
                                    <td class="text-end text-success"><span class="btn-sm btn-warning">Pending</span></td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%-- 2rd card --%>
        <div class="col-12 col-xl-4 d-none d-xl-flex">
           <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span> 
                    <h5 class="card-title mb-0">Attendance Status</h5>
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
                                <%--<tr>
                                    <td>Presents</td>
                                    <td class="text-end text-danger">20</td>
                                    <td class="text-end text-success">18</td>
                                </tr>

                                <tr>
                                    <td>Absents</td>
                                    <td class="text-end text-danger"></td>
                                    <td class="text-end text-success">0</td>
                                </tr>
                                <tr>
                                    <td>Leaves</td>
                                    <td class="text-end text-danger">&nbsp;</td>
                                    <td class="text-end text-success">2</td>
                                </tr>
                                <tr>
                                    <td>WFH</td>
                                    <td class="text-end text-danger">&nbsp;</td>
                                    <td class="text-end text-success">3</td>
                                </tr>

                                <tr>
                                    <td><strong>Last Leave Status</strong></td>
                                    <td class="text-end text-danger">24/01/2023</td>
                                    <td class="text-end text-success"><span class="btn-sm btn-success">Approved</span></td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
           </div>           
        </div>
        <%--3rd card --%>
        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Events</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100"> <br />
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
                            <tbody id="EventsTbl">
                     
                       
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">        
        <%--  4th card   --%>
        <div class="col-12 col-lg-4 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Meetings</h5>
                </div>
                <div class="card-body">                    
                    <div id="ShowMeeting"></div>
                    <%--    <div class="d-flex align-items-start">
                        <img src="img/avatars/avatar.jpg" width="36" height="36" class="rounded-circle me-2" alt="Ashley Briggs">
                        <div class="flex-grow-1">
                            <small class="float-end">5m ago</small>
                            <strong>Arpita</strong> requested Meeting <strong>Stacie Hall</strong><br>
                            <small class="text-muted">Today 2:51 pm</small><br>
                        </div>
                    </div>


                    <hr>
                    <div class="d-flex align-items-start">
                        <img src="img/avatars/avatar-4.jpg" width="36" height="36" class="rounded-circle me-2" alt="Stacie Hall">
                        <div class="flex-grow-1">
                            <small class="float-end">1h ago</small>
                            <strong>Stacie Hall</strong> posted a new blog<br>

                            <small class="text-muted">Today 6:35 pm</small>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
        <%--  5th card   --%>
        <div class="col-12 col-lg-6 col-xl-4 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">News</h5>
                </div>
                <div class="card-body">                   
                   <div id="newsData">
                   </div>
                   <%--<ul class="timeline">
                        
                   </ul> --%>                
                   
                    <%--<ul class="timeline">
                        <li class="timeline-item">
                            <strong>Chat with Carl and Ashley</strong>
                            <span class="float-end text-muted text-sm">30m ago</span>
                            <p>Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris...</p>
                        </li>
                        <li class="timeline-item">
                            <strong>The big launch</strong>
                            <span class="float-end text-muted text-sm">2h ago</span>
                            <p>
                                Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Praesent adipiscing. Phasellus ullamcorper ipsum rutrum
                                                    nunc...
                            </p>
                        </li>

                    </ul>--%>
                </div>
            </div>
        </div>

        <%--  6th card--%>
        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">                     
                      <a href="#" onclick="openFun()">  <span class="badge bg-info float-end">View All Holiday List</span> </a>
                    <h5 class="card-title mb-0">This Month Holiday List</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
                                    <th>Occasion</th>
                                    <th class="text-end">Date</th>
                                </tr>
                            </thead>
                            <tbody id="holidayListTbl">
                                <%--<tr>
                                    <td>Independance Day</td>
                                    <td class="text-end text-success">26-01-2023</td>
                                </tr>
                                <tr>
                                    <td>Independance Day</td>
                                    <td class="text-end text-success">26-01-2023</td>
                                </tr>
                                <tr>
                                    <td>Independance Day</td>
                                    <td class="text-end text-success">26-01-2023</td>
                                </tr>
                                <tr>
                                    <td>Independance Day</td>
                                    <td class="text-end text-success">26-01-2023</td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
        

        



    

    <div class="row">        
        <%--<div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Events</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100"> <br />
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
                            <tbody id="EventsTbl">
                     
                       
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>--%>




    </div>

    <%--2nd card modal--%>
        <div class="modal fade" id="LSModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title">Leave Status</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body m-3">
                <div class="align-self-center w-100">
                    <table class="table mb-0 mt-1">
                        <thead><tr><th>Sr No.</th><th>Employee Name</th><th>Total Day</th><th>Approve By</th><th>FromDate</th> <th>  ToDate</th> <th>  Status</th> </tr></thead>                        
                        <tbody id="tblLSModal"></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                
            </div>
            </div>
        </div>
    </div>
    <%--end 2th card modal--%>

    <%-- 3rd modal--%>
        <div class="modal fade" id="ASModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title">Attendance Status</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body m-3">
                <div class="align-self-center w-100">
                    <table class="table mb-0 mt-1">  
                        <thead>
                        <tr>
                            <th>Sr No.</th>
                            <th>Employee Name</th>
                            <th>Date </th>
                        </tr>
                        </thead>  
                        <tbody id="tblASModal">
                        </tbody>                       
                    </table>
                </div>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                
            </div>
            </div>
        </div>
    </div>
    <%--end 3rd modal--%>


    <%-- start modal [This Month Holiday List] --%>
    <div class="modal fade" id="sizedModalLg" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title">All Holiday List</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body m-3">
                <div class="align-self-center w-100">
                    <table class="table mb-0 mt-1">
                        <thead>
                            <tr>
                                <th>S.NO</th>
                                <th>Occasion</th>
                                <th class="text-end">Date</th>
                            </tr>
                        </thead>
                        <tbody id="holidayListTbl1">                                
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                
            </div>
            </div>
        </div>
    </div>
    <%--end modal--%>

    
    
    <script src="js/app.js"></script>
</asp:Content>

