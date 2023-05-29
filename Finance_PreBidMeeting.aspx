<%@ Page Title="" Language="C#" MasterPageFile="~/Finance_MasterPage.master" AutoEventWireup="true" CodeFile="Finance_PreBidMeeting.aspx.cs" Inherits="Finance_PreBidMeeting" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>AdmPreBidMetting</title>
    <link rel="canonical" href="pages-sign-in.html" />
    <link rel="shortcut icon" href="img/favicon.ico"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&amp;display=swap" rel="stylesheet"/>
    <link href="css/light.css" rel="stylesheet"/>
    
    <style type="text/css">
        .xyz
        {
            display: block;
            color : Black;
            }
    </style>
    <script src="JsDB/jquery.js" type="text/javascript"></script>
    <script src="JsDB/popper.min.js" type="text/javascript"></script>
    <script src="JsDB/bootstrap.js" type="text/javascript"></script>
    <script src="JsDB/javascript.js" type="text/javascript"></script>
    <script type="text/javascript">

        var MasterPBM = "";
        var MasterId = "";

        $(document).ready(function () {


            $(function () {
                debugger
                $("#listTable").hide();
            });

            $("#addItemp").click(function (e) {

                debugger;

                e.preventDefault();

                var Company_Name = $("#ComName").val().trim();
                var AttenderName = $("#AteenName").val().trim();
                var Discussion = $("#Discuss").val().trim();
                var OurQuery = $("#OQuery").val().trim();
                var Status = $("#status").val().trim();
                var MeetingDate = $("#meetingDate").val().trim();
                var T_MeetingFile = $("#FileUpload")[0].files.length;
                var Tender_Name = $("#OtherComName").val().trim();
                var Other_CompanyQuery = $("#OtherComQuery").val().trim();
                var file = $('#File1')[0].files.length;


                obj1s = {

                    Tender_Name: $("#TerName").val(),
                    Company_Name: $("#ComName").val(),
                    AttenderName: $("#AteenName").val(),
                    Discussion: $("#Discuss").val(),
                    OurQuery: $("#OQuery").val(),
                    Status: $("#status").val(),
                    MeetingDate: $("#meetingDate").val(),
                    T_MeetingFile: $("#FileUpload")[0].files.length,
                    Other_CompanyName: $("#OtherComName").val(),
                    Other_CompanyQuery: $("#OtherComQuery").val(),
                    file: $('#File1')[0].files.length
                }

                //if (obj1s.Tender_Name != ' ' || obj1s.Company_Name != ' ' || obj1s.AttenderName != ' '
                //   || obj1s.Discussion != ' ' || obj1s.OurQuery != ' ' || obj1s.Status != ' ' || obj1s.MeetingDate != ' ' || obj1s.T_MeetingFile != ' ' 
                //   || obj1s.Other_CompanyName != ' '|| obj1s.Other_CompanyQuery != ' ' || obj1s.file != ' ') 

                //{  Swal.fire('Please Fill All Required data');

                // }
                //else {
                $.ajax({
                    type: "POST",
                    url: "Finance_PreBidMeeting.aspx/SaveReqSlipItemp",
                    data: JSON.stringify(obj1s),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        $("#listTable").show();
                        xmlDoc = response.d;
                        var j = 1;
                        if (xmlDoc[0].Mid == 1) {
                            Swal.fire("please enter different data;");
                            $("#list").empty();
                            for (var i = 0; i <= xmlDoc.length - 1; i++) {
                                MasterPBM = xmlDoc[i].Tender_Name;
                                jQuery('<tr><td>' + j + '</td><td>' + xmlDoc[i].Other_CompanyName + '</td> <td>' + xmlDoc[i].Other_CompanyQuery + '</td><td>' + xmlDoc[i].file + '</td>  </tr>').appendTo("#list");
                                j++;
                            }
                        }
                        else {
                            clear();
                            Swal.fire('success', 'Add Item');
                            $("#list").empty();
                            $('#proceed').show();
                            for (var i = 0; i <= xmlDoc.length - 1; i++) {
                                MasterPBM = xmlDoc[i].Tender_Name;
                                jQuery('<tr><td>' + j + '</td><td>' + xmlDoc[i].Other_CompanyName + '</td> <td>' + xmlDoc[i].Other_CompanyQuery + '</td><td>' + xmlDoc[i].file + '</td>  </tr>').appendTo("#list");
                                j++;
                            }
                        }
                    }, error: function (s) {
                        Swal.fire("Please fill required inputs.");
                    }

                });
                function clear() {
                    $("#OtherComName").val('');
                    $("#OtherComQuery").val('');
                    $("#File1").val('');

                }
                //}
                //               

                //                function DeleteItem(id) {
                //                    debugger;
                //                    obj2 = {
                //                        Tender_Name: $("#TerName").val(),
                //                        id: id
                //                    }
                //                    $.ajax({
                //                        type: "POST",
                //                        url: "AdmPreBidMetting.aspx/ItemDelete",
                //                        data: JSON.stringify(obj2),
                //                        contentType: "application/json; charset=utf-8",
                //                        dataType: "json",
                //                        success: function (r) {
                //                            alert('success', 'Delete Item');

                //                            xmlDoc = r.d;
                //                            $("#list").empty();
                //                            var j = 1;
                //                            for (var i = 0; i <= xmlDoc.length - 1; i++) {
                //                                MasterPBM = xmlDoc[i].Tender_Name;
                //                                jQuery('<tr><td>' + j + '</td><td>' + xmlDoc[i].Other_CompanyName + '</td> <td>' + xmlDoc[i].Other_CompanyQuery + '</td><td>' + xmlDoc[i].file + '</td><td class="table-action"> <a class="deleteBtn" onclick="DeleteItem(' + xmlDoc[i].id + ')"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash align-middle"><polyline points="3 6 5 6 21 6"></polyline> <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path> </svg></a> </td>  </tr>').appendTo("#list");
                //                                j++;
                //                            }
                //                            if (r.d.length == 0) {
                //                                $("#proceed").hide();
                //                                alert('Please enter data first for generate this Pre bid metting details');
                //                            }

                //                        }
                //                    });
                //                }
                //            });

                $("#proceed").click(function () {
                    Swal.fire("save");
                    window.location.reload();
                });
            });
        });
 </script>

        
         


 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div class="row">
        <div class="col-12 col-lg-12 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        Tender Pre-Bid Meeting</h5>
                </div>
                <div class="card-body">
                    <div class="row mt-4">
                        <div class="col-md-4  mt-3">
                            <label class="form-label">
                                Tender Name/ID</label>
                            <input type="text" class="form-control" id="TerName">
                        </div>
                          <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Company Name</label>
                            <input type="text" class="form-control" id="ComName">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Attender Name</label>
                            <input type="text" class="form-control" id="AteenName">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Discussion </label>
                            <input type="text" class="form-control" id="Discuss">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Our Query</label>
                            <input type="text" class="form-control" id="OQuery">
                        </div>                       
                             <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Status</label>
                            <input type="text" class="form-control" id="status">
                        </div>
                         <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Upload File</label>
                            <input type="file" class="form-control" placeholder="" id="FileUpload">
                        </div>                    
                    <div class="col-md-4 mt-3">
                            <label class="form-label">
                              Meeting Date</label>
                            <input type="date" class="form-control" id="meetingDate">
                        </div>

                   <div class="row mt-4">
                         <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Other Company Name</label>
                            <input type="text" class="form-control" id="OtherComName">
                        </div>

                          <div class="col-md-4 mt-3">
                            <label class="form-label">
                                 Other Company Query</label>
                            <input type="text" class="form-control" id="OtherComQuery">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Upload File</label>
                            <input type="file" class="form-control" placeholder="" id="File1">
                        </div>
                                        </div>
                                       
                                        <div class="mb-4 mt-3">
                                         <button type="submit" class="btn btn-primary float-end"  " id="addItemp">
                                           Add
                                         Item to List</button>
                                          </div>
                 
                </div>
            </div>
              </div>  
              </div> 
               </div> 

   <div class="row" id="listTable">
                    <div class=" col-md-12">
                        <div class="card width-100 p-2">
                            <div class="card-header">
                                <h5 class="card-title">Items List</h5>

                            </div>
                            <table class="table" id="DataTable">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;">S.No.</th>
                                       <th class="form-label">Other Company Name</th>               
                                       <th class="form-label">Other Company Query</th>
                                       <th class="form-label">Upload File</th>
                                     <%--  <th class="form-label">Action</th>--%>
                                    </tr>
                                </thead>
                                <tbody id="list">
                                </tbody>
                            </table>

                            <br>
                            <div class="row p-3">
                                <div class="col-md-12">
                                    <div class="text-right mt-3 mb-3">
                                        <button id="proceed" type="button" class="btn btn-lg btn-primary float-end"
                                            style="width: 160px;">Proceed</button>
                                    </div>
                                </div>
                            </div>
                          
                        </div>


                    </div>

                </div>





     
    <%--end testing part--%>

   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/table-to-json/1.0.0/jquery.tabletojson.js" type="text/javascript"></script>
    <script src="js/app.js" type="text/javascript"></script>
    <script type="text/javascript">

    </script>
 

    </asp:Content>
