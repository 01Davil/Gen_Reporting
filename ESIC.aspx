<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ESIC.aspx.cs" Inherits="ESIC" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js"></script>  
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


            $(function () {
                $.ajax({
                    type: "POST",
                    url: "EPF.aspx/GetYear",
                    data: '{ }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;
                        var ddlCustomers = $("[id*=MonthYear]");
                        ddlCustomers.empty().append('<option selected="selected" value="0">Select Year</option>');
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].YearNo).html(xmlDoc[i].YearName));
                        }

                    }
                });
            });

        });
        function GetDetailsYearBy() {
            var YearNo = $("#MonthYear option:selected").text();
            $.ajax({
                type: "POST",
                url: "MasterPage.aspx/GetMonthWithYear",
                data: '{ YearNo : "' + YearNo + '"}',
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
        }


        // func

            function GetDetailsMonthBy() {
                var YearNo = $("#MonthYear option:selected").text();
                var MonthNo = $("#MonthDrop option:selected").val();
                var MonthName = $("#MonthDrop option:selected").text();
            var formData = new FormData();
            formData.append("Year", YearNo);
            formData.append("Monh", MonthNo);
            formData.append("Type", 2);
             $.ajax({
                 url: 'WebServerFile/WebService.asmx/Get_EPF_ESIC',
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
                     } else {
                         $("#TableTbody").empty();
                         var j = 1;
                         for (var i = 0; i < data.length; i++) {

                             jQuery('<tr> <td>' + j + '</td><td>' + data[i].EmpCode + '</td><td>' + data[i].EmpName + '</td> <td>' + MonthName + "-" + YearNo + '</td> <td>' + data[i].ESIC_E + '</td> <td>' + data[i].ESIC_ER + '</td>  <td>' + data[i].Total + '</td> '
                                + ' </td>     </tr>').appendTo("#TableTbody");
                                   j++;
                             // end for loop
                         }
                     }
                 }
             });
      
            }

            function BankSlipToExcel(tableID, filename) 
            {
                filename = 'ExcelSlip';
                    var downloadurl;
                    var dataFileType = 'application/vnd.ms-excel';
                    var tableSelect = document.getElementById(tableID);
                    var tableHTMLData = tableSelect.outerHTML.replace(/ /g, '%20');
                    // Specify file name
                    filename = filename ? filename + '.xls' : 'export_excel_data.xls';

                    // Create download link element
                    downloadurl = document.createElement("a");

                    document.body.appendChild(downloadurl);

                    if (navigator.msSaveOrOpenBlob) {
                        var blob = new Blob(['\ufeff', tableHTMLData], {
                            type: dataFileType
                        });
                        navigator.msSaveOrOpenBlob(blob, filename);
                    } else {
                        // Create a link to the file
                        downloadurl.href = 'data:' + dataFileType + ', ' + tableHTMLData;

                        downloadurl.download = filename;

                        downloadurl.click();

                    }

                }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
      <div class="container-fluid p-0">

        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>ESIC </h3>
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
    <div class="card flex-fill" id="MainDiv">
        <div class="card-header">
            <%--<h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">ESIC Results</h5>
            --%>
            <div class="input-group input-group-sm ms-2" style="width: 200px; float: left;">
                      <select id="MonthYear" class="form-select" style="border-radius: 4px;" onchange="GetDetailsYearBy()">
                </select>
            </div>
            <div class="input-group input-group-sm ms-2" style="width: 200px; float: left;">
                      <select id="MonthDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                </select>
            </div>
                 <%--<div class="input-group input-group-sm" style="width: 200px; float: right;">
               
              <button  id="create_pdf" type="submit" class="btn btn-primary float-end " > <i class="fa fa-file-excel"></i> Download Report in PDF</button>
            </div>--%>
                <div class="input-group input-group-sm" style="width: 200px; float: right;">
               
              <button   type="submit"  onclick="BankSlipToExcel('BanlSlipTable', 'user-data')" class="btn btn-primary float-end " > <i class="fa fa-file-excel"></i> Download Report in Excel</button>
            </div>
        </div>
        <div id="pdfDiv">
        <table id="BanlSlipTable" class="table table-striped my-0">
            <thead>
                <tr>
                    <th>S.No.</th>
                    <th class="d-none d-xl-table-cell">Emp. ID</th>
                    <th class="d-none d-xl-table-cell">Emp Name</th>
                    <th class="d-none d-xl-table-cell">Date</th>
                    <th class="d-none d-xl-table-cell">ESIC-E <samp>Employee </samp></th>
                    <th class="d-none d-xl-table-cell">ESIC-ER <samp>Employer</samp></th>
                    <th class="d-none d-md-table-cell">Total</th>
                </tr>
            </thead>
            <tbody id="TableTbody">
                
            </tbody>
        </table>
            </div>
    </div>
    </div>
    <%--  --%>


    <script>  
    (function () {  
        var  
         form = $('#pdfDiv'),
         cache_width = form.width(),  
         a4 = [595.28, 841.89]; // for a4 size paper width and height  
  
        $('#create_pdf').on('click', function () {  
            $('body').scrollTop(0);  
            createPDF();  
        });  
        //create pdf  
        function createPDF() {  
            getCanvas().then(function (canvas) {  
                var  
                 img = canvas.toDataURL("image/png"),  
                 doc = new jsPDF({  
                     unit: 'px',  
                     format: 'a4'  
                 });  
                doc.addImage(img, 'JPEG', 20, 20);  
                doc.save('ESCI_PDF.pdf');  
                form.width(cache_width);  
            });  
        }  
  
        // create canvas object  
        function getCanvas() {  
            form.width((a4[0] * 1.33333) - 80).css('max-width', 'none');  
            return html2canvas(form, {  
                imageTimeout: 2000,  
                removeContainer: true  
            });  
        }  
  
    }());  
</script>  
</asp:Content>