<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="Emp_ShowAttendance.aspx.cs" Inherits="Emp_ShowAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

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
                        ddlCustomers.empty().append('<option selected="selected" value="0">Select Month</option>');
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].MonthNo).html(xmlDoc[i].MonthName));
                        }

                    }
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Attendance Summery</h5>
            <div class="input-group input-group-sm" style="width: 200px; float: right;">
       <select id="MonthDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                </select>
            </div>
        </div>

<table class="table">
  <thead>
    <tr>
      <th scope="col">Sno</th>
      <th scope="col">Month</th>
      <th scope="col">Total Present </th>
      <th scope="col">Total Absent</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>Sep</td>
      <td>10</td>
      <td>20</td>
    </tr>


  </tbody>
</table>
     <%--   <table id="datatables-dashboard-projects" class="table table-striped my-0">
            <thead>
                <tr>
                    <th>Employee Code</th>
                    <th class="d-none d-xl-table-cell">Employee Name</th>
                    <th class="d-none d-xl-table-cell">ESIC No.</th>
                    <th class="d-none d-xl-table-cell">Basic</th>
                    <th class="d-none d-md-table-cell">HRA</th>
                    <th class="d-none d-md-table-cell">Conveyance</th>
                    <th class="d-none d-md-table-cell">Allowance</th>
                    <th class="d-none d-md-table-cell">Extra Allowance</th>
                    <th class="d-none d-md-table-cell">Medical Allowance</th>
                    <th class="d-none d-md-table-cell">Special Allowance</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>01</td>
                    <td class="d-none d-xl-table-cell">GEN/221920/044</td>
                    <td class="d-none d-xl-table-cell">Abhishek</td>
                    <td class="d-none d-md-table-cell">ABC</td>
                    <td class="d-none d-md-table-cell">0</td>
                    <td class="d-none d-md-table-cell">0</td>
                    <td class="d-none d-md-table-cell">0</td>
                    <td class="d-none d-md-table-cell">0</td>
                    <td class="d-none d-md-table-cell">0</td>
                    <td class="d-none d-md-table-cell">0</td>
                </tr>

            </tbody>
        </table>--%>
    </div>

</asp:Content>

