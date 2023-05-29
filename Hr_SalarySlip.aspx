<%@ Page Title="" Language="C#" MasterPageFile="~/HRMasterPage.master" AutoEventWireup="true" CodeFile="Hr_SalarySlip.aspx.cs" Inherits="Hr_SalarySlip" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
        function GetDetailsMonthBy() {
            var MonthNo = $("#MonthDrop option:selected").val();
            $.ajax({
                type: "POST",
                url: "MasterPage.aspx/SalaryEmloyee",
                data: '{MonthNo : "'+MonthNo+'",Sno : "<%= Session["LoginSno"].ToString()%>" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    xmlDoc = r.d;
                    if (xmlDoc == 0 || xmlDoc == '0') {
                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "Details Not Found  !",
                            timer: 3000
                        });
                    } else {
                        window.open("SalarySlip.aspx?Monthno=" + MonthNo);
                    }
                }
            });
           // 
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Salary Slip Print</h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
        </div>
    </div>

    <div class="card flex-fill">
        <div class="card-header">
     
         <button class="btn btn-sm btn-primary float-end 0" id="download-button"><i class="fa fa-print"></i> Print </button>
             &nbsp; &nbsp;
            <div class="input-group input-group-sm" style="width: 200px; float: left;">
                <select id="MonthDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                </select>
            </div>
        </div>

    </div>

    

</asp:Content>