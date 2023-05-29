<%@ Page Title="" Language="C#" MasterPageFile="~/Finance_MasterPage.master" AutoEventWireup="true" CodeFile="Finance_ExpeneseBill.aspx.cs" Inherits="Finance_ExpeneseBill" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            /// Search Employee Name List
            $("#SearchText").keypress(function () {
                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/Emp_WorkService.asmx/GetNameList',
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
            //function GetDetailsMonthBy() {
            //    var YearNo = $("#MonthYear option:selected").text();
            //    var MonthNo = $("#MonthDrop option:selected").val();
            //    var MonthName = $("#MonthDrop option:selected").text();
            //var formData = new FormData();
            //formData.append("Year", YearNo);
            //formData.append("Monh", MonthNo);
            //formData.append("Type", 2);
            // $.ajax({
            //     url: 'WebServerFile/Finance_MasterService.asmx/GetEPF',
            //     type: 'POST',
            //     data: formData,
            //     cache: false,
            //     contentType: false,
            //     processData: false,
            //     success: function (data) {
            //         if (data[0].response == "Fail") {
            //             Swal.fire({
            //                 icon: 'info',
            //                 title: 'info',
            //                 width: '300px',
            //                 text: 'Data Not Found.!',
            //                 timer: 1500
            //             })
            //         } else {
            //             $("#TableTbody").empty();
            //             var j = 1;
            //             for (var i = 0; i < data.length; i++) {

            //                 jQuery('<tr> <td>' + j + '</td><td>' + data[i].EmpCode + '</td><td>' + data[i].EmpName + '</td> <td>' + MonthName + "-" + YearNo + '</td> <td>' + data[i].ESIC_E + '</td> <td>' + data[i].ESIC_ER + '</td>  <td>' + data[i].Total + '</td> '
            //                    + ' </td>     </tr>').appendTo("#TableTbody");
            //                       j++;
            //                 // end for loop
            //             }
            //         }
            //     }
            // });
      
            //}
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Expenese Bill</h5>
        </div>
        <div class="card-body">

            <div class="row mt-4">
                <div class="col-md-3">
                    <label class="form-label">Select Type of Bill.</label>
                    <select class="form-select mb-3" onchange="GetLevaTypeFun()" id="DD">
                    <option value="S" selected="selected">Select...</option>
                    <option value="A">Paid Bill</option>
                    <option value="W">Pending Bill</option>
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
            <h5 id="ShowLeaveType" class="card-title mb-0" style="display: block; width: 240px; float: left;">Expenese List</h5>
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