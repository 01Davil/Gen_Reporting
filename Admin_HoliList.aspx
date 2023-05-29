<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Admin_HoliList.aspx.cs" Inherits="Admin_HoliList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script src="JsDB/bootstrap.js"></script>
    <script src="JsDB/javascript.js"></script>
    <script>
        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString();
                $(".cv").text(now);

            }
            // 
            $(function () {
                var formData = new FormData();
                formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                       $.ajax({
                           url: 'WebServerFile/AdminWebService.asmx/GetHoliDayList',
                           type: 'POST',
                           data: formData,
                           cache: false,
                           contentType: false,
                           processData: false,
                           success: function (data) {

                               // data[i].TypeLeave
                               for (var i = 0; i < data.length; i++) {
                                   var s = i + 1;
                                   var str = data[i].HoliDate;
                                   str = str.replace("12:00:00 AM", " ");
                                   var hello =
                                   '<div class="d-flex align-items-start"> <strong> '+s+'. &nbsp;</strong><div class="flex-grow-1">'
                                    + '<small class="float-end" ><b> ' +str + '</b></small>'
                                   + '<strong >' + data[i].HoliName + '</strong><br />'
                                   + '<small class="text-muted" id="Name3">' + data[i].LocationName + '</small><br />'
                                   + '</div> </div><hr />';

                                   $('#divHoliday').append(hello);
                               }
                           }

                       })
            })
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Holiday List </h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
        </div>
    </div>

    <div class="card flex-fill">
        <div class="card-header">
            <div class="row">

        <div class="col-12  d-flex">
            <div class="card flex-fill w-100">
                
                <div class="card-body" style="overflow-y: auto !important;" id="divHoliday">
                </div>
            </div>
        </div>

    </div>
        </div>

    </div>
</asp:Content>

