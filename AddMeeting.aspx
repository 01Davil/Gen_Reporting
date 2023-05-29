<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="AddMeeting.aspx.cs" Inherits="AddMeeting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>

       <script src="JsDB/jquery.js"></script>
     
        <script type="text/javascript">
            $(function () {                
                jQuery(document).ready(function () {

                    $('#MD').datepicker({
                        format: "dd/mm/yyyy",
                        clearBtn: true,
                        minDate: 0,
                       // maxDate: "+1M +1M",
                        daysOfWeekDisabled: "0,6"

                    });
                });
                //md1 update
                jQuery(document).ready(function () {

                    $('#MD1').datepicker({
                        format: "dd/mm/yyyy",
                        clearBtn: true,
                        minDate: 0,
                        // maxDate: "+1M +1M",
                        daysOfWeekDisabled: "0,6"

                    });
                });
            });
            $(function () {
                getEvent2("NA");

            })
            $(document).ready(function() {
              
                $(function () {
                    $.ajax({
                        type: "POST",
                        url: "AddMeeting.aspx/GetYear",
                        data: '{ }',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            xmlDoc = r.d;
                            var ddlCustomers = $("[id*=DepDrop]");
                            ddlCustomers.empty().append('<option selected="selected" value="0">Select Departement</option>');
                            for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].DepName).html(xmlDoc[i].DepName));
                            }
                            ddlCustomers.append('<option value="all">All</option>');
                            // Handle the "change" event of the dropdown list
                            ddlCustomers.on("change", function () {
                                if ($(this).val() == "all") {
                                    $(this).find("option").prop("selected", true);
                                }
                            });

                        }
                    });
                });
            });

            $(document).ready(function () {
                GetDepDrop();
                // meeting edit 
                $(function () {
                    $.ajax({
                        type: "POST",
                        url: "AddMeeting.aspx/GetYear",
                        data: '{ }',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            xmlDoc = r.d;
                            var ddlCustomers = $("[id*=DepDrop1]");
                            ddlCustomers.empty().append('<option selected="selected" value="0">Select Departement</option>');
                            for (var i = 0; i <= xmlDoc.length - 1; i++) {
                                ddlCustomers.append($("<option></option>").val(xmlDoc[i].DepName).html(xmlDoc[i].DepName));
                            }
                            ddlCustomers.append('<option value="all">All</option>');
                            // Handle the "change" event of the dropdown list
                            ddlCustomers.on("change", function () {
                                if ($(this).val() == "all") {
                                    $(this).find("option").prop("selected", true);
                                }
                            });

                        }
                    });
                });
            });
           
            function GetDepDrop() {

                var ddlCustomers = $("[id*=EmpDrop]");
                ddlCustomers.empty();
                var DepName = $("#DepDrop option:selected").text();
                // alert(DepName)
                $.ajax({
                    type: "POST",
                    url: "AddMeeting.aspx/GetMonthWithYear",
                    data: '{DepName :  "' + DepName + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;
                        var ddlCustomers = $("[id*=EmpDrop]");
                        ddlCustomers.empty().append('<option selected="selected" value="0">Select Empolyee</option>');
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].EmpName).html(xmlDoc[i].EmpName));
                        }
                        // Add an option for selecting all values
                        ddlCustomers.append('<option value="all">All</option>');
                        // Handle the "change" event of the dropdown list
                        ddlCustomers.on("change", function () {
                            if ($(this).val() == "all") {
                                $(this).find("option").prop("selected", true);
                            }
                        });
                    }
                });
            }

            

            function GetDetailsMonthBy() {

                var EmpName = $("#EmpDrop option:selected").val();
                var DepName = $("#DepDrop option:selected").text();
            
                if (EmpName == "select Emp" || EmpName == 0 || DepDrop == "select Empolyee") {
                    Swal.fire({
                        icon: 'info',
                        //title: 'info',
                        width: '300px',
                        text: "Please select EmpName & Dep",
                        timer: 3000
                    });
                } else {
                    alert("Kanika");
                    //GetEmployeeLeave(YearNo, MonthNo, 'NA');
                }
                // 
            }

            //update modal 
            function GetDep() {
                debugger;
                var ddlCustomers = $("[id*=EmpDrop4]");
                 ddlCustomers.empty();
                var DepName = $("#DepDrop1 option:selected").text();
              
                $.ajax({
                    type: "POST",
                    url: "AddMeeting.aspx/GetMonthWithYear",
                    data: '{DepName :  "' + DepName + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;
                        var ddlCustomers = $("[id*=EmpDrop4]");
                        ddlCustomers.empty().append('<option selected="selected" value="0">Select Empolyee</option>');
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            ddlCustomers.append($("<option></option>").val(xmlDoc[i].EmpName).html(xmlDoc[i].EmpName));
                        }                     
                        // Add an option for selecting all values
                        ddlCustomers.append('<option value="all">All</option>');
                        // Handle the "change" event of the dropdown list
                        ddlCustomers.on("change", function () {
                            if ($(this).val() == "all") {
                                $(this).find("option").prop("selected", true);
                            }
                        });
                    }
                });
            }


            function GetEMPNAME() {
                debugger;
                var DepName = $("#DepDrop").text();
                var EmpName = $("#EmpDrop").text();               
                alert(EmpName);
                if (EmpName == "select Emp" || EmpName == 0 || DepDrop == "select Empolyee") {
                    Swal.fire({
                        icon: 'info',
                        //title: 'info',
                        width: '300px',
                        text: "Please select EmpName & Dep",
                        timer: 3000
                    });
                } else {
                    alert("Kanika2");
                    //GetEmployeeLeave(YearNo, MonthNo, 'NA');
                }
                // 
            }

           
            function AddMet() {
                debugger;
              
                var MetHead= $("#MH").val();
                var Metdat = $("#MD").val();
                var Mettim = $("#MT").val();
                var Me = $("#EmpDrop option:selected").val();
                var Medep = $("#DepDrop option:selected").text();               
                var Mem = $("#MM").val();
                var Medesc = $("#MEDESC").val();
                $(".loaderbg").show();

                if (MetHead == ' ' || MetHead.length == 0 || Metdat == ' ' || Metdat.length == 0 || Mettim == ' ' || Mettim.length == 0 ||
                    Medep == ' ' || Medep.length == 0 || Me == ' ' || Me.length == 0 || Mem == ' ' || Mem.length == 0 || Medesc == ' ' || Medesc.length == 0) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'warning',
                        width: '300px',
                        text: 'all input fields required !',

                    })
                    $(".loaderbg").hide();
                }
                else {
                    var formData = new FormData();
                     formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
                    formData.append("Methead", MetHead);
                    formData.append("Metdate", Metdat);
                    formData.append("Mettime", Mettim);
                    formData.append("MetDepament", Medep);
                    formData.append("MetEmp", Me);
                    formData.append("Metmode", Mem);
                    formData.append("MetDetails", Medesc);
                    $.ajax({
                        url: 'WebServerFile/WebService.asmx/AddMeeting',
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
                                    text: 'Meeting Not Save!',
                                   // timer: 1500
                                })
                            } else {
                                $(".loaderbg").hide();
                                Swal.fire({
                                    icon: 'success',
                                    title: 'success',
                                    width: '300px',
                                    text: 'Meeting Save Success !',

                                })
                                getEvent2("NA");
                            }

                        }
                    });
                }
            }

           
            function getEvent2(Metdat) {
                $(".loaderbg").show();
                var formData = new FormData();
                formData.append("Metdate", Metdat);
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/ShowMeet',
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

                            $("#TableThead").append('  <thead> <tr> <th>S.No.</th> <th class="d-none d-xl-table-cell">Meeting Head </th> <th class="d-none d-xl-table-cell">Meeting Date </th><th class="d-none d-xl-table-cell">Meeting Time</th><th class="d-none d-xl-table-cell">Meeting Departement </th><th class="d-none d-xl-table-cell">Meeting Empolyee</th><th class="d-none d-xl-table-cell">Meeting Mode </th><th class="d-none d-xl-table-cell">Meeting Description </th>  <th class="d-none d-md-table-cell">Option </th></tr>  </thead> ');
                            // alert(data.length);
                            var j = 1;
                            for (var i = 0; i < data.length; i++) {

                                if (data[i].Type == 1) {

                                    jQuery('<tbody> <tr> <td style=" display :none;"> ' + data[i].id + '</td> <td>' + j + '</td><td>' + data[i].Methead + '</td><td>' + data[i].Metdate + '</td> <td>' + data[i].Mettime + '</td> <td>' + data[i].MetDepament + '</td><td>' + data[i].MetEmp + '</td> <td>' + data[i].Metmode + '</td><td>' + data[i].MetDetails + '</td>'
                                    + '<td><a  data-bs-toggle="tooltip" id="EditEvent"' + j + ' onclick="Editdep(' + j + ')" data-bs-placement="top" title="" data-bs-original-title="Edit"><i class="fa fa-edit"></i></a> &nbsp; &nbsp;'
                          
                                    + ' <a  id="Delete"' + j + ' onclick="Deletedep(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Delete"><i class="fa fa-trash-alt"></i></a> </td>  '

                                    + '   </tr> </tbody>').appendTo("#TableThead");

                                } else {
                                    jQuery('<tbody> <tr> <td style=" display :none;"> ' + data[i].id + '</td> <td>' + j + '</td><td>' + data[i].Methead + '</td><td>' + data[i].Metdate + '</td> <td>' + data[i].Mettime + '</td> <td>' + data[i].MetDepament + '</td><td>' + data[i].MetEmp + '</td> <td>' + data[i].Metmode + '</td><td>' + data[i].MetDetails + '</td> <td> <br/>  </td>   </tr> </tbody>').appendTo("#TableThead");

                                }
                                j++;
                            }
                        }


                    }
                });
                $(".loaderbg").hide();
            }


           
            function Editdep(j) {
                debugger;           
 
          
                $("#MYid1").val(document.getElementById("TableThead").rows[j].cells.item(0).innerText);
                $("#MH1").val(document.getElementById("TableThead").rows[j].cells.item(2).innerText);
                $("#MD1").val(document.getElementById("TableThead").rows[j].cells.item(3).innerText);
                $("#MT1").val(document.getElementById("TableThead").rows[j].cells.item(4).innerText);
                $("#DepDrop1").val(document.getElementById("TableThead").rows[j].cells.item(5).innerText);
                $("#EmpDrop4").val(document.getElementById("TableThead").rows[j].cells.item(6).innerText);                
                $("#MM1").val(document.getElementById("TableThead").rows[j].cells.item(7).innerText);
                $("#MEDESC1").val(document.getElementById("TableThead").rows[j].cells.item(8).innerText);
               // alert($("#EmpDrop1").val(document.getElementById("TableThead").rows[j].cells.item(6).innerText));
                $("#defaultModalPrimary").modal('show');
             
             
            }
            function Deletedep(id) {
                var formData = new FormData();
                formData.append("id", document.getElementById("TableThead").rows[id].cells.item(0).innerText);
                $.ajax({
                    url: 'WebServerFile/WebService.asmx/DeleteMeeting',//DeleteMeeting',
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
                                text: "Meeting Delete Success ",
                                timer: 3000
                            });
                            getEvent2("NA");
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

            function updatedep() {
                debugger;
                
                var MetHead = $("#MH1").val();
                var Metdat = $("#MD1").val();
                var Mettim = $("#MT1").val();
                var Me = $("#EmpDrop4").val();
                var Medep = $("#DepDrop1").val();
                var Mem = $("#MM1").val();
                var Medesc = $("#MEDESC1").val();             
                var id = $("#MYid1").val();
               
             
                if (MetHead == ' ' || MetHead.length == 0 || Metdat == ' ' || Metdat.length == 0 || Mettim == ' ' || Mettim.length == 0 || Mem == ' ' || Mem.length == 0 || Medesc == ' ' || Medesc.length == 0) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'warning',
                        width: '300px',
                        text: 'all input fields required !',

                    })
                
                 
                } else {
                    var formData = new FormData();
                    formData.append("id", id);                  
                    formData.append("Methead", MetHead);
                    formData.append("Metdate", Metdat);
                    formData.append("Mettime", Mettim);
                    formData.append("MetDepament", Medep);
                    formData.append("MetEmp", Me);
                    formData.append("Metmode", Mem);
                    formData.append("MetDetails", Medesc);
                    $.ajax({
                        url: 'WebServerFile/WebService.asmx/UpdateMeeting1',
                        type: 'POST',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            if (data[0].response == 'success') {
                              
                                Swal.fire({
                                    icon: 'success',
                                    width: '300px',
                                    text: "Meeting Update Success ",
                                    timer: 3000
                                });

                                getEvent2("NA");
                                $("#defaultModalPrimary").modal('hide');
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    width: '300px',
                                    text: "Meeting Not Update Success ",
                                    timer: 3000
                                });
                            }
                        }
                    });
                }
            }

            //check date
         
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <input type="text" style="display:none" id="MYid1" />
    <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3>Add New Meeting</h3>
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
                                        <h5 class="card-title mb-0">Enter Meeting Details</h5>
                                    </div>
                                    <div class="card-body">

                                        <div class="row mt-4">
                                            <div class="col-md-12">
                                                <label class="form-label">Meeting Heading*</label>
                                                <input type="text" id="MH"class="form-control">
                                            </div>
                                             
                                            <div class="col-md-6 mt-3" >
                                                <label class="form-label">Meeting Date*</label>
                                                <input type="text" id="MD"class="form-control" >
                                            </div>

                                            <div class="col-md-6 mt-3">
                                                <label class="form-label">Meeting Timimg*</label>
                                                <input type="time"  id="MT"class="form-control "/>
                                            </div>

                                            <div class="col-md-6 mt-3">
                                                <label class="form-label">Department*</label>
                                               
                                                <select id="DepDrop" class="form-select" style="border-radius: 4px;" onchange="GetDepDrop()">
                                                <option  value="">Select Department </option>                                            
                                                </select>
                                                    
                                               
                                            </div>
                                            <div class="col-md-6 mt-3">
                                                <label class="form-label">Persons</label>
                                              
                                                 <select id="EmpDrop" class="form-select" style="border-radius: 4px;" onchange="GetDetailsMonthBy()">
                                              </select>
                                            </div>

                                    
                                        <div class="col-md-6 mt-3">
                                                <label class="form-label">Meeting Mode</label>
                                                <input type="text" id="MM"class="form-control">
                                            </div>
                                        <div class="row mt-4">
                                            <div class="col-md-12">
                                                <label class="form-label">Meeting Description*</label>
                                                <input type="text" id="MEDESC"class="form-control" placeholder="Meeting Details">
                                            </div>

                                        </div>

                                        <div class="row mt-4 mb-4">
                                            <div class="col-md-12">
                                                <a href="#" id="Cm"class="btn btn-primary float-end" onclick="AddMet()"> CREATE MEETING </a>
                                            </div>

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
               
            </table>

        </div>
    </div>
     <div class="modal fade" id="defaultModalPrimary" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Default modal</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                 <div class="card-body">
                <div class="row mt-4">
                                            <div class="col-md-12">
                                                <label class="form-label">Meeting Heading*</label>
                                                <input type="text" id="MH1"class="form-control">
                                            </div>
                                             
                                            <div class="col-md-6 mt-3">
                                                <label class="form-label">Meeting Date*</label>
                                                <input type="text" id="MD1"class="form-control" >
                                            </div>

                                            <div class="col-md-6 mt-3">
                                                <label class="form-label">Meeting Timimg*</label>
                                                <input type="time"  id="MT1"class="form-control "/>
                                            </div>

                                            <div class="col-md-6 mt-3">
                                                <label class="form-label">Department*</label>
                                               
                                                <select id="DepDrop1" class="form-select" style="border-radius: 4px;" onchange="GetDep()">
                                                <option  value="">Select Department </option>                                            
                                                </select>
                                                    
                                               
                                            </div>
                                            <div class="col-md-6 mt-3">
                                                <label class="form-label">Persons</label>
                                              
                                                 <select id="EmpDrop4" class="form-select" style="border-radius: 4px;" onchange="GetEMPNAME()">
                                                     
                                              </select>
                                            </div>

                                    
                                        <div class="col-md-6 mt-3">
                                                <label class="form-label">Meeting Mode</label>
                                                <input type="text" id="MM1"class="form-control">
                                            </div>
                                        <div class="row mt-4">
                                            <div class="col-md-12">
                                                <label class="form-label">Meeting Description*</label>
                                                <input type="text" id="MEDESC1"class="form-control" placeholder="Meeting Details">
                                            </div>

                                        </div>                                  




                                    </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-primary" onclick="updatedep()">Save changes</button>
                </div>
                     </div>
            </div>
        </div>
    </div>
      
</asp:Content>

