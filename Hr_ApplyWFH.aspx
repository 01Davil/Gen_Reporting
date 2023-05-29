<%@ Page Title="" Language="C#" MasterPageFile="~/HRMasterPage.master" AutoEventWireup="true" CodeFile="Hr_ApplyWFH.aspx.cs" Inherits="Hr_ApplyWFH" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

            //get apply WFH
            GetApplyLeave(0);
            //
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
            $(function () {
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
                            Swal.fire({
                                icon: 'warning',
                                title: 'warning',
                                width: '300px',
                                text: 'Get Available Leaves!',
                                timer: 1500
                            })
                        } else {
                            // Used
                            $("#AW").text(data[0].Leave);
                            $("#UW").text(data[0].UsedLeave);
                        }
                    }
                });
            });
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
                            <input type="date" id="FDate" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">To</label>
                            <input type="date" id="TDate" onchange="CompareDate()" class="form-control">
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
        <div class="col-12 col-xl-4 d-none d-xl-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">

                    <h5 class="card-title mb-0">Availability</h5>
                </div>
                <div class="card-body d-flex pt-0">
                    <div class="align-self-center w-100">


                        <table class="table mb-0 mt-1">
                            <thead>
                                <tr>
                                    <th>Type</th>
                                    <th class="text-end">Used</th>
                                    <th class="text-end">Available</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><i class="fas fa-square-full text-primary"></i>WFH</td>
                                    <td class="text-end text-danger" id="UW">3</td>
                                    <td class="text-end text-success" id="AW">2</td>
                                </tr>
                                <tr>
                                    <%--<td class="text-end text-success" colspan="3">Total : 5</td>--%>
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
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Summery</h5>
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

</asp:Content>
