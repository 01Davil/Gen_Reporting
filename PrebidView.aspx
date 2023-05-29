<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="PrebidView.aspx.cs" Inherits="PrebidView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">   
    <script src="JsDB/jquery.js" type="text/javascript"></script>
    <script src="JsDB/popper.min.js" type="text/javascript"></script>
    <script src="JsDB/javascript.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js" type="text/javascript"></script>
    <style type="text/css">
        .br {
            border-right: 1px solid #707070;
            padding: 13px !important;
        }
    </style>
     <script type="text/javascript">
 
     $(document).ready(function () {
         var a;
         a = setInterval(fun, 1000);
         function fun() {
             //  getTenderDetails();
         }

         $(function () {
             getPrebidDetails();

         });
         $(document).ready(function () {
             var a;
             a = setInterval(fun, 1000);
             function fun() {
                 var today = new Date();
                 var now = today.toLocaleString();
                 $(".cv").text(now);

             }
         });

         $('input.float').on('input', function () {
             this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');
         });

         $('.numberonly').keypress(function (e) {

             var charCode = (e.which) ? e.which : event.keyCode

             if (String.fromCharCode(charCode).match(/[^0-9]/g)) {

                 Swal.fire('Please Enter Number');

                 return false;
             }

         });

     });



     function getPrebidDetails() {
        // debugger
         var formData = new FormData();
        
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/GetprebbidList',
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
                     $("#completeprojecttbl").empty();
                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         jQuery('<tr><td> ' + j + '   </td><td>' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].AttenderName + ' </td><td>' + data[i].Discussion + ' </td><td>' + data[i].OurQuery + '  </td><td>' + data[i].Status + ' </td> <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td> <td>' + data[i].MeetingDate + ' </td>   <td> <button type="button" class="btn btn-primary" id="update' + j + ' " onclick="ViewListModal(' + data[i].id + ')">  List </button> </td> </tr>').appendTo("#completeprojecttbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }


     //        view list Modal
     function ViewListModal(id) {
      // debugger
         var formData = new FormData();
         formData.append("id", id);
         alert(id);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/ViewpreBidmulti',
             type: 'POST',
             data: formData,
             cache: false,
             contentType: false,
             processData: false,
             success: function (data) {
                 if (data.length > 0) {
                     // xmlDoc = data.d;
                     $("#Table1").empty();

                     $("#Table1").append("<thead  class='br'><tr> <th class='br'>S.No</th> <th class='br'>Other_CompanyName</th><th class='br'>Other_CompanyQuery</th><th class='br'>Other_CompFile</th>  </thead>");
                     var j = 1;
                     for (var i = 0; i <= data.length - 1; i++) {
                         jQuery('<tr><td class="br"> ' + j + '   </td><td class="br">' + data[i].Other_CompanyName + '  </td> <td class="br">' + data[i].Other_CompanyQuery + ' </td><td> <a  id="Dow2"' + j + ' onclick="DowFun2(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a> </td>   </tr>').appendTo("#Table1");
                         j++;
                     }

                     //open 
                     $("#ViewListModal").modal('show');
                     //
                 }
                 else {
                     $("#Table1").empty();
                     Swal.fire("Data not Found.:");
                 }
             },
             error: function (data) {
                 Swal.fire("Get date function Error :");
             }
         });
     }



     function DowFun(id) {
        // debugger;     
         var x = document.getElementById("completeprojecttbl").rows[id-1].cells.item(1).innerText;
         alert("id " + id + ",url : " + x);
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


         //view mutliple download
   

     function DowFun2(j) {
        // debugger;
         var z = document.getElementById("Table1").rows[j].cells.item(1).innerText;
         alert("j " + j + ",url : " + z);
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
     



    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="col-auto ms-auto text-end mt-n1">

        <div class=" me-2 d-inline-block">
            <span class="btn btn-light bg-white shadow-sm ">
                <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
            </span>
        </div>
    </div>

    <div class="card flex-fill">
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Prebid result</h5>


        </div>
        <div style="width: 100%; float: left; overflow: auto;">
            <table id="datatables-dashboard-projects" class="table table-striped my-0">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th class="d-none d-xl-table-cell">Tender Name/Doc ID</th>
                        <th class="d-none d-xl-table-cell">Company Name</th>
                        <th class="d-none d-xl-table-cell">Attender Name</th>
                        <th class="d-none d-xl-table-cell">Discussion</th>
                        <th class="d-none d-xl-table-cell">Our Query</th>
                        <th class="d-none d-xl-table-cell">Status</th>
                        <th class="d-none d-xl-table-cell">Upload File</th>
                        <th class="d-none d-xl-table-cell">Meeting Date</th>
                        <th class="d-none d-xl-table-cell">Pre-Bid Multiple List</th>                        
                  
                    </tr>
                </thead>
                <tbody id="completeprojecttbl">
                </tbody>
            </table>
        </div>
    </div>


   






  

    <%--demo modal--%>
    <!-- .modal -->
    <div class="modal fade" id="Mymodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Notification</h4>
                </div>
                <div class="modal-body">
                    Are you sure you want to continue?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>



    <div class="modal fade" id="ViewListModal" tabindex="-1" role="dialog" aria-hidden="true" style="left: 100px; top: 100px;">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">View bid tender</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-3">
                    <div class="tab-pane" id="Div1" role="tabpanel">
                        <div class="row">
                            <div class="col-md-12">
                                <h4 class="float-start">Tenders list</h4>

                            </div>
                            <div class="col-md-12">
                                <hr>
                                <div style="width: 100%; float: left; overflow: auto;">
                                    <table id="Table1" class="table table-striped my-0">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <%-- //Upload pdf multiple--%>

    <div class="modal fade " id="Uploadpdf" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content" style="width: 900px; margin: 20vh auto 0px auto; float: right;">
                <div class="modal-header">
                    <h5 class="modal-title">View Uploaded Tender Document Pdf</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-3">
                    <div class="tab-pane" id="Div4" role="tabpanel">
                        <div class="row">
                            <div class="col-md-12">
                                <h4 class="float-start">Tenders Pdf list</h4>

                            </div>
                            <div class="col-md-12">

                                <div style="width: 100%; float: right; overflow: auto;">
                                    <table id="Table2" class="table table-striped my-0">

                                        <thead id="tableh"></thead>
                                        <tbody id="tableb"></tbody>

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>


