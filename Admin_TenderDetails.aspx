<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_TenderDetails.aspx.cs" Inherits="Admin_TenderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    var masterimage;
    function SaveTenderDetails() {
        debugger;
      

        var Tender_Name = $("#TName").val();
        var Company_Name = $("#CName").val();
        var T_Publication_Date = $("#TPDate").val();
        var T_PreBidMeetingDate = $("#TPreBMDate").val();
        var T_SubmittingDate = $("#TSubmitDate").val();
        var T_ExtendSubDate = $("#Date1").val();
        var OpeningDate = $("#OpenDate").val();
        var T_Item = $("#TItem").val();
        var T_Quantity = $("#TQuantity").val();
        var Price = $("#price").val();
        var T_Location = $("#TLocation").val();
        var file = $('#UploadFile')[0].files.length;
        var T_Source = $("#TSource").val();
        if (Tender_Name != ' ' || Company_Name != ' ' || T_Publication_Date != ' '
          || T_PreBidMeetingDate != ' ' || T_SubmittingDate != ' ' || T_ExtendSubDate != ' ' ||
          OpeningDate != ' ' || T_Item != ' ' || T_Quantity != ' '
          || Price != ' ' || T_Location != ' ' || file != ' ' || T_Source != ' ') {
            Swal.fire('Please Fill All Required data');
        } else {
            var formData = new FormData();
            formData.append("Tender_Name", Tender_Name);
            formData.append("Company_Name", Company_Name);
            formData.append("T_Publication_Date", T_Publication_Date);
            formData.append("T_PreBidMeetingDate", T_PreBidMeetingDate);
            formData.append("T_SubmittingDate", T_SubmittingDate);
            formData.append("T_ExtendSubDate", T_ExtendSubDate);
            formData.append("OpeningDate", OpeningDate);
            formData.append("T_Item", T_Item);
            formData.append("T_Quantity", T_Quantity);
            formData.append("Price", Price);
            formData.append("T_Location", T_Location);
            formData.append("T_Source", T_Source); //$("#SlipFile")[0].files[0]
            formData.append("T_File", $("#UploadFile")[0].files[0]);

            $.ajax({
                url: 'WebServerFile/TenderWebService.asmx/SaveTender',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (Result) {
                    Swal.fire({
                        icon: 'success',
                        width: '300px',
                        text: "Tender Apply success",
                        timer: 3000
                    });
                },
                error: function (response) {
                    alert(" Error:" + response.d);

                }
            });
        }
    }


    //      function encodeImageFileAsURL(element) {
    //        let file = element.files[0];
    //        let reader = new FileReader();
    //        reader.onloadend = function() {
    //          var x=(reader.result);
    //          masterimage =x.replace('data:TenderUploadFile/pdf;base64,','');
    //        }
    //        reader.readAsDataURL(file);
    //      }


</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row">
        <div class="col-12 col-lg-12 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        Tender Details</h5>
                </div>
                <div class="card-body">
                    <div class="row mt-4">
                        <div class="col-md-4  mt-3">
                            <label class="form-label">
                                Tender Name/ID</label>
                            <input type="text" class="form-control" id="TName">
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
                                Tender Pre-Bid Meeting Date</label>
                            <input type="date" class="form-control" id="TPreBMDate">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Submitting Date</label>
                            <input type="date" class="form-control" id="TSubmitDate">
                        </div>


                          <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Extended Submission Date</label>
                            <input type="date" class="form-control" id="Date1">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Opening Date</label>
                            <input type="date" class="form-control" id="OpenDate">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Work/Item</label>
                            <input type="text" class="form-control" id="TItem">
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Quantity</label>
                            <input type="text" class="form-control" id="TQuantity">
                        </div>
                         <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Price</label>
                            <input type="text" class="form-control" id="price">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Location</label>
                            <input type="text" class="form-control" id="TLocation">
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Upload File</label>
                            <input type="file" class="form-control" placeholder="" id="UploadFile" >
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">
                                Tender Source</label>
                            <input type="text" class="form-control" id="TSource">
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-12 mt-4 pt-1">
                            <%-- <a href="#" class="btn btn-primary float-end" onclick="btnupdatework(); > &nbsp; Submit &nbsp; </a>--%>
                            <button type="submit" id="btnupdate" class="btn btn-primary btn-pill" onclick="SaveTenderDetails();">
                                Submit
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

