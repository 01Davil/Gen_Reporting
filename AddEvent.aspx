<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="AddEvent.aspx.cs" Inherits="AddEvent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
       <script src="JsDB/jquery.js"></script>
    <script>
        var a;
        a = setInterval(fun, 1000);
        function fun() {
            var today = new Date();
            var now = today.toLocaleString().toUpperCase();
            $(".cv").text(now);


        }
        $(function () {
            getEvent("NA");
        })
        // yhis function save event 
        function SaveEvent() {
            var EventName = $("#EventName").val();
            var EventDate = $("#daterangepicker").val();
            var Description = $("#Description").val();
            $(".loaderbg").show();
            if (EventName == " " || EventName.length == 0 || EventDate.length == 0 || EventDate == " " || Description.length == 00 || Description == " ") {
                Swal.fire({
                    icon: 'warning',
                    title: 'warning',
                    width: '300px',
                    text: 'all input fields required !',

                })
                $(".loaderbg").hide();
            } else {
                var formData = new FormData();
                formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                formData.append("EventName", EventName);
                formData.append("EventDate", EventDate);
                formData.append("Description", Description);
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/SaveEvent',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        //console.log(data[0].response);
                        if (data[0].response == "Fail") {
                            $(".loaderbg").hide();
                            Swal.fire({
                                icon: 'warning',
                                title: 'warning',
                                width: '300px',
                                text: 'Event Not Save!',
                                timer: 1500
                            })
                        } else {
                            $(".loaderbg").hide();
                            Swal.fire({
                                icon: 'success',
                                title: 'success',
                                width: '300px',
                                text: 'Event Save Success !',

                            })
                            getEvent("NA");
                        }
                     
                    }
                });
            }
        }

        //
        function getEvent(Date) {
               $(".loaderbg").show();
             var formData = new FormData();
             formData.append("Date", Date);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/ShowEvent',
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
                            text: 'Details Not Found. !',
                        })

                        $("#TableThead").empty();
 
                    } else {
                        $("#TableThead").empty();
 
                        $("#TableThead").append('  <thead> <tr> <th>S.No.</th> <th class="d-none d-xl-table-cell">Event Name </th> <th class="d-none d-xl-table-cell">Event Date </th><th class="d-none d-xl-table-cell">Event Description </th>  <th class="d-none d-md-table-cell">Option </th></tr>  </thead> ');
                       // alert(data.length);
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {

                            if (data[i].Type == 1) {

                                jQuery('<tbody> <tr> <td style=" display :none;"> ' + data[i].id + '</td> <td>' + j + '</td><td>' + data[i].EventName + '</td><td>' + data[i].EventDate + '</td> <td>' + data[i].EventDescription + '</td>'
                                + '<td><a  data-bs-toggle="tooltip" id="EditEvent"' + j + ' onclick="EditEvent(' + j + ')" data-bs-placement="top" title="" data-bs-original-title="Edit"><i class="fa fa-edit"></i></a> &nbsp; &nbsp;'
                               // + '<a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp;'
                                + ' <a  id="Delete"' + j + ' onclick="DeleteEvent(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Delete"><i class="fa fa-trash-alt"></i></a> </td>  '

                                + '   </tr> </tbody>').appendTo("#TableThead");

                            } else {
                                jQuery('<tbody> <tr> <td style=" display :none;"> ' + data[i].id + '</td> <td>' + j + '</td><td>' + data[i].EventName + '</td><td>' + data[i].EventDate + '</td> <td>' + data[i].EventDescription + '</td> <td> <br/>  </td>   </tr> </tbody>').appendTo("#TableThead");

                            }
                                j++;
                            }
                        }
                        
                    
                }
            });
            $(".loaderbg").hide();
        }
        function EditEvent(j) {

            //var id = document.getElementById("TableThead").rows[j].cells.item(0).innerText;
            $("#MYid").val(document.getElementById("TableThead").rows[j].cells.item(0).innerText);
            $("#EventName1").val(document.getElementById("TableThead").rows[j].cells.item(2).innerText);
            $("#daterangepicker1").val(document.getElementById("TableThead").rows[j].cells.item(3).innerText);
            $("#Description1").val(document.getElementById("TableThead").rows[j].cells.item(4).innerText);

            $("#defaultModalPrimary").modal('show');
       //     alert(id + ", " + Name + " , " + EventDate + " ," + Description);
        }
        function DeleteEvent(id) {
            var formData = new FormData();
            formData.append("id", document.getElementById("TableThead").rows[id].cells.item(0).innerText);
            $.ajax({
                url: 'WebServerFile/WebService.asmx/DeleteEvent',//DeleteExpenese',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (Result) {
                    if (Result == 'Save') {
                        Swal.fire({
                            icon: 'success',
                            width: '300px',
                            text: "Event Delete Success ",
                            timer: 3000
                        });
                        getEvent("NA");
                    }
                },
                xhr: function () {
                    var fileXhr = $.ajaxSettings.xhr();
                    if (fileXhr.upload) {

                    }
                    return fileXhr;
                }
            })
        }

        function updateEvent() {

             var EventName = $("#EventName1").val();
            var EventDate = $("#daterangepicker1").val();
            var Description = $("#Description1").val();
            var id = $("#MYid").val();

            $(".loaderbg").show();
            if (EventName == " " || EventName.length == 0 || EventDate.length == 0 || EventDate == " " || Description.length == 00 || Description == " ") {
                Swal.fire({
                    icon: 'warning',
                    title: 'warning',
                    width: '300px',
                    text: 'all input fields required !',

                })
                $(".loaderbg").hide();
            } else {
                var formData = new FormData();
                formData.append("id", id);
                formData.append("EventName", EventName);
                formData.append("EventDate", EventDate);
                formData.append("Description", Description);
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/UpdateEvent',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data[0].response == 'success') {
                            $(".loaderbg").hide();
                            Swal.fire({
                                icon: 'success',
                                width: '300px',
                                text: "Event Update Success ",
                                timer: 3000
                            });

                            getEvent("NA");
                            $("#defaultModalPrimary").modal('hide');
                        } else {
                            Swal.fire({
                                icon: 'error',
                                width: '300px',
                                text: "Event Not Update Success ",
                                timer: 3000
                            });
                        }
                    }
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <input type="text" style="display:none" id="MYid" />
    <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3>Add New Event</h3>
                            </div>

                            <div class="col-auto ms-auto text-end mt-n1">

                                <div class=" me-2 d-inline-block">
                                    <span class="btn btn-light bg-white shadow-sm ">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar align-middle mt-n1"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg> <strong class="cv">2022/10/12 - 12:11:47</strong>
                                    </span>
                                </div>
                            </div>
                        </div>


                        <div class="row">

                            <div class="col-12 col-lg-12 d-flex">
                                <div class="card flex-fill w-100">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Enter Event Details</h5>
                                    </div>
                                    <div class="card-body">

                                        <div class="row mt-4">
                                            <div class="col-md-6">
                                                <label class="form-label">Event Heading*</label>
                                                <input type="text" class="form-control" id="EventName">
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Event Date*</label>
                                                <input type="text" id="daterangepicker" class="form-control" >
                                            </div>

                                        </div>
                                        <div class="row mt-4">
                                            <div class="col-md-12">
                                                <label class="form-label">Event Description(400 words)*</label>
                                                <input type="text" class="form-control" id="Description" placeholder="Event Details">
                                            </div>

                                        </div>

                                        <div class="row mt-4 mb-4">
                                            <div class="col-md-12">
                                                <a href="#" class="btn btn-primary float-end" onclick="SaveEvent()"> CREATE EVENT </a>
                                            </div>

                                        </div>




                                    </div>
                                </div>
                            </div>

                        </div>
    <div class="card flex-fill">
        <div class="card-header">
            <br />
        </div>

        <div class="card-body">
            <table id="TableThead" class="table table-striped my-0">
                <%--    <thead id="">
                </thead>
                <tbody id="TableTbody">
                    </tbody>--%>
            </table>

        </div>
    </div>


    <div class="modal fade" id="defaultModalPrimary" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Default modal</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="row">

                    <div class="col-12 col-lg-12 d-flex">
                        <div class="card flex-fill w-100">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Udate Event Details</h5>
                            </div>
                            <div class="card-body">

                                <div class="row mt-4">
                                    <div class="col-md-6">
                                        <label class="form-label">Event Heading*</label>
                                        <input type="text" class="form-control" id="EventName1">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Event Date*</label>
                                        <input type="text" id="daterangepicker1" class="form-control">
                                    </div>

                                </div>
                                <div class="row mt-4">
                                    <div class="col-md-12">
                                        <label class="form-label">Event Description(400 words)*</label>
                                        <input type="text" class="form-control" id="Description1" placeholder="Event Details">
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-primary" onclick="updateEvent()">Save changes</button>
                </div>
            </div>
        </div>
    </div>


    <script>

        $(function () {

           // $("#daterangepicker").daterangepicker({ minDate: new Date() });

            $(function () {
                $('#daterangepicker').daterangepicker({
                    singleDatePicker: true,
                    showDropdowns: true,
                    minDate: new Date(),
                    dateFormat: 'dd-mm-yyyy'
                });
            });
        })

    </script>
</asp:Content>

