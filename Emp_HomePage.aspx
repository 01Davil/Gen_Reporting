<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="Emp_HomePage.aspx.cs" Inherits="Emp_HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#div1").css('visibility', 'hidden');            
            $("#div2").css('visibility', 'hidden');
            $("#div3").css('visibility', 'hidden');
            // get date time
            
            $(function () {
                //
                GetTask();
                GetEvent();
                GetMeetingList();
                Get_HolidayList();
                Get_TaskList();
                LeaveStatus();                
                Get_WFH();
                Get_WFH_Approved();
                Get_Leave_Approved();
                Get_Tender();                 
                ///////////////////////////
                var s = "<%= Session["LoginRoleId"].ToString()%>";
                if (s == "4" || s == 4) {                    
                    $("#TenderPM").css('display', 'none');
                    $("#TL").css('visibility', 'visible');
                    $("#div1").css('visibility', 'visible');
                    $("#div2").css('visibility', 'visible');
                    
                }
                else if (s == "3" || s == 3) {                    
                    $("#tender").append('<div class="card flex-fill w-100"> <div class="card-header">  <h5 class="card-title mb-0">Tender Deatils</h5> </div> <div class="card-body" id="Div2"> <div class="align-self-center w-100">  <table class="table mb-0 mt-1">  <thead> <tr> <th>S.No </th>  <th>Tender Name </th> <th> Count </th> </tr> </thead> <tbody id="Master_TenderDetails"></tbody> </table> </div> </div> </div>');
                    $("#div1").css('visibility', 'visible');                    
                    $("#div3").css('visibility', 'visible');                    

                } else {
                    $("#div1").css('visibility', 'hidden');
                    $("#div2").css('visibility', 'hidden');
                    $("#div3").css('visibility', 'hidden'); 
                    $("#TL").css('display', 'none');
                    $("#TenderPM").css('display','none');               
                }
            });
            /////////////////////////////////////////////////////////////////////
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }
            setInterval(function () {
                GetTask();
                GetEvent();
                GetMeetingList();
                Get_HolidayList();
                Get_TaskList();
                LeaveStatus();                
                Get_WFH();
                Get_WFH_Approved();
                Get_Leave_Approved();
                Get_Tender();
            }, 600000)
            // 
        });
            
            // get task 
            function GetTask() {
                $("#tblTask").empty();
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
                            //List1 = "<tr>  No Record Found   </tr> " ;                               
                            $("#tblmsg").empty();
                            $("#tblmsg").append('No Record Found');
                             $("#tblTask2").hide();
                            
//                            Swal.fire({
//                                icon: 'error',
//                                title: 'error',
//                                width: '300px',
//                                text: 'Data Not Found.!'
//                            })
                        } else {                       
                            $("#tblmsg").hide();
                             $("#tblTask2").show();
                            var j = 1;
                            var List1; 
                            for (var i = 0; i < data.length; i++) {                               
                               //jQuery('<tr><td>' + j + '</td><td>' + data[i].ProjectName + '</td><td>' + data[i].TaskName + '</td> <td>' + data[i].TaskDetails + '</td> <td>' + data[i].TaskDeadline + '</td> <td>' + data[i].Status + '</td>   <td> <select  class="form-control"   onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="' + data[i].id + '"> <option value="0">Select </option> <option value="Work In progress">Work In progress</option> <option value="Complete">Complete</option> </select></td>  </tr>').appendTo("#tableTbody");
                                List1 = "<tr> <td> "+ data[i].ProjectName +"  </td><td> "+data[i].TaskName+" </td> <td>  "+ data[i].Status +"</td> </tr> " ;                               
                               $("#tblTask").append(List1);
                                j++;
                            }
                        }
                    }
                });
            }
            // get tender 
            function Get_Tender() {                
                $("#Master_TenderDetails").empty();
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
                           $("#Master_TenderDetails").empty();
                           //var List = " <img src='img/noMeeting.jpg' width='100%' />  ";
                           var List = "<tr> <td align='center'> NO Record Here </td> </tr>"
                           $("#Master_TenderDetails").append(List);
                       } else {
                           var j = 1;
                           var List1;
                           for (var i = 0; i < data.length; i++) {                                
                               List1 = "<tr> <td class='text-center'> "+ j +"  </td>  <td> "+data[i].Name+" </td> <td class='text-center' > <b class='text-info'> "+ data[i].count +" </b></td>  </tr> " ;                               
                               $("#Master_TenderDetails").append(List1);
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
                           $("#ShowMeeting").empty();
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
              
              
        //
        function Get_TaskList() {
            $("#ShowTask").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/Get_TaskList',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {
                        $("#ShowTask").empty();
                        var List = "<li class='timeline-item'><strong> No Task </strong>  <p></p></li>";
                        $("#ShowTask").append(List);
                    } else {
                        var j = 1;
                        var List1;
                        for (var i = 0; i < data.length; i++) {
                            List3 = " <a href='Emp_MeTask.aspx'> <li class='timeline-item'><strong   >" + data[i].ProjectName + " </strong>    <span class='float-end text-muted text-sm'>" + data[i].TaskDeadline + "</span> <p> " + data[i].TaskName + "</p></li>  </a>";
                            $("#ShowTask").append(List3);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });
        }
        
        
        // show ShowMeeting
        function ShowMeeting(j) {
            alert(j);
        }
        // leave status 
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
        // all holiday list in modal 
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
                            $("#holidayListTbl1").empty();                              
                              var List  = "<tr> <td> <strong> No Holiday </strong>  </td> </tr>"
                              $("#holidayListTbl1").append(List);
                          } else {
                              var j = 1;
                              var List1;                              
                                for (var i = 0; i < data.length; i++) {                                    


                                        if (data[i].Type == 0 || data[i].Type == '0') {

                                            List3 = "<tr class='table-danger'> <td> " + data[i].HoliName + "  </td>  <td> " + data[i].HoliDate + " </td>  </tr> </br>";
                                            $("#holidayListTbl1").append(List3);
                                        } else if (data[i].Type == 1 || data[i].Type == '1') {

                                            List5 = "<tr class='table-info'> <td> " + data[i].HoliName + "  </td>  <td > " + data[i].HoliDate + " </td>  </tr>  </br> ";
                                            $("#holidayListTbl1").append(List5);
                                        } else {

                                            List4 = "<tr class='table-success'> <td> " + data[i].HoliName + "  </td>  <td> " + data[i].HoliDate + " </td>   </tr>  </br>";
                                            $("#holidayListTbl1").append(List4);
                                        }

                                        j++;
                                    }
                                    //List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                    //$("#holidayListTbl1").append(List3);
                                    //j++;
                                // end for loop                      
                              // App
                          }
                      }
                  });
                
           
           }
        // get work from home 
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
        
        // This Month Holiday List
        function Get_HolidayList() {            
            $("#EmpHolidayListTbl").empty();
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
                              //var List  = "<tr> <td> <strong> No Holiday </strong>  </td> </tr>"                              
                              $("#emptblmsg").empty();
                              $("#emptblmsg").append("This Month No Holiday");
                              $("#tbodyEmpHolidayListTbl").hide();
                          } else {
                              var j = 1;
                              var List1;
                              if(data.length == 1)
                              {
                                  $("#emptblmsg").hide();
                                  $("#tbodyEmpHolidayListTbl").show();                                  
                                    for (var i = 0; i < data.length; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> <tr> <td> &nbsp; </td> <td> &nbsp;</td> </tr> <tr> <td> &nbsp; </td> <td> &nbsp;</td> </tr> " ;
                                      $("#EmpHolidayListTbl").append(List3);
                                      j++;
                                    } // end for loop 
                              }                              
                              else if(data.length == 2)        {
                                    $("#emptblmsg").hide();
                                    $("#tbodyEmpHolidayListTbl").show();   
                                    for (var i = 0; i < data.length; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr>  </tr>" ;
                                      $("#EmpHolidayListTbl").append(List3);
                                      j++;
                                    } // end for loop 
                              }
                                else if(data.length == 3)  {
                                     $("#emptblmsg").hide();
                                     $("#tbodyEmpHolidayListTbl").show();   
                                     for (var i = 0; i < data.length; i++) {                                      
                                        List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                        $("#EmpHolidayListTbl").append(List3);
                                        j++;
                                     } 
                                }
                              else {
                                  $("#emptblmsg").hide();
                                  $("#tbodyEmpHolidayListTbl").show();   
                                   for (var i = 0; i < 3; i++) {                                      
                                      List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                      $("#EmpHolidayListTbl").append(List3);
                                      j++;
                                    }                                   
                                   //
                                   
                                }
                              // App
                          }
                      }
                  });
              }
        // Events 
        function GetEvent() {
                  $("#EmpEventsTbl").empty();
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
                        $("#eventTable").hide();                       
                       $("#eventDiv").append(List);
                    } else {
                        $("#eventTable").show();  
                        var j = 1;
                        var List1;
                        for (var i = 0; i < data.length; i++) {                            
                            List1 =  " <tr> <td>"+data[i].EmpName+" </td><td> " + data[i].Type + "</td> <td class='text-end text-success'>" + data[i].Date + "</td></tr>"
                            $("#EmpEventsTbl").append(List1);
                            j++;
                        }                         
                    }
                }
            });

        }
        // approved 
        function Get_WFH_Approved() {
            $("#ApprovedLeaveWFHt").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/Get_WFH',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {
                        var List = "<strong> No Work From Home </strong>  ";
                        $("#ApprovedLeaveWFHt").append(List);
                    } else {
                        var j = 1;                                             
                        for (var i = 0; i < data.length; i++) {                                                    
                           //List3 = " <a href='Emp_WFHSummery.aspx'> <li class='timeline-item'><strong   >" + data[i].EmpName + " </strong>     <p> " + data[i].Purpose + "</p></li>  </a>";
                            List3 = "<tr> <td> <a herf='Emp_WFHSummery.aspx'> "+ data[i].EmpName +" </a> </td><td>"  + data[i].Purpose + " </td></tr>"
                            $("#ApprovedLeaveWFHt").append(List3);
                            j++;
                        } // end for loop 
                        // App                       
                    }
                }
            });
        }
        // 
        function Get_Leave_Approved() {
            $("#LeaveApproved").empty();
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/Get_Leave',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {

                        //var List = "<li class='timeline-item'><strong> No Leave </strong>  <p></p></li>";
                        var List  = "<tr> <td> <strong> No Record Here </strong>  </td> </tr>"
                        $("#LeaveApproved").append(List);
                    } else {
                        var j = 1;
                        var List1;
                        for (var i = 0; i < data.length; i++) {
                            List3 = "<tr> <td> <a href='javascript: ;' onclick=openModalAllIEMI(\"" + data[i].Sno + "\")> " + data[i].EmpName + " </a> </td><td>" + data[i].TypeLeave + " </td></tr>"
                            //List3 = " <a href='Emp_LeaveSummery.aspx'> <li class='timeline-item'><strong   >" + data[i].EmpName + " </strong>    <span class='float-end text-muted text-sm'>" + data[i].TypeLeave + "</span> <p> " + data[i].Purpose + "</p></li>  </a>";
                            $("#LeaveApproved").append(List3);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });

        }
        function openModalAllIEMI(Sno) {                
            //alert(Sno);
            debugger
            $('#LeaveApprovedModal').modal('show');
            
            $("#LeaveApproved1").empty();
            var formData = new FormData();
            formData.append("Sno", Sno);
            $.ajax({
                url: 'WebServerFile/Employee_MasterService.asmx/GetLeaveModal',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data[0].response == "Fail") {
                        //var List = "<li class='timeline-item'><strong> No Leave </strong>  <p></p></li>";
                        //var List = "<tr> <td> <strong> No Record Here </strong>  </td> </tr>"
                        $("#LeaveApproved1").append("NO Record Found!");
                    } else {
                        var j = 1;
                        var List1;
                        $('#LeaveApprovedModal').modal('show');
                        for (var i = 0; i < data.length; i++) {
                            //List3 = "<tr> <td> " + data[i].EmpName + " </a> </td><td>" + data[i].typeleave + "</td><td>" + data[i].fromdate + "</td><td> " + data[i].todate + " </td><td> " + data[i].totalday + "</td> <select  class='form - control''   onchange='EmployeeFunWorking(' + data[i].id + ')' name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td> </tr>"
                            //List3 = " <a href='Emp_LeaveSummery.aspx'> <li class='timeline-item'><strong   >" + data[i].EmpName + " </strong>    <span class='float-end text-muted text-sm'>" + data[i].TypeLeave + "</span> <p> " + data[i].Purpose + "</p></li>  </a>";
                            $("#LeaveApproved1").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td> <td> <select class="form-control" onchange=" EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select>' + '</td >  </tr > ');
                            //$("#LeaveApproved1").append(List3);
                            j++;
                        } // end for loop 
                        // App
                    }
                }
            });
        }
        function EmployeeFunWorking(id) {
            var a = "#Drop" + id;
            var Status = $("  " + a + " option:selected").val().trim();
            //alert(a  +" =>" +Status);
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
                formData.append("Id", a);
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
      <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3 id="SetPageName">Dashboard</h3>
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
    <%--team leader dashboard--%>
    <div id="TL">            
         
        <div class="row">
            <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">                     
                   <%--<a href="Emp_LeaveSummery.aspx"> <span class="badge bg-info float-end"> View  </span> </a>--%>
                    <h5 class="card-title mb-0">Leave Approved</h5>
                </div>
                <div class="card-body">
                     <%--<ul class="timeline" id="ApprovedLeaveStatus"> </ul>                   --%>
                     <div class="align-self-center w-100"> 
                        <table class="table mb-0 mt-1"> 
                            <thead> <tr>  <th>Employee Name </th> <th> Subject </th> </tr> </thead>
                            <tbody id="LeaveApproved"></tbody>
                        </table>
                    </div> 
                </div>
            </div>
        </div>

             <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">                     
                     <%--<a href="Emp_WFHSummery.aspx"><span class="badge bg-info float-end">View</span> </a>--%> 
                    <h5 class="card-title mb-0">WFH Approved</h5>
                </div>
                <div class="card-body" id="ApprovedLeaveWFH">
                    <div class="align-self-center w-100"> 
                        <table class="table mb-0 mt-1"> 
                            <thead> <tr>  <th>Employee Name </th> <th> Subject </th> </tr> </thead>
                            <tbody id="ApprovedLeaveWFHt"></tbody>
                        </table>
                    </div>                    
                </div>
            </div>
        </div>

             <div id="tender" class="col-12 col-xl-4 d-none d-xl-flex">
             </div>

         <%--<div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">                     
                      <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">TASK </h5>
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
                            <tbody id="Tbody3">        </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>--%>
        </div>
        <hr /> 
    </div>
    <%--end team leader dashboard--%>
    
    <%--project manager dashboard professional --%>
        
        
    <%--end project manager dashboard professional --%>
    

    <div class="container-fluid p-0">
        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <%--<h3> Dashboard</h3>--%>
            </div>
            <%--<div class="col-auto ms-auto text-end mt-n1" id="timerId">
                <div class=" me-2 d-inline-block">
                    <span class="btn btn-light bg-white shadow-sm ">
                        <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                    </span>
                </div>               
            </div>--%>
        </div>
        <div class="row" id="Row1">
            <%-- 1st card --%>
            <div class="col-12 col-lg-4 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                   <%--<a href="Emp_MeTask.aspx"> <span class="badge bg-info float-end">View</span> </a>--%>
                    <h5 class="card-title mb-0">My Tasks</h5>
                </div> <br />
                <h4 class="text-center" id="tblmsg"></h4>                
                <table class="table table-striped my-0" id="tblTask2">
                    <thead>
                        <tr>                            
                            <th>Project Name</th>
                            <th>Task Name</th>
                            <th>Project Status</th>                            
                        </tr>
                    </thead>
                       
                    <tbody id="tblTask">
                        
                        <%--<tr>
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
--%>
                    </tbody>
                    
                    
                </table>
            </div>
        </div>    
            <%-- 2nd card --%>
            <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                   <%--<a href="Emp_ApplyLeave.aspx"> <span class="badge bg-info float-end">View</span> </a>--%>
                    <h5 class="card-title mb-0">Leave Status</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <table class="table mb-0 mt-1">
                             <thead>
                                    <tr>
                                        <th>Leave Type </th>
                                        <th>Available </th>
                                        <th>Used </th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td> <i class="fas fa-square-full text-primary"></i>Casual Leave </td>
                                        <td class="text text-success" id="ACL">  </td>
                                        <td class="text text-danger" id="UCL"> </td>
                                        
                                    </tr>
                                    <tr>
                                        <td> <i class="fas fa-square-full text-warning"></i>Sick Leave </td>
                                        <td class="text text-success" id="ASL"> </td>
                                        <td class="text text-danger"  id="USL">   </td> 
                                        
                                    </tr>
                                    <tr>
                                        <td> <i class="fas fa-square-full text-danger"></i>Earned Leave </td>
                                        <td class="text text-success" id="AEL"> </td>
                                        <td class="text text-danger" id="UEL">  </td>                                        
                                    </tr>
                                    <tr>
                                        
                                    </tr>
                                </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
            <%--3 rd card --%>
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
        </div>

        <div class="row">
        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">                     
                      <a href="#" onclick="openFun()">  <span class="badge bg-info float-end">All Holiday List</span> </a>
                    <h5 class="card-title mb-0">This Month Holiday List</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">
                        <h4 class="text-center" id="emptblmsg"></h4>
                        <table class="table mb-0 mt-1" id="tbodyEmpHolidayListTbl">
                            <thead>
                                <tr>
                                    <th>Occasion</th>
                                    <th class="text-end">Date</th>
                                </tr>
                            </thead>
                            <tbody id="EmpHolidayListTbl">        </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>        
        
        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
            <div class="card-header">
                <%--<a href="Emp_WFHSummery.aspx">  <span class="badge bg-info float-end">Status</span> </a>--%>
                <h5 class="card-title mb-0">WFH Status</h5>
            </div>
            <div class="card-body d-flex pt-0">
                <div class="align-self-center w-100">
                    <table class="table mb-0 mt-1">
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th>Available</th>
                                <th class="text-end">Used</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Work From Home</td>                                
                                <td class="text-end text-success" id="AW">0</td>
                                <td class="text-end text-danger" id="UW">0</td>
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
                   <a href="#"></a> <span class="badge bg-info float-end">Today</span>
                    <h5 class="card-title mb-0">Events</h5>
                </div>
                <div class="card-body"> 
                    <div id="eventDiv" align="center">
                        </div>
                    <div class="align-self-center w-100">                        
                        <table class="table mb-0 mt-1" id="eventTable">
                            <thead>
                                <tr>
                                    <th>Employee Name</th>
                                    <th>Occasion</th>
                                    <th class="text-end">Date</th>
                                </tr>
                            </thead>
                            <tbody id="EmpEventsTbl">                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        
    </div>
    </div>
    
    
    
    <div class="row">  
         <%--<div id="div3" class="col-12 col-xl-6 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">                     
                      <span class="badge bg-info float-end">This Month</span>
                    <h5 class="card-title mb-0">Tender Details</h5>
                </div>
                <div class="card-body" id="Div1">
                    <div class="align-self-center w-100"> 
                        <table class="table mb-0 mt-1"> 
                            <thead> <tr>  <th>Employee Name </th> <th> Subject </th> </tr> </thead>
                            <tbody id="Master_TenderDetails23"></tbody>
                        </table>
                    </div>                    
                </div>
            </div>          
            
          </div>--%>
    </div>


    <%-- start modal [This Month Holiday List] --%>
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
    <%--end modal--%>

    <%--  Leave approve   --%>
        <div class="modal fade" id="LeaveApprovedModal" tabindex="-1" role="dialog" aria-hidden="true">
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
                                <th>S.No</th>
                                <th>Employee NAME</th>
                                <th>LeaveType</th>
                                <th>FromDate</th>
                                <th>ToDate</th>
                                <th>TotalDay</th>
                                <th>Purpose</th>
                                <th> Approved </th>
                            </tr>
                        </thead>
                        <tbody id="LeaveApproved1">                                
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
</asp:Content>



