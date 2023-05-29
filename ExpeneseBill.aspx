<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ExpeneseBill.aspx.cs" Inherits="ExpeneseBill" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            GetExpenseBill("Processing", "NA", "NA");

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

        function GetExpenseBill(BillType, Email, formto) {

            var formData = new FormData();
            formData.append("BillType", BillType);
            formData.append("Email", Email);
            formData.append("formto", formto);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/GetExpeneseBill',
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
                        jQuery(' <thead><tr><th>S.No.</th>  <th class="d-none d-xl-table-cell">Employee Name</th>  <th class="d-none d-xl-table-cell">Expenese Type</th><th class="d-none d-xl-table-cell">Amount</th><th class="d-none d-xl-table-cell">Purpose</th> <th class="d-none d-xl-table-cell"> Approved By</th><th class="d-none d-xl-table-cell">Payment Status</th>  <th class="d-none d-xl-table-cell">Update Payment </th> <th class="d-none d-xl-table-cell">Download </th></tr></thead>').appendTo("#TableTbody");
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].PaymentStatus == "Done") {
                                jQuery('<tbody> <td style=" display :none;"> ' + data[i].URL + '</td> <td style=" display :none;"> ' + data[i].id + '</td>'
                                 + '<tr> <td>' + j + '</td><td>' + data[i].EmpName + '</td> <td>' + data[i].TypeExp + '</td><td>' + data[i].Amount + '</td> <td>' + data[i].Purpose + '</td>  <td>' + data[i].ApprovedName + '</td> <td>' + data[i].PaymentStatus + '</td>  <td> <br/> </td>'
                                 //<a herf="#" class="btn btn-sm btn-primary" onclick="UpdatePayStatus(' + data[i].id + ')">Update Payment</a> 
                               + '<td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; </td>'
                               + '</tr>  </tbody> ').appendTo("#TableTbody");

                            } else {
                                jQuery('<tbody> <td style=" display :none;"> ' + data[i].URL + '</td> <td style=" display :none;"> ' + data[i].id + '</td>'
                                    + '<tr> <td>' + j + '</td><td>' + data[i].EmpName + '</td> <td>' + data[i].TypeExp + '</td><td>' + data[i].Amount + '</td> <td>' + data[i].Purpose + '</td>  <td>' + data[i].ApprovedName + '</td> <td>' + data[i].PaymentStatus + '</td>  <td> <a herf="#" class="btn btn-sm btn-primary" onclick="UpdatePayStatus(' + data[i].id + ')">Update Payment</a> </td>'
                                  + '<td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; </td>'
                                  + '</tr>  </tbody> ').appendTo("#TableTbody");
                            }
                            j++;
                        }
                    }
                }
            });
        }

        function UpdatePayStatus(id) {
            var formData = new FormData();
            formData.append("id", id);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/UpdatePaymentStatus',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    if (Result == 'Save') {
                        Swal.fire({
                            icon: 'success',
                            title: 'success',
                            width: '300px',
                            text: 'Payment Update success.!',
                            timer: 1500
                        })
                    } else {
                        Swal.fire({
                            icon: 'info',
                            title: 'info',
                            width: '300px',
                            text: 'Data Not Found.!',
                            timer: 1500
                        })
                    }
                }
            });
        }
        function DowFun(j) {
            var x = document.getElementById("TableTbody").rows[j].cells.item(0).innerText;
            // alert(x + " ," + j);
            $.ajax({
                url: x,
                method: 'GET',
                xhrFields: {
                    responseType: 'blob'
                },
                success: function (data) {
                    var a = document.createElement('a');
                    var url = window.URL.createObjectURL(data);
                    a.href = url;
                    a.download = 'myfile.pdf';
                    document.body.append(a);
                    a.click();
                    a.remove();
                    window.URL.revokeObjectURL(url);
                }
                // calling download function
            })
        }
        function GetDate() {
            var TypeBill = $("#BillType option:selected").val();
            var Date = $("#reportrange").val();
            var Name = $("#SearchText").val();
            if (Name == "" || Name.length == 0) {

                GetExpenseBill(TypeBill, "NA", Date);

            } else {
                GetExpenseBill(TypeBill, Name, Date);

            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container-fluid p-0">

        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>Expenese Bill</h3>
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
                <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Expenese Bill</h5>
            </div>
            <div class="card-body">

                <div class="row mt-4">
                    <div class="col-md-3">
                        <label class="form-label">Select Type of Bill.</label>
                        <select class="form-select mb-3" id="BillType">
                            <option value="Done">Paid Bill</option>
                            <option value="Processing">Pending Bill</option>
                        </select>
                    </div>

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

                    <div class="col-md-2 pt-4">
                        <a href="#" onclick="GetDate()" class="btn btn-primary float-end w-100 mt-1"><i class="fa fa-search"></i>Search... </a>
                    </div>
                </div>

            </div>

        </div>
        <div class="card flex-fill">

            <div class="card-header">
                <h5 id="ShowLeaveType" class="card-title mb-0" style="display: block; width: 240px; float: left;">Expenese List</h5>
       
            </div>
            <table id="TableTbody" class="table table-striped my-0 text-center">
      
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
