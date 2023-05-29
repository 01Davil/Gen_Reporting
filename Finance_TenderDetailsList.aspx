<%@ Page Title="" Language="C#" MasterPageFile="~/Finance_MasterPage.master" AutoEventWireup="true" CodeFile="Finance_TenderDetailsList.aspx.cs" Inherits="Finance_TenderDetailsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="JsDB/jquery.js" type="text/javascript"></script>
    <script src="JsDB/popper.min.js" type="text/javascript"></script>
    <script src="JsDB/bootstrap.js" type="text/javascript"></script>
    <script src="JsDB/javascript.js" type="text/javascript"></script>
 <script type="text/javascript">
     //    const imageArray = [];
     //    var selectedcolor = "";
     $(document).ready(function () {
         var a;
         a = setInterval(fun, 1000);
         function fun() {
             //  getTenderDetails();
         }

         $(function () {
             getTenderDetails();
         });
     });



     function getTenderDetails() {
         //   debugger;
         var formData = new FormData();
         //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         //             formData.append("Type", Type);
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

                         jQuery('<tr><td> ' + j + '   </td><td>' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].OpeningDate + '  </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td>  <td>' + data[i].T_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].Price + ' </td><td>' + data[i].T_Location + '</td> <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td> <td>' + data[i].T_Source + ' </td>  <td ><table><tr><td> <input type="button" class="btn btn-sm btn-success" Text="View" id="viewdata" ' + j + ' onclick="ServiceView(' + data[i].id + ')" value="Win"> </input></td><td><input type="button" class="btn btn-sm btn-danger" Text="View" id="viewdataa" ' + j + ' onclick="Service(' + data[i].id + ')" value="Lost"> </input></td></tr></table>  </td><td>' + data[i].status + ' </td> </tr>').appendTo("#completeprojecttbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }

     function DowFun(j) {
         debugger;
         var x = document.getElementById("datatables-dashboard-projects").rows[j].cells.item(0).innerText;
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
         debugger;

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



     function SaveWinTenderData() {
         debugger;
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

         //         if (Tender_Name != ' ' || Tender_Item != ' ' || T_Quantity != ' '
         //          || Price != ' ' || Delivery_Date != ' ' || Delivery_Location != ' ' ||
         //          L1_Our_Company != ' ' || L1_Bid_Price != ' ' || L2_Second_Com != ' '
         //          || L2_Bid_Price != ' ' || L3_Third_Comany != ' ' || L3_Bid_Price != ' ') {
         //             Swal.fire('Please Fill All Required data');
         //         }
         //          else {
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
                     icon: 'success',
                     width: '300px',
                     text: "Successfully save Win Tender",
                     timer: 3000
                 });
             },
             error: function (response) {
                 alert(" Error:" + response.d);

             }
         });
         //         }
     }

     //     function myFunction() {
     //         debugger

     //         var Type1 = $("#DF option:selected").text().trim();
     //         if (Type1 == 'Yes') {
     //             $("#CS").val("No");
     //             alert();
     //         } else {
     //             $("#CS").val("Yes");

     //         }
     //     }




     ////Lost Tender


     function Service(id) {
         debugger;
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
                 $("#LTName").val(data[0].Tender_Name);
                 $("#LTItem").val(data[0].T_Item);
                 $("#LTQ").val(data[0].T_Quantity);
                 $("#Lprice").val(data[0].Price);
                 $("#Div2").modal('show')
             }
         });

     }



     function SaveLostTenderData() {

         debugger;
         var Tender_Name = $("#LTName").val();
         var Tender_Item = $("#LTItem").val();
         var T_Quantity = $("#LTQ").val();
         var Price = $("#Lprice").val();
         var Delivery_Date = $("#date").val();
         var L1_Winner_Company = $("#LL1Winner").val();
         var L1_Bid_Price = $("#LL1Bprice").val();
         var L2_Second_Com = $("#LL2SeCom").val();
         var L2_Bid_Price = $("#LL2BidP").val();
         var L3_Third_Comany = $("#LL3TComp").val();
         var L3_Bid_Price = $("#LL3TCompBP").val();
         var OurPosition = $("#OurPosition").val();
         var Our_Bid_Price = $("#OurBidP").val();


         //         if (Delivery_Date != ' ' || L1_Winner_Company != ' ' || L1_Bid_Price != ' ' ) {
         //             alert("please enter input all field");  
         //                }
         //          else {       

         var formData = new FormData();
         formData.append("Tender_Name", Tender_Name);
         formData.append("Tender_Item", Tender_Item);
         formData.append("T_Quantity", T_Quantity);
         formData.append("Price", Price);
         formData.append("Delivery_Date", Delivery_Date);
         formData.append("L1_Winner_Company", L1_Winner_Company);
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
                     icon: 'success',
                     width: '300px',
                     text: "Successfully save Lost Tender",
                     timer: 3000
                 });
             },
             error: function (response) {
                 alert(" Error:" + response.d);

             }
         });
         //         }
     }


        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="card flex-fill">
                            <div class="card-header">
                                <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Bid Results</h5>
                                
                                
                            </div>
                            <div style="width: 100%; float: left; overflow: auto;">
                            <table id="datatables-dashboard-projects" class="table table-striped my-0">
                                <thead>
                                    <tr>
                                        <th>S.No.</th>
                                        <th class="d-none d-xl-table-cell">Tender Name</th>
                                        <th class="d-none d-xl-table-cell">Company Name</th>
                                        <th class="d-none d-xl-table-cell">Publication Date</th>
                                        <th class="d-none d-xl-table-cell">Submitting Date</th>
                                        <th class="d-none d-xl-table-cell">Opening Date</th>
                                        <th class="d-none d-xl-table-cell">Pre-Bid Meeting Date</th>
                                        <th class="d-none d-xl-table-cell">Extended Submission Date</th> 
                                        <th class="d-none d-xl-table-cell" id="TItem">Work/Item</th>
                                        <th class="d-none d-xl-table-cell">Quantity</th>
                                        <th class="d-none d-xl-table-cell">Price</th>
                                        <th class="d-none d-xl-table-cell">Place/Location</th>                                        
                                        <th class="d-none d-xl-table-cell">Tender Source</th>
                                        <th  style="width:300px !important;">Result</th>
                                         <th  style="width:300px !important;">Actions</th>
                                          <th  style="width:300px !important;">Status</th>
                                        
                                       
                                    </tr>
                                </thead>
                               <tbody id="completeprojecttbl">
                                  <%--  <tr>
                                        <td>01</td>
                                        <td class="d-none d-xl-table-cell">Tender Name</td>
                                        <td class="d-none d-xl-table-cell">Abhishek</td>
                                        <td class="d-none d-md-table-cell">Time</td>
                                        <td class="d-none d-md-table-cell">Time</td>
                                        <td class="d-none d-md-table-cell">Date</td>
                                        <td class="d-none d-md-table-cell">
                                        <a href="TenderLostDetails.aspx" class="btn btn-sm btn-danger">Lost</a>
                                        <a href="TenderWinDetails.aspx" class="btn btn-sm btn-success">Win</a>
                                        </td>
                                    </tr>--%>

                                </tbody>
                            </table>
                        </div>
                        </div>

<%--win tender data--%>


                            <div class="modal fade" id="WinModal">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
     <%--           <div class="row">
        <div class="col-12 col-lg-12 d-flex">
            <div class="card flex-fill w-100">--%>
                 <div class="modal-header px-3">
                    <h4 class="modal-title" id="H1">
                        Win Tender Details</h4>
                    <%--           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>--%>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="bi bi-x-circle-fill"></i>
                    </button>
                </div>
                <div class="card-body">
                    <div class="row mt-4">
                           <div class="col-md-4">
                            <label class="form-label">
                                Tender Name</label>
                            <input type="text" class="form-control" id="Tname"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                Tender Item</label>
                            <input type="text" class="form-control" id="Titem">
                        </div>
                        <div class="col-md-4 ">
                            <label class="form-label">
                                Tender Quantity</label>
                            <input type="text" class="form-control" id="TQ">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Price</label>
                            <input type="text" class="form-control" id="Tprice">
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
                                L1(Our Company)</label>
                                  <input type="text"  class="form-control" id="L1OurC"/>
                               
                        </div>
						 <div class=" mt-3">
                            <label class="form-label">
                                L1 Bid Price</label>
                            <input type="text" class="form-control" id="L1BidP">
                        </div>
</br>
      </div>


   <div class="card col-md-4">      
         <div class=" mt-3">
                            <label class="form-label">
                                L2 (Second)</label>
                            <input type="text" class="form-control" id="L2SComp">
                        </div>
						<div class=" mt-3">
                            <label class="form-label">
                             L2 Bid Price</label>
                            <input type="text" class="form-control" id="L2SCompBP">
                        </div></br>
      </div>
 
               <div class="card col-md-4">      
         <div class=" mt-3">
                           <label class="form-label">
                               L3 (Third)</label>
                           <input type="text" class="form-control" id="L3TComp">
                       </div>
                       <div class="mt-3">
                           <label class="form-label">
                               L3 Bid Price</label>
                          <input type="text" class="form-control" id="L3TCompBP">
                        </div></br>
  
    </div>
  
                    </div>
              
                    <div class="row mt-3">
                        <div class="col-md-4 mt-3">
                             <button type="submit" id="btnupdate" class="btn btn-primary" onclick="SaveWinTenderData();">
                                Submit
                            </button>
                        </div>
                    </div>
                     </div>
                </div>
            </div>
     <%--   </div>
    </div>
     <%--       </div>--%>
</div>
  


<%--Lost tender model--%>


         <div class="modal fade" id="Div2">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <form>
          
        <div class="col-12 col-lg-12 d-flex">
            <div class="card flex-fill w-100">
                 <div class="modal-header px-3">
                    <h4 class="modal-title" id="H2">
                        Lost Tender Details</h4>
                  
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="bi bi-x-circle-fill"></i>
                    </button>
                </div>
                <div class="card-body">
                    <div class="row mt-4">
                        <div class="col-md-4">
                            <label class="form-label">
                                Tender Name</label>
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
                            <input type="text" class="form-control"id="LTQ">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Price</label>
                            <input type="text" class="form-control" id="Lprice">
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
                                L1(Our Company)</label>
                                <input type="text" class="form-control" id="LL1Winner">
                        </div>
						 <div class=" mt-3">
                            <label class="form-label">
                                L1 Bid Price</label>
                            <input type="text" class="form-control" id="LL1Bprice">
                        </div></br>
      </div>

                       <div class="card col-md-4">      
         <div class=" mt-3">
                            <label class="form-label">
                                L2 (Second)</label>
                            <input type="text" class="form-control" id="LL2SeCom">
                        </div>
						<div class=" mt-3">
                            <label class="form-label">
                             L2 Bid Price</label>
                            <input type="text" class="form-control" id="LL2BidP">
                        </div></br>
      </div>
 
                        <div class="card col-md-4">      
         <div class=" mt-3">
                           <label class="form-label">
                               L3 (Third)</label>
                           <input type="text" class="form-control" id="LL3TComp">
                       </div>
                       <div class=" mt-3">
                           <label class="form-label">
                               L3 Bid Price</label>
                          <input type="text" class="form-control" id="LL3TCompBP">
                        </div></br>
                          </div>
  </div> <div class="row">
                <div class=" col-md-4 mt-3">
                            <label class="form-label">
                                Our Position</label>
                            <input type="text" class="form-control" id="OurPosition">
                       </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Our Bid Price</label>
                            <input type="text" class="form-control" id="OurBidP">
                        </div>

               
                </div>
                   <div class="row mt-3">
                        <div class="col-md-4 mt-3">
                              <button type="submit" id="Button1" class="btn btn-primary" onclick="SaveLostTenderData();">
                                Submit
                            </button>
                        </div>
                    </div>
                </div>
     
        </div>

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
</asp:Content>


