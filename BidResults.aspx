<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="BidResults.aspx.cs" Inherits="BidResults" %>

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
             getTenderDetails();

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



     function getTenderDetails() {

         var formData = new FormData();
        
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/GetTenderList',
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

                         jQuery('<tr><td> ' + j + '   </td><td>' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].OpeningDate + '  </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_PreBidMeetingTime + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td>  <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>   <td ><table><tr><td> <input type="button" class="btn btn-sm btn-success" Text="View" id="viewdata" ' + j + ' onclick="ServiceView(' + data[i].id + ')" value="Win"> </input></td><td><input type="button" class="btn btn-sm btn-danger" Text="View" id="viewdataa" ' + j + ' onclick="Service(' + data[i].id + ')" value="Lost"> </input></td></tr></table>  </td> <td> <button type="button" class="btn btn-primary" id="update' + j + ' " onclick="ViewListModal(' + data[i].id + ')">  List </button> </td> </tr>').appendTo("#completeprojecttbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }


     //        view list Modal
     function ViewListModal(id) {
         //         debugger;
         //         alert(j);
         //         var x = document.getElementById("completeprojecttbl").rows[j].cells.item(1).innerHTML;
         //       
         var formData = new FormData();
         formData.append("id", id);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/ViewBidDataFull',
             type: 'POST',
             data: formData,
             cache: false,
             contentType: false,
             processData: false,
             success: function (data) {
                 if (data.length > 0) {
                     // xmlDoc = data.d;
                     $("#Table1").empty();

                     $("#Table1").append("<thead  class='br'><tr> <th class='br'>S.No</th> <th class='br'>Tender Name/Doc ID</th><th class='br'>Company Name</th><th class='br'>Publication Date</th><th class='br'>Submitting Date</th><th class='br'>Opening Date</th><th class='br'>Pre Bid Meeting Date</th><th class='br'>Pre Bid Meeting Time</th><th class='br'>Pre Bid Meeting Venue</th><th class='br'>Extended Submission ate</th><th class='br'>Item</th><th class='br'>Quantity</th><th class='br'>Price</th><th class='br'>Location</th><th class='br'>Source </th><th class='br'> Document Sale </th> <th class='br'> Document Fee </th> <th class='br'>Brief Scope </th> <th class='br'>Bid Valid </th><th class='br'>Process Fee </th><th class='br'>Emd</th><th class='br'> Submission Time</th> <th class='br'>Un Price Bid OpenDate</th> <th class='br'>Un Price Bid OpenTime </th> <th class='br'>Pre Bid Opendate</th> <th class='br'>Pre Bid OpenTime</th>  </thead>");
                     var j = 1;
                     for (var i = 0; i <= data.length - 1; i++) {
                         jQuery('<tr><td class="br"> ' + j + '   </td><td class="br">' + data[i].Tender_Name + '  </td> <td class="br">' + data[i].Company_Name + ' </td><td class="br">' + data[i].T_Publication_Date + ' </td><td class="br">' + data[i].T_SubmittingDate + ' </td><td class="br">' + data[i].OpeningDate + '  </td><td class="br">' + data[i].T_PreBidMeetingDate + ' </td><td class="br">' + data[i].T_PreBidMeetingTime + ' </td><td class="br">' + data[i].T_PreBidMeetingV + ' </td><td class="br">' + data[i].Extended_SubmissionDate + ' </td>  <td class="br">' + data[i].T_Item + ' </td><td class="br">' + data[i].T_Quantity + ' </td><td class="br">' + data[i].Price + ' </td><td class="br">' + data[i].T_Location + ' </td>  <td class="br">' + data[i].T_Source + ' </td>  <td class="br">' + data[i].T_Doc_Sale + ' </td> <td class="br">' + data[i].T_Doc_Fee + ' </td> <td class="br">' + data[i].Brief_Scope + ' </td> <td class="br">' + data[i].Bid_Valid + ' </td> <td class="br">' + data[i].T_ProcFee + ' </td> <td class="br">' + data[i].Emd + ' </td> <td class="br">' + data[i].T_SubmTime + ' </td> <td class="br">' + data[i].Un_PricBidOpenDate + ' </td> <td class="br">' + data[i].Un_PricBidOpenTime + ' </td> <td class="br">' + data[i].PBidOpendate + ' </td> <td class="br">' + data[i].PBidOpenTime + ' </td>    </tr>').appendTo("#Table1");
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

         var Tender_Name = document.getElementById("completeprojecttbl").rows[id - 1].cells.item(1).innerText;
        // alert(Tender_Name);

        // debugger;
         var formData = new FormData();
         formData.append("MasterKey2", Tender_Name);

         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/UploadfileBidpdf',
             type: 'POST',
             data: formData,
             cache: false,
             contentType: false,
             processData: false,
             success: function (data) {
                 if (data.length > 0) {

                     $("#Uploadpdf").modal('show');
                     $("#tableb").empty();

                     $("#tableb").append('<tr> <th> S.No</th><th> Url</th>  <th> Download</th> </tr>');
                     var j = 1;
                     for (var i = 0; i <= data.length - 1; i++) {
                         // $("#tableh").append('<tr> <th> S.No</th>  <td> ' + j + '   </td> <th>Download File "' + j + '"</th> <td> <a onclick=(Downloadfile"' + j + '")>' + data[i].id + ' </a> </td>');
                         // $("#tableb").append('<tr>   <td style="display:none">' + data[i].T_File + ' </td> </tr>');
                         jQuery('<tr><td> ' + j + '   </td><td >' + data[i].T_File + ' </td>  <td> <a  id="Dow1"' + j + ' onclick="DowPdfAll(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>   </tr>').appendTo("#Table2");
                         j++;
                     }

                     //open style="display:none"
                     $("#Uploadpdf").modal('show');
                     //                     $("#tableb").empty();
                     //
                 }
                 else {
                     $("#Table2").empty();
                     Swal.fire("Data not Found.:");
                 }

             },
             error: function (data) {
                 Swal.fire("Get date function Error :");
             }
         });

     }


     function DowPdfAll(j) {
        // debugger;
         var x = document.getElementById("Table2").rows[j].cells.item(1).innerText;
       //  alert("j " + j + ",url : " + x);
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

     ////Win model

     function ServiceView(id) {
         //  debugger;

         var formData = new FormData();

         formData.append("id", id);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/GetTenderDataWin',
             type: 'POST',
             data: formData,
             cache: false,
             contentType: false,
             processData: false,
             success: function (data) {
                 $("#Tname").val(data[0].Tender_Name);
                 $("#Titem").val(data[0].T_Item);
                 $("#TQ").val(data[0].T_Quantity);
                 $("#Tprice").val(data[0].Price);
                 $("#DLocation").val(data[0].T_Location);
                 $("#WinModal").modal('show')
             }
         });

     }



     function SaveWinTenderData(e) {
         //debugger;
         e.preventdefault();
         var Tender_Name = $("#Tname").val();
         var Tender_Item = $("#Titem").val();
         var T_Quantity = $("#TQ").val();
         var Price = $("#Tprice").val();
         var Delivery_Date = $("#DDate").val();
         var Delivery_Location = $("#DLocation").val();
         var L1_Our_Company = $("#L1OurC").val();
         var L1_Bid_Price = $("#L1BidP").val();
         var L2_Second_Com = $("#L2SComp").val();
         var L2_Bid_Price = $("#L2SCompBP").val();
         var L3_Third_Comany = $("#L3TComp").val();
         var L3_Bid_Price = $("#L3TCompBP").val();

         if (Delivery_Date == ' ' || Delivery_Date.length == 0 || Delivery_Location == ' ' || Delivery_Location.length == 0 ||
         L1_Our_Company == ' ' || L1_Our_Company.length == 0 || L1_Bid_Price == ' ' || L1_Bid_Price.length == 0 || L2_Second_Com == ' ' || L2_Second_Com.length == 0
         || L2_Bid_Price == ' ' || L2_Bid_Price.length == 0 || L3_Third_Comany == ' ' || L3_Third_Comany.length == 0 || L3_Bid_Price == ' ' || L3_Bid_Price.length == 0) {
             Swal.fire('Please Fill All Required data');
         }
         else {
             var formData = new FormData();
             formData.append("Tender_Name", Tender_Name);
             formData.append("Tender_Item", Tender_Item);
             formData.append("T_Quantity", T_Quantity);
             formData.append("Price", Price);
             formData.append("Delivery_Date", Delivery_Date);
             formData.append("Delivery_Location", Delivery_Location);
             formData.append("L1_Our_Company", L1_Our_Company);
             formData.append("L1_Bid_Price", L1_Bid_Price);
             formData.append("L2_Second_Com", L2_Second_Com);
             formData.append("L2_Bid_Price", L2_Bid_Price);
             formData.append("L3_Third_Comany", L3_Third_Comany);
             formData.append("L3_Bid_Price", L3_Bid_Price);

             $.ajax({
                 url: 'WebServerFile/TenderWebService.asmx/SaveWinTenderDetails',
                 type: 'POST',
                 data: formData,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (Result) {
                     Swal.fire({
                         icon: 'Lost',
                         width: '300px',
                         text: "Save Tender",
                         timer: 3000
                     });
                   //  Swal.fire('Saved!', '', 'success')
                     setTimeout(function () {
                         location.reload();

                     }, 3000);
                 },
                 error: function (response) {
                     Swal.fire(" Error:" + response.d);
                 }
             });
         }
         return false;
     }




     ////Lost Tender


     function Service(id) {
         //debugger;
         var formData = new FormData();

         formData.append("id", id);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/GetTenderDataLost',
             type: 'POST',
             data: formData,
             cache: false,
             contentType: false,
             processData: false,
             success: function (data) {
                 $("#LTName").val(data[0].Tender_Name);
                 $("#LTItem").val(data[0].T_Item);
                 $("#LTQ").val(data[0].T_Quantity);
                 $("#Lprice").val(data[0].Price);

                 $("#Div2").modal('show')
             }
         });

     }

     function SaveLostTenderData() {
      
        // debugger;
         var Tender_Name = $("#LTName").val();
         var Tender_Item = $("#LTItem").val();
         var T_Quantity = $("#LTQ").val();
         var Price = $("#Lprice").val();
         var Delivery_Date = $("#date").val();
         var L1_Our_Company = $("#LL1Winner").val();
         var L1_Bid_Price = $("#LL1Bprice").val();
         var L2_Second_Com = $("#LL2SeCom").val();
         var L2_Bid_Price = $("#LL2BidP").val();
         var L3_Third_Comany = $("#LL3TComp").val();
         var L3_Bid_Price = $("#LL3TCompBP").val();
         var OurPosition = $("#OurPosition").val();
         var Our_Bid_Price = $("#OurBidP").val();

         if (Delivery_Date == ' ' || Delivery_Date.length == 0 || L1_Our_Company == ' ' || L1_Our_Company.length == 0 || L1_Bid_Price == ' ' || L1_Bid_Price.length == 0 || L2_Second_Com == ' ' || L2_Second_Com.length == 0
         || L2_Bid_Price == ' ' || L2_Bid_Price.length == 0 || L3_Third_Comany == ' ' || L3_Third_Comany.length == 0 || L3_Bid_Price == ' ' || L3_Bid_Price.length == 0
         || OurPosition == ' ' || OurPosition.length == 0 || Our_Bid_Price == ' ' || Our_Bid_Price.length == 0) {
             Swal.fire('Please Fill All Required data');
         }
         else {
             var formData = new FormData();
             formData.append("Tender_Name", Tender_Name);
             formData.append("Tender_Item", Tender_Item);
             formData.append("T_Quantity", T_Quantity);
             formData.append("Price", Price);
             formData.append("Delivery_Date", Delivery_Date);
             formData.append("L1_Our_Company", L1_Our_Company);
             formData.append("L1_Bid_Price", L1_Bid_Price);
             formData.append("L2_Second_Com", L2_Second_Com);
             formData.append("L2_Bid_Price", L2_Bid_Price);
             formData.append("L3_Third_Comany", L3_Third_Comany);
             formData.append("L3_Bid_Price", L3_Bid_Price);
             formData.append("OurPosition", OurPosition);
             formData.append("Our_Bid_Price", Our_Bid_Price);
             $.ajax({
                 url: 'WebServerFile/TenderWebService.asmx/SaveLostTenderDetails',
                 type: 'POST',
                 data: formData,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (Result) {
                     Swal.fire({
                         icon: 'Lost',
                         width: '300px',
                         text: "Lost Tender",
                         timer: 3000
                     });
                    // Swal.fire('Saved!', '', 'Lost')
                     setTimeout(function () {
                         location.reload();
                     }, 1500);
                 },
                 error: function (response) {
                     Swal.fire(" Error:" + response.d);

                 }
             });
         }
         return false;
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
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Bid Results</h5>


        </div>
        <div style="width: 100%; float: left; overflow: auto;">
            <table id="datatables-dashboard-projects" class="table table-striped my-0">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th class="d-none d-xl-table-cell">Tender Name/Doc ID</th>
                        <th class="d-none d-xl-table-cell">Company Name</th>
                        <th class="d-none d-xl-table-cell">Publication Date</th>
                        <th class="d-none d-xl-table-cell">Submitting Date</th>
                        <th class="d-none d-xl-table-cell">Opening Date</th>
                        <th class="d-none d-xl-table-cell">Pre-Bid Meeting Date</th>
                        <th class="d-none d-xl-table-cell">Pre-Bid Meeting Time</th>
                        <th class="d-none d-xl-table-cell">Extended Submission Date</th>
                        <th class="d-none d-xl-table-cell">Tender Documnet File</th>
                        <th class="d-none d-xl-table-cell">Result</th>
                        <th class="d-none d-xl-table-cell">View</th>
                    </tr>
                </thead>
                <tbody id="completeprojecttbl">
                </tbody>
            </table>
        </div>
    </div>

    <%--win tender data--%>


    <div class="modal fade" id="WinModal">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
        
                <div class="modal-header px-3">
                    <h4 class="modal-title" id="H1">Win Tender Details</h4>
             
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="bi bi-x-circle-fill"></i>
                    </button>
                </div>
                <div class="card-body">
                    <div class="row mt-4">
                        <div class="col-md-4">
                            <label class="form-label">
                                Tender Name/Doc ID</label>
                            <input type="text" class="form-control" id="Tname" />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                Tender Item</label>
                            <input type="text" class="form-control" id="Titem">
                        </div>
                        <div class="col-md-4 ">
                            <label class="form-label">
                                Tender Quantity</label>
                            <input type="text" class="form-control numberonly" id="TQ">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Price</label>
                            <input type="text" class="form-control float" id="Tprice">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Delivery Date</label>
                            <input type="date" class="form-control" id="DDate">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Delivery Location</label>
                            <input type="text" class="form-control" id="DLocation">
                        </div>
                    </div>
                    </br>
                    
                     
                     <div class="row">

                         <div class="card col-md-4">
                             <div class=" mt-3">
                                 <label class="form-label">
                                     L1 Company</label>
                                 <input type="text" value="Genesis Gas Solution" class="form-control" id="L1OurC" />

                             </div>
                             <div class=" mt-3">
                                 <label class="form-label">
                                     L1 Bid Price</label>
                                 <input type="text" class="form-control float" id="L1BidP">
                             </div>
                             </br>
                         </div>


                         <div class="card col-md-4">
                             <div class=" mt-3">
                                 <label class="form-label">
                                     L2 Second Company</label>
                                 <input type="text" class="form-control" id="L2SComp">
                             </div>
                             <div class=" mt-3">
                                 <label class="form-label">
                                     L2 Bid Price</label>
                                 <input type="text" class="form-control float" id="L2SCompBP">
                             </div>
                             </br>
                         </div>

                         <div class="card col-md-4">
                             <div class=" mt-3">
                                 <label class="form-label">
                                     L3 Third Company</label>
                                 <input type="text" class="form-control" id="L3TComp">
                             </div>
                             <div class="mt-3">
                                 <label class="form-label">
                                     L3 Bid Price</label>
                                 <input type="text" class="form-control float" id="L3TCompBP">
                             </div>
                             </br>
  
                         </div>

                     </div>

                    <div class="row mt-3">
                        <div class="md-4 mt-3">
                            <button type="submit" id="btnupdate" class="btn btn-primary float-end" onclick="SaveWinTenderData();">
                                Save
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
    </div>



    <%--Lost tender model--%>


    <div class="modal fade" id="Div2">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <form>
                    <%--<div class="row">--%>
                    <div class="col-12 col-lg-12 d-flex">
                        <div class="card flex-fill w-100">
                            <div class="modal-header px-3">
                                <h4 class="modal-title" id="H2">Lost Tender Details</h4>

                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                    <i class="bi bi-x-circle-fill"></i>
                                </button>
                            </div>
                            <div class="card-body">
                                <div class="row mt-4">
                                    <div class="col-md-4">
                                        <label class="form-label">
                                            Tender Name/Doc ID</label>
                                        <input type="text" class="form-control" id="LTName">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">
                                            Tender Item</label>
                                        <input type="text" class="form-control" id="LTItem">
                                    </div>
                                    <div class="col-md-4 ">
                                        <label class="form-label">
                                            Tender Quantity</label>
                                        <input type="text" class="form-control numberonly" id="LTQ">
                                    </div>
                                    <div class="col-md-4 mt-3">
                                        <label class="form-label">
                                            Price</label>
                                        <input type="text" class="form-control float" id="Lprice">
                                    </div>
                                    <div class="col-md-4 mt-3">
                                        <label class="form-label">
                                            Date</label>
                                        <input type="date" class="form-control" id="date">
                                    </div>
                                </div>
                                </br>
                    <div class="row">
                        <div class="card col-md-4">
                            <div class=" mt-3">
                                <label class="form-label">
                                    L1 Company</label>
                                <input type="text" class="form-control" id="LL1Winner">
                            </div>
                            <div class=" mt-3">
                                <label class="form-label">
                                    L1 Bid Price</label>
                                <input type="text" class="form-control float" id="LL1Bprice">
                            </div>
                            </br>
                        </div>

                        <div class="card col-md-4">
                            <div class=" mt-3">
                                <label class="form-label">
                                    L2 Second Comapny</label>
                                <input type="text" class="form-control" id="LL2SeCom">
                            </div>
                            <div class=" mt-3">
                                <label class="form-label">
                                    L2 Bid Price</label>
                                <input type="text" class="form-control float" id="LL2BidP">
                            </div>
                            </br>
                        </div>

                        <div class="card col-md-4">
                            <div class=" mt-3">
                                <label class="form-label">
                                    L3 Third Company</label>
                                <input type="text" class="form-control" id="LL3TComp">
                            </div>
                            <div class=" mt-3">
                                <label class="form-label">
                                    L3 Bid Price</label>
                                <input type="text" class="form-control float" id="LL3TCompBP">
                            </div>
                            </br>
                        </div>
                    </div>
                                <div class="row">
                                    <div class=" col-md-4 mt-3">
                                        <label class="form-label">
                                            Our Position</label>
                                        <input type="text" class="form-control" id="OurPosition">
                                    </div>
                                    <div class="col-md-4 mt-3">
                                        <label class="form-label">
                                            Our Bid Price</label>
                                        <input type="text" class="form-control float" id="OurBidP">
                                    </div>


                                </div>
                                <div class="row mt-3">
                                    <div class="mt-3">
                                        <button type="button" id="Button1" class="btn btn-primary float-end" onclick="SaveLostTenderData();">
                                            Save
                                        </button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <%--    </div>--%>
                </form>
            </div>
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
