<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="FullAndFinal.aspx.cs" Inherits="FullAndFinal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <script src="JsDB/jquery.js"></script>
        <script src="JsDB/popper.min.js"></script>
        <script type="text/javascript">     

            function validateFileUpload() {
                var fileUpload = document.getElementById("<%= FileUpload1.ClientID %>");
                var fileName = fileUpload.value;
                var ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

                if (ext !== "xls" && ext !== "xlsx") {                    
                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: 'Only .xls and .xlsx files are allowed !',
                        timer: 1500
                    });
                    return false;
                }
                return true;
            }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
         <div class="container-fluid p-0">

        <div class="row mb-2 mb-xl-3">
            <div class="col-auto d-none d-sm-block">
                <h3>Full And Final </h3>
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
        <div class="card flex-fill">
            <div class="card-header">
                <%--<h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Attendance Summary</h5>--%>
            </div>
            <div class="card-body">

                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="form-label">Select File of Attendance.</label>                        
                         <asp:FileUpload ID="FileUpload1" CssClass="form-control form-select" runat="server" />
                    </div>
                                
                    <div class="col-md-2 pt-4">
                        <%--<a href="#" onclick="GetDate()" class=""><i class="fa fa-upload"></i>Upload </a>--%>
                        
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary float-end w-100 mt-1" Text="Upload" OnClientClick="return validateFileUpload();" OnClick="Button1_Click" />
                    </div>
                </div>

            </div>

        </div>
       
    </div>
</asp:Content>

