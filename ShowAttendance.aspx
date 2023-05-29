<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ShowAttendance.aspx.cs" Inherits="ShowAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
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
               // GetDefalutLeave('Today', 'NA', 'NA', "ToDay Attendance");
        
            /// Search Employee Name List
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
           

        });

       
        function GetDate() {
            var Type = $("#DD option:selected").val();
            var Type1 = $("#DD option:selected").text();
            var Date = $("#reportrange").val();
            var Email = $("#SearchText").val();

            if (Email == " " || Email.length == 0) {
                GetDefalutLeave(Type, "NA", Date, Type1);
            } else {
                GetDefalutLeave(Type, Email, Date, Type1);
            }
            
        }


        function GetDefalutLeave(AttendanceType, Email, Date) {

            $(".loaderbg").show();
            //debugger;
            var formData = new FormData();
            formData.append("AttendanceType", AttendanceType);
            formData.append("EmpEmail", Email);
            formData.append("Date", Date);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/GetAttendance',
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
                        $(".loaderbg").hide();
                    } else {
                        $("#TableTbody").empty();
                        $("#TableThead").empty();
                        jQuery('<tr> <th>S.No.</th>  <th class="d-none d-xl-table-cell">Emp. Name</th> <th class="d-none d-xl-table-cell"> Login Time</th> <th class="d-none d-xl-table-cell">Logout Time</th> <th class="d-none d-xl-table-cell">Working Hours </th>  <th class="d-none d-md-table-cell">Day Name</th>   <th class="d-none d-md-table-cell">Attendance Date</th> </tr>').appendTo("#TableTbody");
                        //  
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                                //indexOf("oo") > -1
                                if (data[i].WorkingHours.indexOf("7 Hours") > -1 || data[i].WorkingHours.indexOf("8 Hours") > -1) {
                                    jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td>  <td class="d-none d-xl-table-cell text-success">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].loginTime + '</td> <td class="d-none d-xl-table-cell">' + data[i].Logout + '</td>  <td class="d-none d-xl-table-cell  text-success">' + data[i].WorkingHours + '</td>   <td class="d-none d-xl-table-cell">' + data[i].DayName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].AttendanceDate + '</td>   </tr>').appendTo("#TableTbody");

                                } else if (data[i].WorkingHours.indexOf("6 Hours") > -1) {
                                    jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td>  <td class="d-none d-xl-table-cell text-warning">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].loginTime + '</td> <td class="d-none d-xl-table-cell">' + data[i].Logout + '</td>  <td class="d-none d-xl-table-cell  text-warning">' + data[i].WorkingHours + '</td>  <td class="d-none d-xl-table-cell">' + data[i].DayName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].AttendanceDate + '</td>   </tr>').appendTo("#TableTbody");

                                }else{
                                    jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td>  <td class="d-none d-xl-table-cell text-danger">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].loginTime + '</td> <td class="d-none d-xl-table-cell">' + data[i].Logout + '</td> <td class="d-none d-xl-table-cell  text-danger">' + data[i].WorkingHours + '</td>  <td class="d-none d-xl-table-cell">' + data[i].DayName + '</td>  <td class="d-none d-xl-table-cell">' + data[i].AttendanceDate + '</td>   </tr>').appendTo("#TableTbody");

                                }//<td class="d-none d-xl-table-cell  text-danger">' + data[i].WorkingHours + '</td> 
                                       j++;
                            }
                        
                        
                    }
                    /// end success
                    $(".loaderbg").hide();
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid p-0">

        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>SHOW ATTENDANCE</h3>
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
                <%--<h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Attendance Summary</h5>--%>
            </div>
            <div class="card-body">

                <div class="row mt-4">
                    <div class="col-md-3">
                        <label class="form-label">Select Type of Attendance.</label>
                        <select class="form-select mb-3" id="DD">
                            <option  selected value="Biometric">Biometric</option>
                            <option value="WFH">Work From Home</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Select Dates:</label>
                        <input id="reportrange" class="form-control form-select" />
                    </div>


                    <div class="col-md-3">
                        <label class="form-label">Enter official mail id</label>
                        <input list="select" type="text" id="SearchText" class="form-control"  style="border-radius: 4px;" />
                        <datalist class="MeClass" id="select">
                        </datalist>
                    </div>

                    
                    <div class="col-md-2 pt-4">
                        <a href="#" onclick="GetDate()" class="btn btn-primary float-end w-100 mt-1"><i class="fa fa-search"></i>Search </a>
                    </div>
                </div>

            </div>

        </div>
        <div class="card flex-fill">

            <div class="card-header">
                <h5 id="ShowLeaveType" class="card-title mb-0" style="display: block; width: 240px; float: left;">Summary</h5>
                <a onclick="PageRotate()">
                    <h5 class="" style="float: right;"><i class="fa-solid fa-arrows-rotate"></i></h5>
                </a>
            </div>
            <table id="datatables-dashboard-projects" class="table table-striped my-0">
                <thead id="TableThead">
                </thead>
                <tbody id="TableTbody">
                </tbody>
            </table>
        </div>
    </div>


    <script type="text/javascript">
        $(function () {
            //debugger;
            var start = moment().subtract(29, 'days');
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
</asp:Content>



