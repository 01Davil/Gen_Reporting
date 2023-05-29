<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ListTener.aspx.cs" Inherits="ListTener" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                //getTenderDetails();

            }
            $(document).ready(function () {
                var a;
                a = setInterval(fun, 1000);
                function fun() {
                    var today = new Date();
                    var now = today.toLocaleString();
                    $(".cv").text(now);

                }
            });

            $(function () {
                getWinDataList();
                getLostDataList();
                getPendingDataList(0);
                GetListGetCount();
            });
            /// Search Employee WIN Name List
            $("#SearchText").keypress(function () {
                // debugger;
                var Tender_Name = $("SearchText").val();

                var formData = new FormData();
                formData.append("Num", $("#SearchText").val());
                $.ajax({
                    url: 'WebServerFile/TenderWebService.asmx/GetNameList',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {

                        var ddlCustomers = $("[id*=select]");
                        ddlCustomers.empty();
                        $.each(data, function (key, val) {

                            ddlCustomers.append('<option value= "' + val['Tender_Name'] + '"</option>');
                        });

                    }

                });


            });
            $('#SearchText').on('change', function () {
                // debugger
                var a = $("#SearchText").val();
                var formData = new FormData();
                //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                  formData.append("Name", a);
                  $.ajax({
                      url: 'WebServerFile/TenderWebService.asmx/GetWinTenderListSearch',
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

                                  jQuery('<tr><td> ' + j + '</td><td> <a href="#" onclick="ServiceView1(' + data[i].Id + ')">  ' + data[i].Tender_Name + ' </a> </td>   <td>' + data[i].Tender_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].Price + ' </td><td>' + data[i].Delivery_Date + ' </td><td>' + data[i].Delivery_Location + ' </td><td>' + data[i].L1_Our_Company + '  </td>  <td>' + data[i].L1_Bid_Price + ' </td><td>' + data[i].L2_Second_Com + ' </td><td>' + data[i].L2_Bid_Price + ' </td> <td>' + data[i].L3_Third_Comany + ' </td><td>' + data[i].L3_Bid_Price + ' </td>  </tr>').appendTo("#ShowWintbl");
                                  j++;
                                  // end for loop
                              }
                          }
                      }
                  });

              });


         /// Search Employee LOST Name List
         $("#SearchText2").keypress(function () {
             // debugger;
             var Tender_Name = $("SearchText2").val();
             var formData = new FormData();
             formData.append("Num", $("#SearchText2").val());
             $.ajax({
                 url: 'WebServerFile/TenderWebService.asmx/GetNameList',
                 type: 'POST',
                 data: formData,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (data) {

                     var ddlCustomers = $("[id*=select2]");
                     ddlCustomers.empty();
                     $.each(data, function (key, val) {

                         ddlCustomers.append('<option value= "' + val['Tender_Name'] + '"</option>');
                     });

                 }

             });


         });

         //Search by  lost tender name only
         $('#SearchText2').on('change', function () {
             //debugger
             var a = $("#SearchText2").val();
             var formData = new FormData();
             //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                  formData.append("Name", a);
                  $.ajax({
                      url: 'WebServerFile/TenderWebService.asmx/GetLOSTTenderListSearch',
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

                                  jQuery('<tr><td> ' + j + '   </td><td> <a href="#" onclick="ServiceView2(' + data[i].Id + ')">  ' + data[i].Tender_Name + ' </a> </td>  <td>' + data[i].Tender_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].Price + ' </td><td>' + data[i].Delivery_Date + ' </td><td>' + data[i].L1_Our_Company + '  </td>  <td>' + data[i].L1_Bid_Price + ' </td><td>' + data[i].L2_Second_Com + ' </td><td>' + data[i].L2_Bid_Price + ' </td> <td>' + data[i].L3_Third_Comany + ' </td><td>' + data[i].L3_Bid_Price + ' </td> <td>' + data[i].OurPosition + ' </td><td>' + data[i].Our_Bid_Price + ' </td> </tr>').appendTo("#ShowLosttbl");
                                  j++;
                                  // end for loop
                              }
                          }
                      }
                  });

              });



         /// Search Employee pending Name List
         $("#SearchText4").keypress(function () {
             // debugger;
             var Tender_Name = $("#SearchText4").val();
             // alert(Tender_Name);
             var formData = new FormData();
             formData.append("Num", $("#SearchText4").val());
             $.ajax({
                 url: 'WebServerFile/TenderWebService.asmx/GetNameList',
                 type: 'POST',
                 data: formData,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (data) {
                     var ddlCustomers = $("[id*=select4]");
                     ddlCustomers.empty();
                     $.each(data, function (key, val) {
                         ddlCustomers.append('<option value= "' + val['Tender_Name'] + '"</option>');
                     });

                 }

             });


         });
         //Search by Pending tender name only
         $('#SearchText4').on('change', function () {
            // debugger;
             var a = $("#SearchText4").val();
             var formData = new FormData();
             formData.append("Name", a);
             $.ajax({
                 url: 'WebServerFile/TenderWebService.asmx/GetPENDINGTenderListSearch',
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
                             //jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView(' + data[i].id + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td><td>' + data[i].OpeningDate + '  </td>  <td>' + data[i].T_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].T_Location + ' </td> <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td> <td>' + data[i].T_Source + ' </td>  </tr>').appendTo("#Pendingtbl");
                             jQuery('<tr><td> ' + j + '   </td><td> <a href="#" onclick="ServiceView4(' + data[i].id + ')">  ' + data[i].Tender_Name + ' </a> </td>   <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_PreBidMeetingTime + ' </td><td>' + data[i].T_PreBidMeetingV + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td> <td>' + data[i].OpeningDate + '  </td>  <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  </tr>').appendTo("#Pendingtbl");
                             j++;
                             // end for loop
                         }
                     }
                 }
             });

         });
     });



          function GetAllTypeData(type) {

              if (type == 'WIN')
                  $("#ShowText").text("WIN");
              else if (type == 'LOST')
                  $("#ShowText").text("LOST");
              else
                  $("#ShowText").text("PENIDNG");


          }

          function getWinDataList() {
              //debugger;
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

                         jQuery('<tr><td> ' + j + '</td><td> <a href="#" onclick="ServiceView1(' + data[i].Id + ')">  ' + data[i].Tender_Name + ' </a> </td>  <td>' + data[i].Tender_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].Price + ' </td><td>' + data[i].Delivery_Date + ' </td><td>' + data[i].Delivery_Location + ' </td><td>' + data[i].L1_Our_Company + '  </td>  <td>' + data[i].L1_Bid_Price + ' </td><td>' + data[i].L2_Second_Com + ' </td><td>' + data[i].L2_Bid_Price + ' </td> <td>' + data[i].L3_Third_Comany + ' </td><td>' + data[i].L3_Bid_Price + ' </td>  </tr>').appendTo("#ShowWintbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }

     //Win Tender name click

     function ServiceView1(view) {
        // debugger
         event.preventDefault();
         var formData = new FormData();
         formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
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
                     $("#statustblModal2").modal('show');
                     $("#completeprojecttbl2").empty();


                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         //jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView1(' + j + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].T_File + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  <td>' + data[i].Extended_SubmissionDate + '  </td> <td>' + data[i].OpeningDate + ' </td> <td>' + data[i].T_Item + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  </tr>').appendTo("#completeprojecttbl2");
                         jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView1(' + j + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_PreBidMeetingTime + ' </td> <td>' + data[i].T_PreBidMeetingV + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + '  </td> <td>' + data[i].OpeningDate + ' </td>  <td>' + data[i].T_Item + ' </td>  <td>' + data[i].T_Quantity + ' </td> <td>' + data[i].Price + ' </td><td>' + data[i].T_Location + ' </td>  <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"> <i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  <td>' + data[i].T_Source + ' </td>  <td>' + data[i].T_Doc_Sale + ' </td> <td>' + data[i].T_Doc_Fee + ' </td> <td>' + data[i].Brief_Scope + ' </td> <td>' + data[i].Bid_Valid + ' </td> <td>' + data[i].T_ProcFee + ' </td> <td>' + data[i].Emd + ' </td> <td>' + data[i].T_SubmTime + ' </td> <td>' + data[i].Un_PricBidOpenDate + ' </td> <td>' + data[i].Un_PricBidOpenTime + ' </td> <td>' + data[i].PBidOpendate + ' </td> <td>' + data[i].PBidOpenTime + ' </td>   </tr>').appendTo("#completeprojecttbl2");

                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }


     function getLostDataList() {
         // debugger;
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

                         jQuery('<tr><td> ' + j + '   </td><td> <a href="#" onclick="ServiceView2(' + data[i].Id + ')">  ' + data[i].Tender_Name + ' </a> </td>  <td>' + data[i].Tender_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].Price + ' </td><td>' + data[i].Delivery_Date + ' </td><td>' + data[i].L1_Our_Company + '  </td>  <td>' + data[i].L1_Bid_Price + ' </td><td>' + data[i].L2_Second_Com + ' </td><td>' + data[i].L2_Bid_Price + ' </td> <td>' + data[i].L3_Third_Comany + ' </td><td>' + data[i].L3_Bid_Price + ' </td> <td>' + data[i].OurPosition + ' </td><td>' + data[i].Our_Bid_Price + ' </td> </tr>').appendTo("#ShowLosttbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }
     //lost data all
     function ServiceView2(view) {
         //  debugger
         event.preventDefault();
         var formData = new FormData();
         formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         formData.append("Tender_Name", view);
           // formData.append("view", view);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/PreBidMeetingTenderListlost',
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
                     $("#statustblModal2").modal('show');
                     $("#completeprojecttbl2").empty();


                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         //jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView2(' + j + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].T_File + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  <td>' + data[i].Extended_SubmissionDate + '  </td> <td>' + data[i].OpeningDate + ' </td> <td>' + data[i].T_Item + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  </tr>').appendTo("#completeprojecttbl2");
                         jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView2(' + j + ') ">' + data[i].Tender_Name + '  </td> <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_PreBidMeetingTime + ' </td> <td>' + data[i].T_PreBidMeetingV + ' </td> <td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + '  </td> <td>' + data[i].OpeningDate + ' </td>  <td>' + data[i].T_Item + ' </td>  <td>' + data[i].T_Quantity + ' </td> <td>' + data[i].Price + ' </td><td>' + data[i].T_Location + ' </td>  <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"> <i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  <td>' + data[i].T_Source + ' </td>  <td>' + data[i].T_Doc_Sale + ' </td> <td>' + data[i].T_Doc_Fee + ' </td> <td>' + data[i].Brief_Scope + ' </td> <td>' + data[i].Bid_Valid + ' </td> <td>' + data[i].T_ProcFee + ' </td> <td>' + data[i].Emd + ' </td> <td>' + data[i].T_SubmTime + ' </td> <td>' + data[i].Un_PricBidOpenDate + ' </td> <td>' + data[i].Un_PricBidOpenTime + ' </td> <td>' + data[i].PBidOpendate + ' </td> <td>' + data[i].PBidOpenTime + ' </td>   </tr>').appendTo("#completeprojecttbl2");

                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }


     function getPendingDataList(id) {
         // debugger;
         var formData = new FormData();
         //            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         formData.append("id", 0);
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
                         //<a  onclick=" ServiceView3(' +  + ') >' 
                         //jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView(' + data[i].id + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td><td>' + data[i].OpeningDate + '  </td>  <td>' + data[i].T_Item + ' </td><td>' + data[i].T_Quantity + ' </td><td>' + data[i].T_Location + ' </td> <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td> <td>' + data[i].T_Source + ' </td>  </tr>').appendTo("#Pendingtbl");
                         jQuery('<tr><td> ' + j + '   </td> <td> <a href="#" onclick="ServiceView4(' + data[i].id + ')">  ' + data[i].Tender_Name + ' </a> </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_PreBidMeetingTime + ' </td> <td>' + data[i].T_PreBidMeetingV + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td><td>' + data[i].OpeningDate + '  </td>   <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td> </tr>').appendTo("#Pendingtbl");
                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }
     //Pending data all
     function ServiceView4(id) {
      //   debugger;
         event.preventDefault();

         var formData = new FormData();
         formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         formData.append("Tender_id", id);
           // formData.append("view", view);
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/PreBidMeetingTenderListPending',
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
                     $("#statustblModal2").modal('show');
                     $("#completeprojecttbl2").empty();


                     var j = 1;
                     for (var i = 0; i < data.length; i++) {

                         //jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView3(' + j + ') ">' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].T_File + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  <td>' + data[i].Extended_SubmissionDate + '  </td> <td>' + data[i].OpeningDate + ' </td> <td>' + data[i].T_Item + ' </td><td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  </tr>').appendTo("#completeprojecttbl2");
                         jQuery('<tr><td> ' + j + '   </td><td onclick=" ServiceView4(' + j + ') ">' + data[i].Tender_Name + '  </td> <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_PreBidMeetingTime + ' </td> <td>' + data[i].T_PreBidMeetingV + ' </td> <td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].Extended_SubmissionDate + '  </td> <td>' + data[i].OpeningDate + ' </td>  <td>' + data[i].T_Item + ' </td>  <td>' + data[i].T_Quantity + ' </td> <td>' + data[i].Price + ' </td><td>' + data[i].T_Location + ' </td>  <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"> <i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>  <td>' + data[i].T_Source + ' </td>  <td>' + data[i].T_Doc_Sale + ' </td> <td>' + data[i].T_Doc_Fee + ' </td> <td>' + data[i].Brief_Scope + ' </td> <td>' + data[i].Bid_Valid + ' </td> <td>' + data[i].T_ProcFee + ' </td> <td>' + data[i].Emd + ' </td> <td>' + data[i].T_SubmTime + ' </td> <td>' + data[i].Un_PricBidOpenDate + ' </td> <td>' + data[i].Un_PricBidOpenTime + ' </td> <td>' + data[i].PBidOpendate + ' </td> <td>' + data[i].PBidOpenTime + ' </td>   </tr>').appendTo("#completeprojecttbl2");

                         j++;
                         // end for loop
                     }
                 }
             }
         });
     }
     function GetListGetCount() {
       //  debugger;
         //  alert(data[0].response)
         var formData = new FormData();
         //formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
         $.ajax({
             url: 'WebServerFile/TenderWebService.asmx/Get_TenderList2',
             type: 'POST',
             data: formData,
             cache: false,
             contentType: false,
             processData: false,
             success: function (data) {
                 if (data[0].response != "Fail") {
                     //$("#pid").text(data[0].response);
                     // alert(data[0].response);
                     $("#pid1").text(data[0].PENDING);
                     $("#aid1").text(data[0].WIN);
                     $("#rid1").text(data[0].LOST);
                 }
             }
         });
     }

     function DowFun(id) {
        // debugger;
         var Tender_Name = document.getElementById("Pendingtbl").rows[id - 1].cells.item(1).innerText;
         // alert(Tender_Name);


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

                     $("#Uploadpdf1").modal('show');
                     $("#tableb").empty();

                     $("#tableb").append('<tr> <th> S.No</th><th> Url</th>  <th> Download</th> </tr>');
                     var j = 1;
                     for (var i = 0; i <= data.length - 1; i++) {
                         // $("#tableh").append('<tr> <th> S.No</th>  <td> ' + j + '   </td> <th>Download File "' + j + '"</th> <td> <a onclick=(Downloadfile"' + j + '")>' + data[i].id + ' </a> </td>');
                         // $("#tableb").append('<tr>   <td style="display:none">' + data[i].T_File + ' </td> </tr>');
                         jQuery('<tr><td> ' + j + '   </td><td >' + data[i].T_File + ' </td>  <td> <a  id="Dow1"' + j + ' onclick="DowPdfAll(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>   </tr>').appendTo("#Table2");
                         j++;
                     }

                     //open 
                     $("#Uploadpdf1").modal('show');
                     // $("#tableb").empty();

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
         //debugger;
         var x = document.getElementById("Table2").rows[j].cells.item(1).innerText;
         alert("j " + j + ",url : " + x);
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




     // end document


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
    <div class="card">
        <div class="card-header">
            <div class="card-actions float-end">
            </div>
            <h5 class="card-title mb-0">Tender Details</h5>
        </div>
        <div class="card-body h-100 p-0 pb-0">
            <div class="tab">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item"><a class="nav-link active" href="#tab-1" data-bs-toggle="tab" role="tab">View Win Tenders -&nbsp; <span id="aid1" style="color: #0000cd !important;"></span></a></li>
                    <li class="nav-item"><a class="nav-link" href="#tab-2" data-bs-toggle="tab" role="tab">View Lost Tenders-&nbsp; <span id="rid1" style="color: red !Important;"></span></a></li>
                    <li class="nav-item"><a class="nav-link" href="#tab-3" data-bs-toggle="tab" role="tab">View Pending Tenders-&nbsp; <span id="pid1" style="color: #FFAE42!important;"></span></a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-1" role="tabpanel">
                        <div class="row">
                            <div class="col-md-12">
                                <h4 class="float-start">Win Tenders list</h4>
                                <div class="input-group input-group-sm" style="width: 200px; float: Right;">
                                    <input list="select" id="SearchText" class="form-control" placeholder="Enter Tender Name" name="select" />
                                    <datalist class="MeClass" id="select">
                                    </datalist>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <hr>
                                <div style="width: 100%; float: left; overflow: auto;">
                                    <table id="datatables-dashboard-projects1" class="table table-striped my-0">
                                        <thead>
                                            <tr>
                                                <th>S.No.</th>
                                                <th class="d-none d-xl-table-cell">Tender Name/Doc ID</th>
                                                <th class="d-none d-xl-table-cell">Tender Item</th>
                                                <th class="d-none d-xl-table-cell">Tender Quantity</th>
                                                <th class="d-none d-xl-table-cell">Price</th>
                                                <th class="d-none d-xl-table-cell">Delivery Date</th>
                                                <th class="d-none d-xl-table-cell">Delivery Location</th>
                                                <th class="d-none d-xl-table-cell">L1 Company</th>
                                                <th class="d-none d-xl-table-cell">L1 Bid Price</th>
                                                <th class="d-none d-xl-table-cell">L2 Second Com</th>
                                                <th class="d-none d-xl-table-cell">L2 Bid Price</th>
                                                <th class="d-none d-xl-table-cell">L3 Third Comany</th>
                                                <th class="d-none d-xl-table-cell">L3 Bid Price</th>
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
                                    <div class="input-group input-group-sm" style="width: 200px; float: Right;">
                                        <input list="select2" id="SearchText2" class="form-control" placeholder="Enter Tender Name" name="select" />
                                        <datalist class="MeClass" id="select2">
                                        </datalist>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <hr>
                                <div style="width: 100%; float: left; overflow: auto;">
                                    <table id="datatables-dashboard-projects2" class="table table-striped my-0">
                                        <thead>
                                            <tr>
                                                <th>S.No.</th>
                                                <th class="d-none d-xl-table-cell">Tender Name/Doc ID</th>
                                                <th class="d-none d-xl-table-cell">Tender Item</th>
                                                <th class="d-none d-xl-table-cell">Tender Quantity</th>
                                                <th class="d-none d-xl-table-cell">Price</th>
                                                <th class="d-none d-xl-table-cell">Delivery Date</th>

                                                <th class="d-none d-xl-table-cell">L1 Company</th>
                                                <th class="d-none d-xl-table-cell">L1 Bid Price</th>
                                                <th class="d-none d-xl-table-cell">L2 Second Company</th>
                                                <th class="d-none d-xl-table-cell">L2 Bid Price</th>
                                                <th class="d-none d-xl-table-cell">L3 Third Company</th>
                                                <th class="d-none d-xl-table-cell">L3 Bid Price</th>
                                                <th class="d-none d-xl-table-cell">Our Position</th>
                                                <th class="d-none d-xl-table-cell">Our Bid Price</th>
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
                                <h4 class="float-start">Pre Tenders list</h4>
                                <div class="input-group input-group-sm" style="width: 200px; float: right;">
                                    <div class="input-group input-group-sm" style="width: 200px; float: Right;">
                                        <input list="select4" id="SearchText4" class="form-control" placeholder="Enter Tender Name" name="select" />
                                        <datalist class="MeClass" id="select4">
                                        </datalist>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <hr>
                                <div style="width: 100%; float: left; overflow: auto;">
                                    <table id="datatables-dashboard-projects3" class="table table-striped my-0">
                                        <thead>
                                            <tr>
                                                <th>S.No.</th>
                                                <th class="d-none d-xl-table-cell">Tender Name/Doc ID</th>
                                                <th class="d-none d-xl-table-cell">Company Name</th>
                                                <th class="d-none d-xl-table-cell">Publication Date</th>
                                                <th class="d-none d-xl-table-cell">PreBidMeetingDate</th>
                                                <th class="d-none d-xl-table-cell">PreBidMeetingTime</th>
                                                <th class="d-none d-xl-table-cell">PreBidMeetingVenue</th>
                                                <th class="d-none d-xl-table-cell">SubmittingDate</th>
                                                <th class="d-none d-xl-table-cell">ExtendSubDate</th>
                                                <th class="d-none d-xl-table-cell">Opening Date</th>
                                                <th class="d-none d-xl-table-cell">Tender Document File</th>

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
    <div class="modal fade" id="statustblModal" tabindex="-1" role="dialog" aria-hidden="true" style="left: 100px; top: 100px;">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Pending Tender  Record</h5>
                  
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-3">
                    <div class="tab-pane" id="Div1" role="tabpanel">
                        <div class="row">
                            <div class="col-md-12">
                                <h4 class="float-start">Pending Tenders list</h4>

                            </div>
                            <div class="col-md-12">
                                <hr>
                                <div style="width: 100%; float: left; overflow: auto;">
                                    <table id="datatables-dashboard-projects" class="table table-striped my-0">
                                        <thead>
                                            <tr>
                                                <th>S.No.
                                                </th>
                                                <th class="d-none d-xl-table-cell">Tender Name/Doc ID
                                                </th>
                                                <th class="d-none d-xl-table-cell">Company Name
                                                </th>
                                                <th class="d-none d-xl-table-cell">Attender Name
                                                </th>
                                                <th class="d-none d-xl-table-cell">Discussion
                                                </th>
                                                <th class="d-none d-xl-table-cell">Our Query
                                                </th>
                                                <th class="d-none d-xl-table-cell">Status
                                                </th>
                                                <th class="d-none d-xl-table-cell">Tender Upload File
                                                </th>
                                                <th class="d-none d-xl-table-cell">Meeting Date
                                                </th>
                                                <th class="d-none d-xl-table-cell">Other Company Name
                                                </th>
                                                <th class="d-none d-xl-table-cell">Other Company Query
                                                </th>
                                                <th class="d-none d-xl-table-cell">Tender Document File
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
               <%-- <div class="modal-footer">
                    

                </div>--%>
            </div>
        </div>
    </div>

    <%-- Modal fpor pending data--%>

    <div class="modal fade" id="statustblModal2" tabindex="-1" role="dialog" aria-hidden="true" style="left: 100px; top: 100px;">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Tender  Record</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-3">
                    <div class="tab-pane" id="Div2" role="tabpanel">
                        <div class="row">
                            <div class="col-md-12">
                                <h4 class="float-start">Tenders list</h4>

                            </div>
                            <div class="col-md-12">
                                <hr>
                                <div style="width: 100%; float: left; overflow: auto;">
                                    <table id="Table1" class="table table-striped my-0">
                                        <thead>
                                            <tr>
                                                <th>S.No.</th>
                                                <th class="d-none d-xl-table-cell">Tender Name/Doc ID</th>
                                                <th class="d-none d-xl-table-cell">Company Name</th>
                                                <th class="d-none d-xl-table-cell">Publication Date</th>
                                                <th class="d-none d-xl-table-cell">Pre-Bid Meeting Date</th>
                                                <th class="d-none d-xl-table-cell">Pre-Bid Meeting Time</th>
                                                <th class="d-none d-xl-table-cell">Pre-Bid Meeting Venue</th>
                                                <th class="d-none d-xl-table-cell">Submitting Date</th>
                                                <th class="d-none d-xl-table-cell">Extended Submission Date</th>
                                                <th class="d-none d-xl-table-cell">Opening Date</th>
                                                <th class="d-none d-xl-table-cell" id="TItem">Work/Item</th>
                                                <th class="d-none d-xl-table-cell">Quantity</th>
                                                <th class="d-none d-xl-table-cell">Price</th>
                                                <th class="d-none d-xl-table-cell">Place/Location</th>
                                                <th class="d-none d-xl-table-cell">Tender File</th>
                                                <th class="d-none d-xl-table-cell">Source</th>
                                                <th class="d-none d-xl-table-cell">Document Sale</th>
                                                <th class="d-none d-xl-table-cell">Document Fee</th>
                                                <th class="d-none d-xl-table-cell">Brief Scope</th>
                                                <th class="d-none d-xl-table-cell">Bid Valid</th>
                                                <th class="d-none d-xl-table-cell">Process Fee</th>
                                                <th class="d-none d-xl-table-cell">Emd</th>
                                                <th class="d-none d-xl-table-cell">Submission Time</th>
                                                <th class="d-none d-xl-table-cell">Un PricBidOpenDate</th>
                                                <th class="d-none d-xl-table-cell">Un PricBidOpenTime</th>
                                                <th class="d-none d-xl-table-cell">PBid Opendate</th>
                                                <th class="d-none d-xl-table-cell">PBid OpenTime</th>

                                            </tr>
                                        </thead>
                                        <tbody id="completeprojecttbl2">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
               <%-- <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                </div>--%>
            </div>
        </div>
    </div>


    <%-- //Upload pdf multiple--%>

    <div class="modal fade " id="Uploadpdf1" tabindex="-1" role="dialog" aria-hidden="true">
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
