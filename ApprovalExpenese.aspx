<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ApprovalExpenese.aspx.cs" Inherits="ApprovalExpenese" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
            <script src="JsDB/jquery.js"></script>
   <script type="text/javascript">
       $(document).ready(function () {
           var a;
           a = setInterval(fun, 1000);
           function fun() {
               var today = new Date();
               var now = today.toLocaleString().toUpperCase();;
               $(".cv").text(now);

           }

           GetExpenseBill("Processing", "NA", "NA");
       });


       function GetExpenseBill(BillType, Payment, Email) {

           var formData = new FormData();
           formData.append("BillType", BillType);
           formData.append("Payment", Payment);
           formData.append("Email", Email);
           $.ajax({
               url: 'WebServerFile/WebService.asmx/ApprovelExpeneseBill',
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
                       $("#TableTbody").empty();
                   } else {
                       $("#TableTbody").empty();
                       jQuery(' <thead><tr><th>S.No.</th>  <th class="d-none d-xl-table-cell">Employee Name</th>  <th class="d-none d-xl-table-cell">Expenese Type</th><th class="d-none d-xl-table-cell">Amount</th><th class="d-none d-xl-table-cell">Purpose</th> <th class="d-none d-xl-table-cell"> Approved By</th><th class="d-none d-xl-table-cell">Payment Status</th>  <th class="d-none d-xl-table-cell">Approved / Reject Expenese </th> <th class="d-none d-xl-table-cell">Download </th></tr></thead>').appendTo("#TableTbody");
                       var j = 1;
                       for (var i = 0; i < data.length; i++) {
                           if (data[i].ApprovedStatus == "Processing") {
                               jQuery('<tbody> <td style=" display :none;"> ' + data[i].URL + '</td> <td style=" display :none;"> ' + data[i].id + '</td>'
                                + '<tr> <td>' + j + '</td><td>' + data[i].EmpName + '</td> <td>' + data[i].TypeExp + '</td><td>' + data[i].Amount + '</td> <td>' + data[i].Purpose + '</td>  <td>' + data[i].ApprovedName + '</td> <td>' + data[i].PaymentStatus + '</td>    <td> <select  class="form-control"   onchange="EmployeeFunWorking(' + data[i].id + ')" name="' + data[i].id + '" id="Drop' + data[i].id + '"> <option value="0">Select </option> <option value="Approved">Approved</option> <option value="Reject">Reject</option> </select></td> '
                                //<a herf="#" class="btn btn-sm btn-primary" onclick="UpdatePayStatus(' + data[i].id + ')">Update Payment</a> 
                              + '<td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; </td>'
                              + '</tr>  </tbody> ').appendTo("#TableTbody");

                           } else {
                               jQuery('<tbody> <td style=" display :none;"> ' + data[i].URL + '</td> <td style=" display :none;"> ' + data[i].id + '</td>'
                                   + '<tr> <td>' + j + '</td><td>' + data[i].EmpName + '</td> <td>' + data[i].TypeExp + '</td><td>' + data[i].Amount + '</td> <td>' + data[i].Purpose + '</td>  <td>' + data[i].ApprovedName + '</td> <td>' + data[i].PaymentStatus + '</td>  <td> <br/> </td>'
                                 + '<td> <a  id="Dow"' + j + ' onclick="DowFun(' + j + ')"  data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>    &nbsp; &nbsp; </td>'
                                 + '</tr>  </tbody> ').appendTo("#TableTbody");
                           }
                           j++;
                       }
                   }
               }
           });
       }
       function DowFun(j) {
           var x = document.getElementById("TableTbody").rows[j].cells.item(0).innerText;
           // alert(x + " ," + j);
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

       function SearchBtn() {
           var BillType = $("#BillType option:selected").val();
           var PaymentType = $("#PaymentType option:selected").val();
           var Name = $("#SearchText").val();
           if (Name == "" || Name.length == 0) {
               GetExpenseBill(BillType, PaymentType, "NA");
           } else {
               GetExpenseBill(BillType, PaymentType, Name)
           }
       }

       function EmployeeFunWorking(id) {
           var a = "#Drop" + id;
           var Status = $("  " + a + " option:selected").val().trim();
           //            alert(id + " " + Status);
           if (Status == 0 || status == '0') {
               //
               Swal.fire({
                   icon: 'info',
                   //title: 'info',
                   width: '300px',
                   text: "Please Select a valid option",
                   timer: 3000
               });
           } else {
               // update 
               var formData = new FormData();
               formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
               formData.append("Name", "<%= Session["LoginName"].ToString()%>");
               formData.append("Id", id);
               formData.append("Status", Status);
               // 
               $.ajax({
                   url: 'WebServerFile/WebService.asmx/ApprovedStatusExpenese',
                   type: 'POST',
                   data: formData,
                   cache: false,
                   contentType: false,
                   processData: false,
                   success: function (data) {
                       if (data = "Save") {
                           Swal.fire({
                               icon: 'success',
                               //title: 'info',
                               width: '300px',
                               text: " Leave Update success",
                               timer: 3000
                           });
                           GetDefalutLeave("NA", "NA", $("#dd option:selected").val());
                       } else {
                           Swal.fire({
                               icon: 'info',
                               //title: 'info',
                               width: '300px',
                               text: " Leave Not Update",
                               timer: 3000
                           });
                       }
                   },
                   xhr: function () {
                       var fileXhr = $.ajaxSettings.xhr();
                       if (fileXhr.upload) {

                       }
                       return fileXhr;
                   }

               });
           }
       }
           </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>APPROVAL EXPENESE</h3>
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
      <br />
            </div>

            <div class="card-body">

                <div class="row mt-4">
                    <div class="col-md-3">
               
                        <select id="BillType" class="form-select mb-3" style="border-radius: 4px;" title="Type of Expenese Bill">
                            <option selected value="Processing">Pending</option>
                            <option  value="Approved">Approved</option>
                            <option value="Reject">Reject</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                             <select id="PaymentType" class="form-select mb-3" style="border-radius: 4px;"  title="Type of Payment ">
                            <option selected value="NA">ALL</option>
                            <option  value="Done">Paid Bill</option>
                            <option value="Processing">Pending Bill</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                        <datalist class="MeClass" id="select2">
                        </datalist>
                    </div>
                    
                    <div class="col-md-3">
                        <a href="#" class="btn btn-primary float-center" onclick="SearchBtn()"><i class="fa fa-file-excel"></i>  Search... </a>

                    </div>

                </div>
            </div>
        </div>

       <div class="card flex-fill">

            <div class="card-header">
                <h5 id="ShowLeaveType" class="card-title mb-0" style="display: block; width: 240px; float: left;">Expenese List</h5>
       
            </div>
            <table id="TableTbody" class="table table-striped my-0 text-center">
      
            </table>
        </div>
</asp:Content>

