<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_ShowAttendance.aspx.cs" Inherits="Admin_ShowAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {


            var input = document.getElementById('SearchText');
            input.addEventListener('keydown', function (event) {
                const key = event.key;
                if (key === "Backspace") {
                    GetDefalutLeave('Today', 'NA', 'NA', "ToDay Attendance");
                }
            });


            //ShowLeaveType
            $(function () {
                GetDefalutLeave('Today', 'NA', 'NA', "ToDay Attendance");
            });

            /// Search Employee Name List
            $("#SearchText").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/Hr_MasterWebService.asmx/GetNameList',
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
            $('#SearchText').on('change', function () {

                var Type = $("#DD option:selected").val();
                if (Type == "Today") {
                    GetDefalutLeave(Type, $("#SearchText").val().trim(), 'NA', "Today Attendance");
                } else if (Type == 'Bio') {
                    GetDefalutLeave(Type, $("#SearchText").val().trim(), 'NA', "Today Attendance Biometric");
                } else {
                    //(Type == "WFH")
                    GetDefalutLeave(Type, $("#SearchText").val().trim(), 'NA', "Today Attendance Work From Home");
                }


            });

        });

        function GetDefalutLeave(LeaveType, EmpName, Date, TextShow) {
            $("#ShowLeaveType").html(TextShow);
            var formData = new FormData();
            formData.append("LeaveType", LeaveType);
            formData.append("EmpName", EmpName);
            formData.append("Date", Date);
            $.ajax({
                url: 'WebServerFile/Hr_MasterWebService.asmx/GetAttendanceSummery',
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
                        $("#ShowLeaveType").html('');
                        $("#TableTbody").empty();
                        $("#TableThead").empty();
                    } else {
                        if (LeaveType == "Today") {
                            $("#TableTbody").empty();
                            $("#TableThead").empty();
                            jQuery('<tr><th>S.No.</th><th class="d-none d-xl-table-cell">Emp_Name</th><th class="d-none d-xl-table-cell">Login Time</th><th class="d-none d-xl-table-cell">Logout Time</th><th class="d-none d-md-table-cell">Type Attendance</th><th class="d-none d-md-table-cell">Attendance Date</th></tr>').appendTo("#TableThead");
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                                jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].LoginTime + '</td> <td class="d-none d-xl-table-cell">' + data[i].LogoutTime + '</td> <td class="d-none d-xl-table-cell">' + data[i].TypeAtt + '</td>  <td class="d-none d-xl-table-cell">' + data[i].AttDate + '</td>   </tr>').appendTo("#TableTbody");
                                j++;
                            }

                        } else if (LeaveType == "Bio") {
                            $("#TableTbody").empty();
                            $("#TableThead").empty();
                            jQuery('<tr><th>S.No.</th> <th class="d-none d-xl-table-cell">Biometric ID</th> <th class="d-none d-xl-table-cell">Emp_Name</th> <th class="d-none d-xl-table-cell">Login Time</th><th class="d-none d-xl-table-cell">Logout Time</th><th class="d-none d-md-table-cell">Attendance Date</th></tr>').appendTo("#TableThead");
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                                jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].BioID + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].LoginTime + '</td> <td class="d-none d-xl-table-cell">' + data[i].LogoutTime + '</td>  <td class="d-none d-xl-table-cell">' + data[i].AttDate + '</td>   </tr>').appendTo("#TableTbody");
                                j++;
                            }
                        } else if (LeaveType == "WFH") {
                            $("#TableTbody").empty();
                            $("#TableThead").empty();
                            jQuery('<tr><th>S.No.</th> <th class="d-none d-xl-table-cell">Emp_Name</th> <th class="d-none d-xl-table-cell">Login Time</th><th class="d-none d-xl-table-cell">Logout Time</th><th class="d-none d-md-table-cell">Attendance Date</th></tr>').appendTo("#TableThead");
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {
                                jQuery('<tr><td class="d-none d-xl-table-cell">' + j + '</td> <td class="d-none d-xl-table-cell">' + data[i].EmpName + '</td> <td class="d-none d-xl-table-cell">' + data[i].LoginTime + '</td> <td class="d-none d-xl-table-cell">' + data[i].LogoutTime + '</td>  <td class="d-none d-xl-table-cell">' + data[i].AttDate + '</td>   </tr>').appendTo("#TableTbody");
                                j++;
                            }

                        }
                        // end else main
                    }
                    /// end success
                }
            });

        }
        function GetLevaTypeFun() {
            var Type = $("#DD option:selected").val();
            if (Type == "Today") {
                GetDefalutLeave(Type, 'NA', 'NA', "Today Attendance ");
            } else if (Type == 'Bio') {
                GetDefalutLeave(Type, 'NA', 'NA', "Today Attendance Biometric");
            } else   {
                //(Type == "WFH")
                GetDefalutLeave(Type, 'NA', 'NA', "Today Attendance Work From Home");
            }

        }
        function PageRotate() {
            GetDefalutLeave('Today', 'NA', 'NA', "Today Attendance");
        }
        function GetDate() {
            var Date = $("#reportrange").val();
            var Name = $("#SearchText").val();
            if (Name.length == 0 || Name == '') {
                Name = "NA";
            }

            var Type = $("#DD option:selected").val();
            //alert(Type);
            if (Type == "Today") {
                Swal.fire({
                    icon: 'info',
                    title: 'info',
                    width: '300px',
                    text: 'please select a valid option.!',
                    timer: 1500
                })
            } else if (Type == "Bio") {
                GetDefalutLeave('Bio', Name, Date, "Biometric Attendance");
            } else   {
                //(Type == "WFH")
                GetDefalutLeave('WFH', Name, Date, "WFH Attendance");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Attendance Summary</h5>
        </div>
        <div class="card-body">

            <div class="row mt-4">
                <div class="col-md-3">
                    <label class="form-label">Select Type of Attendance.</label>
                    <select class="form-select mb-3" onchange="GetLevaTypeFun()" id="DD">
                        <option selected="" value="Today">Select</option>
                        <option value="Bio">Biometric</option>
                        <option value="WFH">Work From Home</option>
                        <%--<option value="Month">Month Wise</option>--%>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Employee Name </label>
                    <input list="select" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                    <datalist class="MeClass" id="select">
                    </datalist>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Select Dates:</label>
                   <input id="reportrange"/> </span><i class="fa fa-caret-down"></i></span>
                </div>

                <div class="col-md-2 pt-4">
                    <a href="#" onclick="GetDate()" class="btn btn-primary float-end w-100 mt-1"><i class="fa fa-search"></i>Search </a>
                </div>
            </div>

        </div>

    </div>
    <div class="card flex-fill">

        <div class="card-header">
            <h5 id="ShowLeaveType" class="card-title mb-0" style="display: block; width: 240px; float: left;">Summery</h5>
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
