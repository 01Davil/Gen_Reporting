<%@ Page Title="" Language="C#" MasterPageFile="~/Finance_MasterPage.master" AutoEventWireup="true" CodeFile="Finance_HomePage.aspx.cs" Inherits="Finance_HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
                LeaveStatus();
                Get_WFH();
                Get_HolidayList();
                GetMeetingList();
                GetEvent();
                TodayTask();
                Get_Tender();
                
            });
        });
        // get tender 
        function Get_Tender() {
            debugger
            $("#AdminTenderList").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/Get_TenderList',
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
                        var j = 1;
                        var List1;
                        for (var i = 0; i < data.length; i++) {
                            List1 = "<tr> <td class='text-center'> " + j + "  </td>  <td> " + data[i].Name + " </td> <td class='text-center' > <b class='text-info'> " + data[i].count + " </b></td> </tr> ";
                            $("#AdminTenderList").append(List1);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });
        }

        // get employee Status
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
//                        Swal.fire({
//                                icon: 'warning',
//                                title: 'warning',
//                                width: '300px',
//                                text: 'Get Available Leaves!',
//                                timer: 1500
//                            })
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
                    //console.log(data[0].response);
                    if (data[0].response == "Fail") {
//                        Swal.fire({
//                            icon: 'warning',
//                            title: 'warning',
//                            width: '300px',
//                            text: 'Get Available Leaves!',
//                            timer: 1500
//                        })
                    } else {
                        // Used
                        $("#AW").text(data[0].Leave);
                        $("#UW").text(data[0].UsedLeave);
                    }
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
                              var List  = "<tr> <td> <strong> No Holiday </strong>  </td> </tr>"
                              $("#holidayListTbl").append(List);
                          } else {
                              var j = 1;
                              var List1;
                              if(data.length == 1)
                              {                                     
                                    for (var i = 0; i < data.length; i++) {
                                      //List3 = " <li class='timeline-item'><strong   >" + data[i].HoliName + " </strong>  <span class='float-end text-muted text-sm'>" + data[i].HoliDate + "</span> <p></p></li> ";
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> <tr> <td> &nbsp; </td> <td> &nbsp;</td> </tr> <tr> <td> &nbsp; </td> <td> &nbsp;</td> </tr> " ;
                                      $("#holidayListTbl").append(List3);
                                      j++;
                                    } // end for loop 
                              }
                              
                              else if(data.length == 2)
                                {
                                    
                                    for (var i = 0; i < data.length; i++) {
                                      //List3 = " <li class='timeline-item'><strong   >" + data[i].HoliName + " </strong>  <span class='float-end text-muted text-sm'>" + data[i].HoliDate + "</span> <p></p></li> ";
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr>  </tr>" ;
                                      $("#holidayListTbl").append(List3);
                                      j++;
                                    } // end for loop 
                                }
                                else if(data.length == 3)
                                {
                                    
                                    for (var i = 0; i < 3; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                      $("#holidayListTbl").append(List3);
                                      j++;
                                    } 
                                }
                                else {
                                   for (var i = 0; i < 3; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                      $("#holidayListTbl").append(List3);
                                      j++;
                                    }                                   
                                   //
                                   $("#HolidayListCard").show();                           
                                }
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
                        var List = "<img src='img/noEvents.jpg' width='100%' /> ";
                        $("#eventTable").hide();                                              
                        $("#eventDiv").append(List);
                    } else {
                        $("#eventTable").show();
                        var j = 1;
                        var List1;
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
                           var List = " <img src='img/noMeeting.jpg' width='100%' /> ";
                           $("#ShowMeeting").append(List);
                       } else {
                           var j = 1;
                           var List1;
                           for (var i = 0; i < data.length; i++) {
                               //List1 = " <li class='timeline-item'> <a onclick='ShowMeeting(" + data[i].id + ")'><strong   >" + data[i].Subject + " </strong>  </a> <span class='float-end text-muted text-sm'>" + data[i].Date + "</span> <p></p></li> ";
                              // List1 = " <li class='timeline-item'> <strong   >" + data[i].Subject + " </strong>   <span class='float-end text-muted text-sm'>" + data[i].Date + "</span> <p>" + data[i].Details + "</p></li> ";
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
                           // App
                       }
                   }
               });
           }
           // 
           function GetAllHoliDay()
           {                
                $("#myModalHolidayList").modal('show');
               
           }
           function openFun(){
               $("#sizedModalLg").modal('show');
               $("#holidayListTbl1").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
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

                              //var List = "<li class='timeline-item'><strong> No Holiday </strong>  <p></p></li>";
                              var List  = "<tr> <td> <strong> No Holiday </strong>  </td> </tr>"
                              $("#holidayListTbl1").append(List);
                          } else {
                              var j = 1;
                              var List1;                              
                                for (var i = 0; i < data.length; i++) {
                                    //List3 = " <li class='timeline-item'><strong   >" + data[i].HoliName + " </strong>  <span class='float-end text-muted text-sm'>" + data[i].HoliDate + "</span> <p></p></li> ";
                                    List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                    $("#holidayListTbl1").append(List3);
                                    j++;
                                } // end for loop                      
                              // App
                          }
                      }
                  });     
           }
           // FncViewSalary
           function GetViewSalary()
           {                
                $("#myModalViewSalary").modal('show');
               
           }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
        <%--<div class="col-12 col-lg-4 d-flex">
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
        <%--1st modal --%>
            
        <%--2nd modal --%>
        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <%--<a href="Finance_ApplyLeave.aspx"><span class="badge bg-info float-end">View</span> </a>--%>
                    <h5 class="card-title mb-0">Leave Status</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                             <thead>
                                    <tr>
                                        <th>Leave Type</th>
                                        <th class="text-end">Available</th>
                                        <th class="text-end">Used </th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <i class="fas fa-square-full text-primary"></i>Casual Leave
                                        </td>
                                        
                                        <td class="text-center text-success" id="ACL"></td>
                                        <td class="text-center text-danger" id="UCL">3
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <i class="fas fa-square-full text-warning"></i>Sick Leave
                                        </td>
                                        
                                        <td class="text-center text-success" id="ASL"></td>
                                        <td class="text-center text-danger" id="USL">1
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <i class="fas fa-square-full text-danger"></i>Earned Leave
                                        </td>
                                        
                                        <td class="text-center text-success" id="AEL"></td>
                                        <td class="text-center text-danger" id="UEL">1
                                        </td>
                                    </tr>
                                    <tr>
                                        
                                    </tr>
                                </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-lg-4 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Meetings</h5>
                </div>
                <div class="card-body">                    
                    <div id="ShowMeeting"></div>
                </div>
            </div>
        </div>

       <%-- <div class="col-12 col-lg-6 col-xl-4 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">News</h5>
                </div>
                <div class="card-body">
                   <ul class="timeline">
                        <div id="vishnu"></div>
                   </ul>                 
                   
                    
                </div>
            </div>
        </div>--%>
        
        <div class="col-12 col-lg-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Events</h5>
                </div>
                <div class="card-body">
                    <div id="eventDiv" align="center"> </div>
                    <div class="align-self-center w-100">


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

        <div class="col-12 col-lg-6 col-xl-4 d-flex">
            <div class="card flex-fill w-100">
            <div class="card-header">
                <%--<a href="Finance_ApplyWFH.aspx"><span class="badge bg-info float-end">View</span> </a>--%>
                <h5 class="card-title mb-0">WFH Status</h5>
            </div>
            <div class="card-body d-flex pt-0">
                <div class="align-self-center w-100">
                    <table class="table mb-0 mt-1">
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th class="text-end">Available</th>
                                <th class="text-end">Used</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Work From Home</td>
                                <td class="text-center text-success" id="AW">1</td>
                                <td class="text-center text-danger" id="UW">5</td>
                                
                            </tr>
                            
                            <tr>
                                <td>&nbsp;</td>
                                <td class="text-end text-danger">&nbsp;</td>
                                <td class="text-end text-success">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td class="text-end text-danger">&nbsp;</td>
                                <td class="text-end text-success">&nbsp;</td>
                            </tr>                     
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        </div>

        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">                    
                    <a href="#" onclick="openFun()">  <span class="badge bg-info float-end" id="HolidayListCard">View All</span> </a>
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
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <a href="Admin_Tender_ViewAllList.aspx">  <span class="badge bg-info float-end" id="Span1">View All</span> </a>   
                    <h5 class="card-title mb-0">Tender Details</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
                                    <th>S.No</th>
                                    <th>Tender Category</th>
                                    <th>Count</th>                                    
                                </tr>
                            </thead>
                            <tbody id="AdminTenderList">                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%--<div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <a href="#" onclick="GetViewSalary()"> <span class="badge bg-info float-end">View Salary</span> </a>
                     
                    <h5 class="card-title mb-0"> View Salary</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">--%>
                            
                            <%--<thead>
                                <tr>
                                    <th>Occasion</th>
                                    <th class="text-end">Date</th>
                                </tr>
                            </thead>
                            <tbody id="Tbody1">                                
                            </tbody>--%>
                       <%-- </table>
                    </div>
                </div>
            </div>
        </div>--%>


    </div>

    <div class="row">        
        <%--<div class="col-12 col-xl-6 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Events</h5>
                </div>
                <div class="card-body">
                    <div id="eventDiv" align="center"> </div>
                    <div class="align-self-center w-100">


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



    
    <%-- open modal Holiday List --%> 
      <div class="modal fade" id="sizedModalLg" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title">This Month Holiday List</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-3">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
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
        
      <%-- end modal Hloiday List --%>   
        
        
        

    <%-- start modal view Salary --%>
        <div class="modal fade" id="myModalViewSalary" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                <div class="modal-header">
                <h4 class="modal-title">View Salary</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-3">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
                                    <th>SNO</th>
                                    <%--<th class="text-end">Employee Name</th>--%>
                                    <th>Employee Name</th>
                                    <th> Salary</th>
                                    <th> TDS </th>
                                    <th> DATE </th>
                                </tr>
                            </thead>
                            <tbody id="Tbody1">                                
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
    <%--end modal view salary--%>

    <script src="js/app.js"></script>
</asp:Content>

