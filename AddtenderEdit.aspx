<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="AddtenderEdit.aspx.cs" Inherits="AddtenderEdit" %>


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
            $(document).ready(function () {
                $(function () {
                    $('.single_cal4').daterangepicker({
                        timePicker: true,
                        singleDatePicker: true,
                        timePicker24Hour: false,
                        timePickerIncrement: 1,
                        timePickerSeconds: false,
                        locale: {
                            format: 'hh:mm A', // added A for AM/PM
                            meridiem: ['AM', 'PM'] // specify AM/PM strings
                        }
                    }).on('show.daterangepicker', function (ev, picker) {
                        picker.container.find(".calendar-table").hide();
                    });
                })
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

                            jQuery('<tr><td> ' + j + '   </td><td>' + data[i].Tender_Name + '  </td>  <td>' + data[i].Company_Name + ' </td><td>' + data[i].T_Publication_Date + ' </td><td>' + data[i].T_SubmittingDate + ' </td><td>' + data[i].OpeningDate + '  </td><td>' + data[i].T_PreBidMeetingDate + ' </td><td>' + data[i].T_PreBidMeetingTime + ' </td><td>' + data[i].Extended_SubmissionDate + ' </td>  <td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; ' + '</td>   <td> <button type="button" class="btn btn-primary" id="update' + j + ' " onclick="ViewListModal(' + data[i].id + ')">  List </button> </td><td><a  data-bs-toggle="tooltip" id="Edit"' + j + ' onclick="EditService(' + data[i].id + ')" data-bs-placement="top" title="" data-bs-original-title="Edit"><i class="fa fa-edit"></i></a></td> </tr>').appendTo("#completeprojecttbl");
                            j++;
                            // end for loop
                        }
                    }
                }
            });
        }


        //        view list Modal
        function ViewListModal(id) {

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
            alert(Tender_Name);

          //  debugger;
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
          //  debugger;
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
        // edit
        var MasterId;
        function EditService(id) {

            var formData = new FormData();
            formData.append("id", id);
           // alert(id);
            $.ajax({
                url: 'WebServerFile/TenderWebService.asmx/GetTenderEdit',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    // data = r.d;
                    MasterId = id;
                    // console.log('MasterId:', MasterId);
                    $("#TName").val(data[0].Tender_Name);
                    $("#CName").val(data[0].Company_Name);
                    $("#TPDate").val(data[0].T_Publication_Date);
                    $("#TPreBMDate").val(data[0].T_PreBidMeetingDate);
                    $("#TPreBMTime").val(data[0].T_PreBidMeetingTime);
                    $("#TPreBMV").val(data[0].T_PreBidMeetingV);
                    $("#TSubmitDate").val(data[0].T_SubmittingDate);
                    $("#Date1").val(data[0].Extended_SubmissionDate);
                    $("#OpenDate").val(data[0].OpeningDate);
                    $("#TItem").val(data[0].T_Item);
                    $("#TQuantity").val(data[0].T_Quantity);
                    $("#price").val(data[0].Price);
                    $("#TLocation").val(data[0].T_Location);
                    $("#TSource").val(data[0].T_Source);
                    $("#T_Doc_Sale").val(data[0].T_Doc_Sale);
                    $("#T_Doc_Fee").val(data[0].T_Doc_Fee);
                    $("#Brief_Scope").val(data[0].Brief_Scope);
                    $("#Bid_Valid").val(data[0].Bid_Valid);
                    $("#T_ProcFee").val(data[0].T_ProcFee);
                    $("#Emd").val(data[0].Emd);
                    $("#T_SubmTime").val(data[0].T_SubmTime);
                    $("#Un_PricBidOpenDate").val(data[0].Un_PricBidOpenDate);
                    $("#Un_PricBidOpenTime").val(data[0].Un_PricBidOpenTime);
                    $("#PBidOpendate").val(data[0].PBidOpendate);
                    $("#PBidOpenTime").val(data[0].PBidOpenTime);
                    $("#myModal").modal('show');
                }
            });
        }



        function SaveEdit8() {
           // debugger;
            //alert(MasterId);
           
            var Tender_Name = $("#TName").val();
            var Company_Name = $("#CName").val();
            var T_Publication_Date = $("#TPDate").val();
            var T_PreBidMeetingDate = $("#TPreBMDate").val();
            var T_PreBidMeetingTime = $("#TPreBMTime").val();
            var T_PreBidMeetingV = $("#TPreBMV").val();
            var T_SubmittingDate = $("#TSubmitDate").val();
            var T_ExtendSubDate = $("#Date1").val();
            var OpeningDate = $("#OpenDate").val();
            var T_Item = $("#TItem").val();
            var T_Quantity = $("#TQuantity").val();
            var Price = $("#price").val();
            var T_Location = $("#TLocation").val();
            var T_Source = $("#TSource").val();

            var T_Doc_Sale = $("#T_Doc_Sale").val();
            var T_Doc_Fee = $("#T_Doc_Fee").val();
            var Brief_Scope = $("#Brief_Scope").val();
            var Bid_Valid = $("#Bid_Valid").val();
            var T_ProcFee = $("#T_ProcFee").val();
            var Emd = $("#Emd").val();
            var T_SubmTime = $("#T_SubmTime").val();
            var Un_PricBidOpenDate = $("#Un_PricBidOpenDate").val();
            var Un_PricBidOpenTime = $("#Un_PricBidOpenTime").val();
            var PBidOpendate = $("#PBidOpendate").val();
            var PBidOpenTime = $("#PBidOpenTime").val();

            if (Tender_Name == ' ' || Tender_Name.length == 0 || Company_Name == ' ' || Company_Name.length == 0 || T_Publication_Date == ' ' ||
                    T_Publication_Date.length == 0 || T_PreBidMeetingDate == ' ' || T_PreBidMeetingDate.length == 0 || T_PreBidMeetingTime == ' ' || T_PreBidMeetingTime.length == 0
                    || OpeningDate == ' ' || T_PreBidMeetingV == ' ' || T_PreBidMeetingV.length == 0 ||
                     OpeningDate.length == 0 || T_Item == ' ' || T_Item.length == 0 || T_Quantity == ' ' || T_Quantity.length == 0
                     || Price == ' ' || Price.length == 0 || T_Location == ' ' || T_Location.length == 0 || T_Source == ' ' || T_Source.length == 0
                     || T_Doc_Sale == ' ' || T_Doc_Sale.length == 0 || T_Doc_Fee == ' ' || T_Doc_Fee.length == 0
                     || Brief_Scope == ' ' || Brief_Scope.length == 0 || Bid_Valid == ' ' || Bid_Valid.length == 0 || T_ProcFee == ' '
                     || T_ProcFee.length == 0 || Emd == ' ' || Emd.length == 0 || T_SubmTime == ' ' || T_SubmTime.length == 0 || Un_PricBidOpenDate == ' '
                      || Un_PricBidOpenDate.length == 0 || Un_PricBidOpenTime == ' ' || Un_PricBidOpenTime.length == 0 || PBidOpendate == ' '
                      || PBidOpendate.length == 0 || PBidOpenTime == ' ' || PBidOpenTime.length == 0) {
                Swal.fire('Please Fill All Required data');
            }
            else {

                var formData = new FormData();
                formData.append("MasterId", MasterId);
                formData.append("Tender_Name", Tender_Name);
                formData.append("Company_Name", Company_Name);
                formData.append("T_Publication_Date", T_Publication_Date);
                formData.append("T_PreBidMeetingDate", T_PreBidMeetingDate);
                formData.append("T_PreBidMeetingTime", T_PreBidMeetingTime);
                formData.append("T_PreBidMeetingV", T_PreBidMeetingV);
                formData.append("T_SubmittingDate", T_SubmittingDate);
                formData.append("T_ExtendSubDate", T_ExtendSubDate);
                formData.append("OpeningDate", OpeningDate);
                formData.append("T_Item", T_Item);
                formData.append("T_Quantity", T_Quantity);
                formData.append("Price", Price);
                formData.append("T_Location", T_Location);
                formData.append("T_Doc_Sale", T_Doc_Sale);
                formData.append("T_Doc_Fee", T_Doc_Fee);
                formData.append("Brief_Scope", Brief_Scope);
                formData.append("Bid_Valid", Bid_Valid);
                formData.append("T_ProcFee", T_ProcFee);
                formData.append("Emd", Emd);
                formData.append("T_SubmTime", T_SubmTime);
                formData.append("Un_PricBidOpenDate", Un_PricBidOpenDate);
                formData.append("Un_PricBidOpenTime", Un_PricBidOpenTime);
                formData.append("PBidOpendate", PBidOpendate);
                formData.append("PBidOpenTime", PBidOpenTime);
                formData.append("T_Source", T_Source);
                alert(formData);
                $.ajax({
                    url: 'WebServerFile/TenderWebService.asmx/EditTender',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (result) {
                        alert(result);
                        if (result[0].response == "Not") {
                            Swal.fire({
                                icon: 'info',
                                title: 'info',
                                width: '300px',
                                text: 'Tender Not  Apply !',
                               // timer: 1500
                            })
                        } else {
                            Swal.fire({
                                icon: 'success',
                                width: '300px',
                                text: "Tender update Apply success",
                                //timer: 3000
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log('AJAX error:', xhr, status, error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            width: '300px',
                            text: 'An error occurred while updating the tender',
                            //timer: 1500
                        });
                    }
                });
                                
               
            }
        }

        function CheckAvailability() {
          //  debugger;
            var formData = new FormData();
            formData.append("Name", $("#TName").val());
            $.ajax({
                url: "WebServerFile/TenderWebService.asmx/CheckTender",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    Swal.fire(data[0].response);
                }
            });


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
                        <th class="d-none d-xl-table-cell">View</th>
                        <th class="d-none d-xl-table-cell">Edit</th>
                    </tr>
                </thead>
                <tbody id="completeprojecttbl">
                </tbody>
            </table>
        </div>
    </div>











    <%--demo modal--%>
    <!-- .modal -->
    <div class="modal fade" id="Mymodal2">
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


    <%--//edit modal--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Item</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body m-3">
                    <div class="row">
                        <div class="col-12 col-lg-12 d-flex">
                            <div class="card flex-fill w-100">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Tender Details</h5>
                                </div>

                                <div class="card-body">
                    <div class="row mt-4">
                        <div class="col-md-4  mt-3">
                            <label class="form-label">
                                Tender Document Number</label>
                            <input type="text" class="form-control" onclick="CheckAvailability()" id="TName" />
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Company Name</label>
                            <input type="text" class="form-control" id="CName">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Publication Date</label>
                            <input type="date" class="form-control" id="TPDate">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Opening Date</label>
                            <input type="date" class="form-control" id="OpenDate">
                        </div>
                        <div class="col-md-4  mt-3">
                            <label class="form-label">
                                Tender Document Sale</label>
                            <input type="text" class="form-control" id="T_Doc_Sale">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Document fee</label>
                            <input type="text" class="form-control float" id="T_Doc_Fee">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Pre-Bid Meeting Date</label>
                            <input type="date" class="form-control" id="TPreBMDate">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Pre-Bid Meeting Time</label>
                            <input type="Text" class="form-control single_cal4" id="TPreBMTime">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Pre-Bid Meeting Venue</label>
                            <input type="Text" class="form-control" id="TPreBMV">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Bid Submitting Date</label>
                            <input type="date" class="form-control" id="TSubmitDate">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Bid Submitting time</label>
                            <input type="text" class="form-control single_cal4" id="T_SubmTime">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Processing fee</label>
                            <input type="text" class="form-control float" id="T_ProcFee">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Extended Submission Date</label>
                            <input type="date" class="form-control" id="Date1">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Bid Validity</label>
                            <input type="text" class="form-control" id="Bid_Valid">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                EMD/ Bid Security</label>
                            <input type="text" class="form-control" id="Emd">
                        </div>



                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Un-Priced Bid-Opening Date</label>
                            <input type="date" class="form-control" id="Un_PricBidOpenDate">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Un-Priced Bid-Opening Time</label>
                            <input type="text"  class="form-control single_cal4" id="Un_PricBidOpenTime">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Price Bid-Opening Date</label>
                            <input type="Date" class="form-control" id="PBidOpendate">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Price Bid-Opening Time</label>
                            <input type="text"  class="form-control single_cal4" id="PBidOpenTime">
                        </div>


                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Work/Item</label>
                            <input type="text" class="form-control" id="TItem">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Quantity</label>
                            <input type="text" class="form-control numberonly" id="TQuantity">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Price</label>
                            <input type="text" class="form-control float" id="price">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender work Location</label>
                            <input type="text" class="form-control" id="TLocation">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Source</label>
                            <input type="text" class="form-control" id="TSource">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Brief Scope</label>
                            <input type="text" class="form-control" id="Brief_Scope">
                        </div>               

                     
                    </div>
                </div>


                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="md-4 mt-3">
                        <button type="submit" id="7" class="btn btn-primary float-end mb-2 me-2" onclick="SaveEdit8();">
                            Save
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


