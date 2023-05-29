<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_ViewProfile.aspx.cs" Inherits="Admin_ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script src="JsDB/bootstrap.js"></script>
    <script src="JsDB/javascript.js"></script>
    <script type="text/javascript">
        var Count = 6;
        $(document).ready(function () {
            // get time

            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }
            // end
            // get employee details list
            GetEmployeeDetails(Count, 'NA');
            //button backspace get list
            var input = document.getElementById('SearchText');
            input.addEventListener('keydown', function (event) {
                const key = event.key;
                if (key === "Backspace") {
                    GetEmployeeDetails(6, 'NA');
                }
            });


            //
            // search by Email 
            $("#SearchText").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/Employee_MasterService.asmx/GetNameList',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        var ddlCustomers = $("[id*=select2]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {
                            ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                        });

                    }

                });
            });

            $('#SearchText').on('change', function () {
                GetEmployeeDetails(0,$("#SearchText").val().trim());
            });

        });

        // show Employee Full Details
        function fun(id) {
            alert('hello' + id);
        }
       
        /*
        :  function get employee Details List
        */
        function GetEmployeeDetails(Count, Email) {
            if (Count < 0) {
                Count = 6;
                fun(6);
            }
            var formData = new FormData();
                formData.append("count", Count);
                formData.append("Email", Email);
                jQuery.ajax({
                    url: 'WebServerFile/Hr_MasterWebService.asmx/GetEmployeeAllRecord',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (date) {
                        if (date[0].response == 'Fail') {
                            Swal.fire({
                                icon: 'info',
                                width: '300px',
                                text: "No details found.",
                                timer: 3000
                            });
                            
                        } else {
                            $("#employeeCart").empty();
                            var j = 1;
                            for (var i = 0; i < date.length; i++) {
                                $("#employeeCart").append('<div class="col-xl-4"> <div class="card"> <div class="card-header"> <h5 class="card-title mb-0"> ' + date[i].EmpName + ' </h5> </div> <div class="card-body"> <div class="row g-0"> <div class="col-sm-3 col-xl-12 col-xxl-3 text-center"> <img src="' + date[i].Image + '" width="64" height="64" class="rounded-circle mt-2" alt=""> </div> <div class="col-sm-9 col-xl-12 col-xxl-9"> <strong style="font-size: 18px;"> ' + date[i].JobProfile + ' </strong> <br> <small> ' + date[i].Department + '</small> <br> <small> ' + date[i].officeEmail + ' </small> <br> <small> ' + date[i].Mobile + ' </small> <br> <a onclick="GetEmployeeDetailsAll( ' + date[i].Sno + ' )"><span class="badge bg-success float-end">More Details</span></a> </div> </div> </div> </div> </div> ');
                                j++;

                            }
                        }
                    },
                    error: function (sd) {
                        // alert("fail");
                    }
                });
            
        }
        //  end Function
        // GetEmployeeDetailsAll
        function GetEmployeeDetailsAll(Sno) {
            window.open("ViewEmployeeProfile.aspx?Sno=" + Sno);
        }
        //
        function fun(d) {
            Count = d;
        }
        // getEmployeeNextRecord

        function getEmployeeNextRecord() {
            Count +=6;
            GetEmployeeDetails(Count, 'NA');
        }
        // getEmployeePreRecord
        function getEmployeePreRecord() {
            Count -=6;
            GetEmployeeDetails(Count, 'NA');
        }
        //
        // Pagereload
        function PageReload() {
            location.reload();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3>Employees</h3>

                            </div>
                            <div class="input-group mb-3" style="width: 260px; float: right;">
                                 <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
                                <span class="input-group-text"><i class="fa fa-search"></i></span>
                            </div>

                            <div class="col-auto ms-auto text-end mt-n1">

                                <div class=" me-2 d-inline-block">
                                    <span class="btn btn-light bg-white shadow-sm " >
                                        <i class="align-middle mt-n1" data-feather="calendar"></i> <strong class="cv">2022/10/12 - 12:11:47</strong>
                                    </span>
                                </div>

                                <button class="btn btn-primary shadow-sm" onclick="PageReload()">
                                    <i class="align-middle" data-feather="refresh-cw">&nbsp;</i>
                                </button>
                            </div>
                        </div>
                        <div class="row" id="employeeCart">
                           <%-- <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Nishant Kumar</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-0">
                                            <div class="col-sm-3 col-xl-12 col-xxl-3 text-center">
                                                <img src="img/av.png" width="64" height="64" class="rounded-circle mt-2" alt="">
                                            </div>
                                            <div class="col-sm-9 col-xl-12 col-xxl-9">
                                                <strong style="font-size: 18px;">Nishant Kumar</strong>
                                                <br>
                                                <small>ASP DotNet Developer</small>
                                                <br>
                                                <small>nishant.k@genesis-in.com</small>
                                                <br>
                                                <a><span class="badge bg-success float-end">More Details</span></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Nishant Kumar</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-0">
                                            <div class="col-sm-3 col-xl-12 col-xxl-3 text-center">
                                                <img src="img/av.png" width="64" height="64" class="rounded-circle mt-2" alt="">
                                            </div>
                                            <div class="col-sm-9 col-xl-12 col-xxl-9">
                                                <strong style="font-size: 18px;">Nishant Kumar</strong>
                                                <br>
                                                <small>ASP DotNet Developer</small>
                                                <br>
                                                <small>nishant.k@genesis-in.com</small>
                                                <br>
                                                <a><span class="badge bg-success float-end">More Details</span></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Nishant Kumar</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-0">
                                            <div class="col-sm-3 col-xl-12 col-xxl-3 text-center">
                                                <img src="img/av.png" width="64" height="64" class="rounded-circle mt-2" alt="">
                                            </div>
                                            <div class="col-sm-9 col-xl-12 col-xxl-9">
                                                <strong style="font-size: 18px;">Nishant Kumar</strong>
                                                <br>
                                                <small>ASP DotNet Developer</small>
                                                <br>
                                                <small>nishant.k@genesis-in.com</small>
                                                <br>
                                                <a><span class="badge bg-success float-end">More Details</span></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>--%>                              
                        </div>

                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="dataTables_paginate paging_simple_numbers float-end" id="datatables-dashboard-projects_paginate">
                                    <ul class="pagination">
                                        
                                        <%--<li class="paginate_button page-item active"><a href="#" aria-controls="datatables-dashboard-projects" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                        <li class="paginate_button page-item "><a href="#" aria-controls="datatables-dashboard-projects" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>--%>
                                        <%--<li class="paginate_button page-item previous disabled" id="datatables-dashboard-projects_previous"><a href="#" aria-controls="datatables-dashboard-projects" data-dt-idx="0" tabindex="0" class="page-link" onclick="fun()" >Previous</a></li>--%>
                                        <li class="paginate_button page-item previous " id="datatables-dashboard-projects_previous"><a href="#" aria-controls="datatables-dashboard-projects" data-dt-idx="0" tabindex="0" class="page-link" onclick="getEmployeePreRecord()" >Previous</a></li> <input type="hidden" id="PreviousNo" />
                                        <li class="paginate_button page-item next" id="datatables-dashboard-projects_next"><a href="#" aria-controls="datatables-dashboard-projects" data-dt-idx="3" tabindex="0" class="page-link" onclick="getEmployeeNextRecord()">Next</a></li> <input type="hidden" id="NextNo" />
                                    </ul>
                                </div>
                            </div>
                        </div>





</asp:Content>
