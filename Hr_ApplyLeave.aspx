<%@ Page Title="" Language="C#" MasterPageFile="~/HRMasterPage.master" AutoEventWireup="true" CodeFile="Hr_ApplyLeave.aspx.cs" Inherits="Hr_ApplyLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="https://code.jquery.com/ui/1.12.1/themes/ui-lightness/jquery-ui.css" rel="stylesheet"/>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer" ></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        

        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);
              
            }
            //GetEmployee 
            GetApplyLeave("Processing");
            // Get Available Leaves
            $("#btnApplyLeave").click(function (e) {
                e.preventDefault();
                var TypeLeave = $("#DropLeave option:selected").val();
                var from = $("#from").val();
                var Purpose = $("#Purpose").val();
                if (TypeLeave == "Select") {
                    Swal.fire({
                        icon: 'warning',
                        title: 'warning',
                        width: '300px',
                        text: 'Please Select a Valid Option !',
                        timer: 1500
                    })

                } else {
                    if (TypeLeave == "" || from == "" || Purpose == "") {
                        Swal.fire({
                            icon: 'warning',
                            title: 'warning',
                            width: '300px',
                            text: 'All Field Required !',
                            timer: 1500
                        })

                    } else {
                        // ajax
                        var formData = new FormData();
                        formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                           formData.append("TypeLeave", TypeLeave);
                           formData.append("Date", from);
                           formData.append("Purpose", Purpose);
                           $.ajax({
                               url: 'WebServerFile/Employee_MasterService.asmx/ApplyLeave',
                               type: 'POST',
                               data: formData,
                               cache: false,
                               contentType: false,
                               processData: false,
                               success: function (data) {
                                   if (data.includes('Not')) {
                                       Swal.fire({
                                           icon: 'info',
                                           //title: 'info',
                                           width: '300px',
                                           text: data
                                       })
                                   } else {
                                       Swal.fire({
                                           icon: 'success',
                                           //title: 'info',
                                           width: '300px',
                                           text: data
                                       })
                                       GetApplyLeave("Processing");
                                   }
                               }
                           });
                           
                      
                       }
                   }
            });
             $(function () {
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
                        //console.log(data[0].response);
                        if (data[0].response == "Fail") {
                            Swal.fire({
                                icon: 'warning',
                                title: 'warning',
                                width: '300px',
                                text: 'Get Available Leaves!',
                                timer: 1500
                            })
                        } else {
                            // Used
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

            });
             // main end
         });
        //
   
        //get Employee Apply Leave
        function GetApplyLeave(Type) {
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
             formData.append("Type", Type);
             $.ajax({
                 url: 'WebServerFile/Employee_MasterService.asmx/GetEmployeeApplyLeave',
                 type: 'POST',
                 data: formData,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (data) {
                     if (data[0].response == "Fail") {
                         Swal.fire({
                             icon: 'info',
                             title: 'info',
                             width: '300px',
                             text: 'Details Not Found. !',
                         })
                         $("#TableTbody").empty();
                     } else {
                         $("#TableThead").empty();
                         $("#TableTbody").empty();

                         $("#TableThead").append('<tr> <th>S.No.</th> <th class="d-none d-xl-table-cell">Leave Type </th> <th class="d-none d-xl-table-cell">From </th><th class="d-none d-xl-table-cell">To </th><th class="d-none d-md-table-cell">Day </th><th class="d-none d-md-table-cell">Status </th><th class="d-none d-md-table-cell">Approved By</th></tr> ');
                         var j = 1;
                         for (var i = 0; i < data.length; i++) {
                             jQuery('<tr><td>' + j + '</td><td>' + data[i].TypeLeave + '</td><td>' + data[i].FromDate + '</td> <td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Status + '</td> <td>' + data[i].Approve_Name + '</td>     </tr>').appendTo("#TableTbody");
                             j++;
                         }
                     }
                 }
             });
         }
         //
         function GetEmpLeaveWork() {
             var b = $("#DropType").find(":selected").val();
             if (b != 0 || b != '0') {
                 GetApplyLeave(b);
             } else {
                 Swal.fire({
                     icon: 'warning',
                     title: 'warning',
                     width: '300px',
                     text: 'Please Select a Valid Option !',
                     timer: 1500
                 })
             }
         }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-0">
        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>Employee Leave</h3>
            </div>
            <div class="col-auto ms-auto text-end mt-n1">
                <div class=" me-2 d-inline-block">
                    <span class="btn btn-light bg-white shadow-sm "><i class="align-middle mt-n1" data-feather="calendar"></i>  <strong class="cv" >2022/10/12 - 12:11:47</strong> </span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-lg-8 d-flex">
                <div class="card flex-fill w-100">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Apply Leave</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <label class="form-label">
                                    Type of Leave</label>
                                <select class="form-control mb-3" id="DropLeave">
                                    <option selected="0">Select</option>
                                    <option value="Casual Leave">Casual Leave</option>
                                    <option value="Sick Leave">Sick Leave</option>
                                    <option value="Earned Leave">Earned Leave</option>
                                    <option value="Emergency Leave">Emergency Leave</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">
                                    Select Date : </label>
                                   <input id="from" name="from"   type="text"  class="form-control mb-3" />
                            </div>
                            
                            
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-12">
                                <label class="form-label">
                                    Purpose</label>
                                <input type="text" id="Purpose" class="form-control" placeholder="Write Purpose Here">
                            </div>
                        </div>
                        <div class="row mt-4 mb-4">
                            <div class="col-md-12">
                                <button class="btn btn-primary float-end" id="btnApplyLeave">Apply Leave</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-xl-4 d-none d-xl-flex">
                <div class="card flex-fill w-100">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Available Leaves</h5>
                    </div>
                    <div class="card-body d-flex pt-0">
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
                    </div>
                </div>
            </div>
        </div>
        <div class="card flex-fill">
            <div class="card-header">
                <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Leave Summery</h5>
     
                    <div class="input-group input-group-sm" style="width: 200px; float: right;">
                    <select id="DropType" class="form-select" style="border-radius: 4px;" onchange="GetEmpLeaveWork()">
                        <option value="0">Select  type of Leave.</option>
                        <option value="Processing">Pending</option>
                        <option value="Reject">Reject </option>
                        <option value="Approved">Approved</option>
                    </select>
                </div>
          
            </div>
            <table id="datatables-dashboard-projects" class="table table-striped my-0">
                <thead id="TableThead">
                </thead>
                <tbody id="TableTbody">
                    <%--            <tr>
                        <td>01
                        </td>
                        <td class="d-none d-xl-table-cell">Sick Leave
                        </td>
                        <td class="d-none d-xl-table-cell">1/11/2022
                        </td>
                        <td class="d-none d-md-table-cell">3/11/2022
                        </td>
                        <td class="d-none d-md-table-cell">3
                        </td>
                        <td>
                            <span class="badge bg-success">Approved</span>
                        </td>
                        <td>Indrajeet Sir
                        </td>
                    </tr>--%>
                </tbody>
            </table>
        </div>
    </div>
    <script type="text/javascript">
       
        $(function () {
            var dateToday = new Date();
            var dates = $("#from, #to").daterangepicker({
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 3,
                minDate: dateToday,
                onSelect: function (selectedDate) {
                    var option = this.id == "from" ? "minDate" : "maxDate",
                        instance = $(this).data("daterangepicker"),
                        date = $.daterangepicker.parseDate(instance.settings.dateFormat || $.daterangepicker._defaults.dateFormat, selectedDate, instance.settings);
                    dates.not(this).daterangepicker("option", option, date);
                }
            });
        })

        //$(function () {
        //    //debugger;
        //    var start = moment().subtract(29, 'days');
        //    var end = moment();

        //    function cb(start, end) {
        //        $('#reportrange span').html(start.format('MM/D/YYYY') + ' - ' + end.format('MM/D/YYYY'));
        //    }
        //    var currentTime = new Date()
        //    var minDate = new Date(currentTime.getFullYear(), currentTime.getMonth(), +1); //one day next before month
        //    var maxDate = new Date(currentTime.getFullYear(), currentTime.getMonth() + 1, +0); // one day before next month
        //    $("#reportrange").daterangepicker({
        //        minDate: 0,
        //        startDate: minDate,
        //        endDate: maxDate
        //    }, cb);

        //    cb(start, end);

        //});
    </script>
</asp:Content>




