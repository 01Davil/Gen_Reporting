<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ApprovalLeave.aspx.cs" Inherits="ApprovalLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
          <script src="JsDB/jquery.js"></script>
   <script type="text/javascript">
       $(document).ready(function () {
           var a;
           a = setInterval(fun, 1000);
           function fun() {
               var today = new Date();
               var now = today.toLocaleString().toUpperCase();;
               $(".cv").text(now);

           }

           GetDefalutLeave("NA", "NA", $("#dd option:selected").val());
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
                       var ddlCustomers = $("[id*=select]");
                       ddlCustomers.empty();
                       $.each(data, function (key, val) {
                           ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                       });

                   }

               });
           });

           // main end
       });

       //
       function ShowDataByButton() {
           var Date = $("#reportrange").val();
           var Email = $("#SearchText").val();
           if (Email.length == 0 || Email == "") {
               GetDefalutLeave(Date, "NA", $("#dd option:selected").val());
           } else {
               GetDefalutLeave(Date, Email, $("#dd option:selected").val());
           }
       }

       //  Get Apply Leave
       function GetDefalutLeave(Date, Email, Type) {
            //debugger;
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
           formData.append("Email", Email);
            formData.append("Date", Date);
            formData.append("LeavaType", Type);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/GetApplyLeave',
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
                            text: "No details found."
                           
                        });
                    } else {
                        $("#ShowTableWork").empty();
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {

                            if (data[i].Status == "Processing") {
                                $("#my").show();
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td>   <td><span class="badge bg-warning">Processing</span></td>    <td> <select  class="form-control"   onchange="EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td>  </tr>')

                            } else if (data[i].Status == "Reject") {
                                $("#my").hide();
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td>  <td><span class="badge bg-danger">Reject</span></td>   <td></td> </tr>')

                            } else {
                                $("#my").hide();
                                $("#ShowTableWork").append('<tr><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TypeLeave + '</td> <td>' + data[i].FromDate + '</td><td>' + data[i].ToDate + '</td> <td>' + data[i].TotalDay + '</td> <td>' + data[i].Purpose + '</td>  <td><span class="badge bg-success">Approved</span></td>   <td></td> </tr>')

                            }
                            j++;
                        }
                    }

                }

            });
       }

       // 
       function EmployeeFunWorking(id) {
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
                             GetDefalutLeave("NA", "NA", $("#dd option:selected").val());
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
            </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      

        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>APPROVAL LEAVE</h3>
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
            </div>
            <div class="card-body">
           
                <div class="row mt-4">
                       <div class="col-md-3">
                        <label class="form-label">Select Dates:</label>
             
                        <input id="reportrange" class="form-control form-select" />
                    </div>


                    <div class="col-md-3">
                        <label class="form-label">Employee Name </label>
                        <input list="select" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                        <datalist class="MeClass" id="select">
                        </datalist>
                    </div>
                    
                    <div class="col-md-3">
                        <label class="form-label">Select Type of Leave Status.</label>
                       <select id="dd" class="form-select ms-3"  style="width: 250px;">
                    <option value="Processing" selected>Processing</option>
                    <option value="Approved">Approved</option>
                    <option value="Reject">Reject</option>
                </select>
                    </div>


                    <div class="col-md-2 pt-4">
                        <a href="#" onclick="ShowDataByButton()" class="btn btn-primary float-end w-100 mt-1"><i class="fa fa-search"></i>Search </a>
                    </div>
                </div>

            </div>

        </div>


    <div class="card flex-fill">
        <div class="card-header">
            </div>
        <table id="datatables-dashboard-projects" class="table table-striped my-0">
    <thead>
                <tr>
                    <th>S.No.</th>
                    <th class="d-none d-xl-table-cell">Employee Name</th>
                    <th class="d-none d-xl-table-cell">Leave Type</th>
                    <th class="d-none d-xl-table-cell">From Date</th>
                    <th class="d-none d-xl-table-cell">TO Date</th>
                    <th class="d-none d-xl-table-cell">Total Day</th>
                    <th class="d-none d-md-table-cell">Purpose</th>
                    <th class="d-none d-md-table-cell">Leave Status</th>
                    <th class="d-none d-md-table-cell" id="my">Option</th>
                </tr>
            </thead>
            <tbody id="ShowTableWork"></tbody>
        </table>
    </div>

        <script type="text/javascript">
            $(function () {
                //debugger;
                var start = moment().subtract(2, 'days');
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

        <script>
            $(document).ready(function() {
                $('.js-example-basic-multiple').select2();
            });
        </script>
</asp:Content>


