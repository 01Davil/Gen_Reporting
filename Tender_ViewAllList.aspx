<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="Tender_ViewAllList.aspx.cs" Inherits="Tender_ViewAllList" %>

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
             getWinDataList();
             getLostDataList();
             getPendingDataList();
         });
     });

     function getWinDataList() {
         //   debugger;
         var formData = new FormData();
         //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         //             formData.append("Type", Type);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/GetWinTenderList',
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
                     $("#ShowWintbl").empty();
                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         jQuery('<tr><td> ' + j + '</td><td onclick=" ServiceView(' + data[i].Id + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Tender_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].Price + ' </td><td>' + data[i].Delivery_Date + ' </td><td>' + data[i].Delivery_Location + ' </td><td>' + data[i].L1_Our_Company + '  </td>  <td>' + data[i].L1_Bid_Price + ' </td><td>' + data[i].L2_Second_Com + ' </td><td>' + data[i].L2_Bid_Price + ' </td> <td>' + data[i].L3_Third_Comany + ' </td><td>' + data[i].L3_Bid_Price + ' </td>  </tr>').appendTo("#ShowWintbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }



     function ServiceView(view) {
         debugger
         event.preventDefault();
         // alert(view);
         //    $("#statustblModal").modal('show');
         var formData = new FormData();
         //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         formData.append("Tender_Name", view);
         // formData.append("view", view);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/PreBidMeetingTenderList',
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
                     $("#statustblModal").modal('show');
                     $("#Tbody1").empty();


                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView(' + data[i].Id + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].AttenderName + ' </td><td>' + data[i].Discussion + ' </td><td>' + data[i].OurQuery + ' </td><td>' + data[i].Status + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  <td>' + data[i].MeetingDate + '  </td> <td>' + data[i].Other_CompanyName + ' </td> <td>' + data[i].Other_CompanyQuery + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  </tr>').appendTo("#Tbody1");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }



     function getLostDataList() {
         //   debugger;
         var formData = new FormData();
         //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         //             formData.append("Type", Type);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/GetLostTenderList',
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
                     $("#ShowLosttbl").empty();
                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView(' + data[i].Id + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Tender_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].Price + ' </td><td>' + data[i].Delivery_Date + ' </td><td>' + data[i].L1_Winner_Company + '  </td>  <td>' + data[i].L1_Bid_Price + ' </td><td>' + data[i].L2_Second_Comp + ' </td><td>' + data[i].L2_Bid_Price + ' </td> <td>' + data[i].L3_Third_Company + ' </td><td>' + data[i].L3_Bid_Price + ' </td> <td>' + data[i].OurPosition + ' </td><td>' + data[i].Our_Bid_Price + ' </td> </tr>').appendTo("#ShowLosttbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }




     function getPendingDataList() {
         //   debugger;
         var formData = new FormData();
         //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         //             formData.append("Type", Type);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/GetPendingTenderList',
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
                     $("#Pendingtbl").empty();
                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView(' + data[i].id + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td><td>' + data[i].OpeningDate + '  </td>  <td>' + data[i].T_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].T_Location + ' </td> <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td> <td>' + data[i].T_Source + ' </td>  </tr>').appendTo("#Pendingtbl");
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


  
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="card">
                            <div class="card-header">
                                <div class="card-actions float-end">

                                </div>
                                <h5 class="card-title mb-0">Employee Details</h5>
                            </div>
                            <div class="card-body h-100 p-0 pb-0">
                                <div class="tab">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="nav-item"><a class="nav-link active" href="#tab-1" data-bs-toggle="tab" role="tab">View Win Tenders</a></li>
                                        <li class="nav-item"><a class="nav-link" href="#tab-2" data-bs-toggle="tab" role="tab">View Lost Tenders</a></li>
                                        <li class="nav-item"><a class="nav-link" href="#tab-3" data-bs-toggle="tab" role="tab">View Pending Tenders</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="tab-1" role="tabpanel">
                                            <div class="row">
                                                <div class="col-md-12">
                                                   <h4 class="float-start">Win Tenders list</h4>
                                                    <div class="input-group input-group-sm" style="width: 200px; float: right;">
                                                        <input type="text" class="form-control" placeholder="Search" style="border-radius: 4px;">
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <hr>
                                                    <div style="width: 100%; float: left; overflow: auto;">
                                                        <table id="datatables-dashboard-projects" class="table table-striped my-0">
                                                            <thead>
                                                                <tr>
                                                                    <th>S.No.</th>
                                                                    <th class="d-none d-xl-table-cell">Tender Name</th>
                                                                    <th class="d-none d-xl-table-cell">Tender Item</th>
                                                                    <th class="d-none d-xl-table-cell">T_Quantity</th>
                                                                    <th class="d-none d-xl-table-cell">Price</th>
                                                                    <th class="d-none d-xl-table-cell">Delivery_Date</th>
                                                                    <th class="d-none d-xl-table-cell">Delivery Location</th>
                                                                    <th class="d-none d-xl-table-cell">L1_Our_Company</th>
                                                                    <th class="d-none d-xl-table-cell">L1_Bid_Price</th>
                                                                    <th class="d-none d-xl-table-cell">L2_Second_Com</th>
                                                                    <th class="d-none d-xl-table-cell">L2_Bid_Price</th>
                                                                    <th class="d-none d-xl-table-cell">L3_Third_Comany</th>
                                                                    <th class="d-none d-xl-table-cell">L3_Bid_Price</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="ShowWintbl">
                                                           

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="tab-pane" id="tab-2" role="tabpanel">
                                            <div class="row">
                                               <div class="col-md-12">
                                                   <h4 class="float-start">Lost Tenders list</h4>
                                                    <div class="input-group input-group-sm" style="width: 200px; float: right;">
                                                        <input type="text" class="form-control" placeholder="Search" style="border-radius: 4px;">
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                   <hr>
                                                    <div style="width: 100%; float: left; overflow: auto;">
                                                        <table id="datatables-dashboard-projects" class="table table-striped my-0">
                                                            <thead>
                                                                <tr>
                                                                    <th>S.No.</th>
                                                                      <th class="d-none d-xl-table-cell">Tender Name</th>
                                                                    <th class="d-none d-xl-table-cell">Tender Item</th>
                                                                    <th class="d-none d-xl-table-cell">T_Quantity</th>
                                                                    <th class="d-none d-xl-table-cell">Price</th>
                                                                    <th class="d-none d-xl-table-cell">Delivery_Date</th>
                                                                    
                                                                    <th class="d-none d-xl-table-cell">L1_Winner_Company</th>
                                                                    <th class="d-none d-xl-table-cell">L1_Bid_Price</th>
                                                                    <th class="d-none d-xl-table-cell">L2_Second_Com</th>
                                                                    <th class="d-none d-xl-table-cell">L2_Bid_Price</th>
                                                                    <th class="d-none d-xl-table-cell">L3_Third_Comany</th>
                                                                    <th class="d-none d-xl-table-cell">L3_Bid_Price</th>
                                                                    <th class="d-none d-xl-table-cell">OurPosition</th>
                                                                    <th class="d-none d-xl-table-cell">Our_Bid_Price</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="ShowLosttbl">
                                                               

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>


                                        
    <div class="tab-pane" id="tab-3" role="tabpanel">
        <div class="row">
            <div class="col-md-12">
                <h4 class="float-start">
                    Pre Tenders list</h4>
                <div class="input-group input-group-sm" style="width: 200px; float: right;">
                    <input type="text" class="form-control" placeholder="Search" style="border-radius: 4px;">
                </div>
            </div>
            <div class="col-md-12">
                <hr>
                <div style="width: 100%; float: left; overflow: auto;">
                    <table id="datatables-dashboard-projects" class="table table-striped my-0">
                        <thead>
                            <tr>
                                <th>
                                    S.No.
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Tender Name
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Company Name
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    T_Publication_Date
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    T_PreBidMeetingDate
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    T_SubmittingDate
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Extended SubmissionDate
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    OpeningDate
                                </th>
                                <th class="d-none d-xl-table-cell" >
                                    Item
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Quantity
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Location
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    T_File
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    T_Source
                                </th>
                              
                            </tr>
                        </thead>
                        <tbody id="Pendingtbl">
                       
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>



                                    </div>
                                </div>

                            </div>
                        </div>

    <%-- Modal open code   --%>
        <div class="modal fade" id="statustblModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Tender  Record</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body m-3">
                      <div class="tab-pane" id="Div1" role="tabpanel">
        <div class="row">
            <div class="col-md-12">
                <h4 class="float-start">
                     Tenders list</h4>
                <div class="input-group input-group-sm" style="width: 200px; float: right;">
                    <input type="text" class="form-control" placeholder="Search" style="border-radius: 4px;">
                </div>
            </div>
            <div class="col-md-12">
                <hr>
                <div style="width: 100%; float: left; overflow: auto;"> 
                    <table id="datatables-dashboard-projects" class="table table-striped my-0">
                        <thead>
                            <tr>
                                <th>
                                    S.No.
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Tender Name
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Company Name
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Attender Name
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Discussion
                                </th>
                                <th class="d-none d-xl-table-cell">
                                     Our Query
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Status
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Upload File
                                </th>
                                <th class="d-none d-xl-table-cell" >
                                    Meeting Date
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Other Company Name
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Other Company Query
                                </th>
                                <th class="d-none d-xl-table-cell">
                                    Upload File
                                </th>
                               
                              
                            </tr>
                        </thead>
                        <tbody id="Tbody1">
                       
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        
                    </div>
                </div>
            </div>
        </div>
</asp:Content>

