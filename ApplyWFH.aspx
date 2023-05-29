<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ApplyWFH.aspx.cs" Inherits="ApplyWFH" %>

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

            //get apply WFH
            //GetApplyLeave(0);
            //
            Get_WFH();
            $(function () {
                $.ajax({
                    type: "POST",
                    url: "MasterPage.aspx/GetMonth",
                    data: '{ }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;
                        var ddlCustomers = $("[id*=MonthDrop]");
                        ddlCustomers.empty().append('<option selected="selected" value="0">All Month</option>');
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].MonthNo).html(xmlDoc[i].MonthName));
                        }

                    }
                });
            });
            //
            
         // Apply WFH
            $("#btnapply").click(function (e) {
                 e.preventDefault();
                var FDate = $("#FDate").val();
                var TDate = $("#TDate").val();
                var Purpose = $("#Purpose").val();
              
                    if ( FDate == "" || TDate == "" || Purpose == "") {
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
                           formData.append("FDate", FDate);
                           formData.append("TDate", TDate);
                           formData.append("Purpose", Purpose);
                           $.ajax({
                               url: 'WebServerFile/Employee_MasterService.asmx/ApplyWFH',
                               type: 'POST',
                               data: formData,
                               cache: false,
                               contentType: false,
                               processData: false,
                               success: function (data) {
                                   if (data.includes('Not')) {
                                       Swal.fire({
                                           icon: 'info',
                                           width: '300px',
                                           text: data,
                                           timer:3000
                                       })
                                   } else {
                                       Swal.fire({
                                           icon: 'success',
                                           width: '300px',
                                           text: data,
                                           timer: 3000
                                       })
                                       $("#FDate").val("");
                                       $("#TDate").val("");
                                       $("#Purpose").val("");
                                       Get_WFH();
                                   }
                                   GetApplyLeave(0);
                               }
                           });
                       }
            });
        });
        ///
        function GetApplyLeave(MonthNo) {
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("MonthNo", MonthNo);
             $.ajax({
                 url: 'WebServerFile/Employee_MasterService.asmx/GetApplyWFH',
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
                             text: 'Data Not Found.!',
                             timer: 1500
                         })
                         $("#TableTbody").empty();
                     } else {
                         $("#TableTbody").empty();
                         var j = 1;
                         for (var i = 0; i < data.length; i++) {
                             jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].FDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].TDate + '</td> <td class="d-none d-xl-table-cell">' + data[i].TotalDays + '</td> <td class="d-none d-xl-table-cell">' + data[i].LeaveStatus + '</td> <td class="d-none d-xl-table-cell">' + data[i].ApprovedName + '</td>     </tr>').appendTo("#TableTbody");
                             j++;
                         }
                     }
                 }
             });
        }
        function GetMonthBy() {
            GetApplyLeave($("#MonthDrop option:selected").val());
        }
        function CompareDate() {
            var FDate = $("#FDate").val();
            var TDate = $("#TDate").val();
            if (TDate < FDate) {
                Swal.fire({
                    icon: 'warning',
                    title: 'warning',
                    width: '300px',
                    text: 'The date must be larger to form a date.! ',
                    timer: 1500
                })
                $("#TDate").val("");
            }
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

                    $("#Available").text(data[0].Available);
                    $("#Used").text(data[0].Used);

                    $("#Pending").text(data[0].Pending);
                    $("#Approved").text(data[0].Approved);

                    $("#Reject").text(data[0].Reject);
                }
            });
            <%--  var formData = new FormData();
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
            });--%>
          }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Apply Work From Home</h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
        </div>
    </div>


    <div class="row">

        <div class="col-12 col-lg-8 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <h5 class="card-title mb-0">Apply Work From Home</h5>
                </div>
                <div class="card-body">

                    <div class="row mt-4">
                        <div class="col-md-6">
                            <label class="form-label">From</label>
                            <input type="text" id="FDate" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">To</label>
                            <input type="text" id="TDate" onchange="CompareDate()" class="form-control">
                        </div>

                    </div>
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <label class="form-label">Purpose</label>
                            <input type="text" class="form-control"  id="Purpose" placeholder="Write Purpose Here">
                        </div>

                    </div>

                    <div class="row mt-4 mb-4">
                        <div class="col-md-12">
                            <button type="submit" id="btnapply"  class="btn btn-primary float-end">Apply</button>
                        </div>

                    </div>




                </div>
            </div>
        </div>

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
                    <h5 class="card-title mb-0">Work From Home Status</h5>
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
       <%-- <div class="col-12 col-lg-6 col-xl-4 d-flex">
                                <div class="card flex-fill w-100">
                                    <div class="card-header">
                                        <div class="card-actions float-end">
                                            <div class="dropdown position-relative">
                                                <a href="#" data-bs-toggle="dropdown" data-bs-display="static">
                                                    <i class="align-middle" data-feather="more-horizontal"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <h5 class="card-title mb-0">Work From Home Status</h5>
                                    </div>
                                    <div class="card-body">
                                        <ul class="timeline">
                                            <li class="timeline-item">
                                                <strong>Available </strong> 
                                                <span class="float-end text-muted text-sm" id="Available"></span>
                                                <p><br /></p>
                                            </li>
                                            <li class="timeline-item">
                                                <strong>Used</strong>
                                                <span class="float-end text-muted text-sm" id="Used"></span>
                                                <p><br /></p>
                                            </li>
                                      <li class="timeline-item">
                                                <strong>Pending</strong>
                                                <span class="float-end text-muted text-sm" id="Pending"></span>
                                                <p><br /></p>
                                            </li>
 <li class="timeline-item">
                                                <strong>Approved</strong>
                                                <span class="float-end text-muted text-sm" id="Approved"></span>
                                                <p><br /></p>
                                            </li>

                                             <li class="timeline-item">
                                                <strong>Reject</strong>
                                                <span class="float-end text-muted text-sm" id="Reject"></span>
                                                <p><br /></p>
                                            </li>


                                        </ul>
                                    </div>
                                </div>
                            </div>--%>

    </div>

    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Summary</h5>
            <div class="input-group input-group-sm" style="width: 200px; float: left;">
            
            </div>
            <div class="input-group input-group-sm" style="width: 200px; float: right;">
                   <select class="form-select" style="border-radius: 4px;" id="MonthDrop" onchange="GetMonthBy()">
                </select>
            </div>
        </div>
        <table id="datatables-dashboard-projects" class="table table-striped my-0">
            <thead>
                <tr>
                    <th>S.No.</th>
        
                    <th class="d-none d-xl-table-cell">From</th>
                    <th class="d-none d-xl-table-cell">To</th>
                    <th class="d-none d-md-table-cell">Day</th>
                    <th class="d-none d-md-table-cell">Status</th>
                    <th class="d-none d-md-table-cell">Approved By</th>
                </tr>
            </thead>
            <tbody id="TableTbody">
     <%--           <tr>
                    <td>01</td>
                    <td class="">Sick Leave</td>
                    <td class="d-none d-xl-table-cell">1/11/2022</td>
                    <td class="d-none d-md-table-cell">3/11/2022</td>
                    <td class="d-none d-md-table-cell">3</td>
                    <td><span class="badge bg-success">Approved</span></td>
                    <td>Indrajeet Sir</td>
                </tr>--%>

            </tbody>
        </table>
    </div>
    <script>
        $(function () {
            $('#FDate').daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                minDate: new Date(),
                dateFormat: 'dd-mm-yyyy'
            });
        });

        $(function () {
            $('#TDate').daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                minDate: new Date(),
                dateFormat: 'dd-mm-yyyy'
            });
        });

    </script>
</asp:Content>
