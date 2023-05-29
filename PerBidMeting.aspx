<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="PerBidMeting.aspx.cs" Inherits="PerBidMeting" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="JsDB/jquery.js" type="text/javascript"></script>
    <script src="JsDB/popper.min.js" type="text/javascript"></script>
   <%-- <script src="JsDB/bootstrap.js" type="text/javascript"></script>--%>
    <script src="JsDB/javascript.js" type="text/javascript"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11" type="text/javascript"> </script>
     
 <script type="text/javascript">
        $(document).ready(function () {
            $("#TerName").keypress(function () {
               // debugger;
                var Name = $("#TerName").val();
                $.ajax({
                    type: "POST",
                    url: "PerBidMeting.aspx/GetNameprebidtender",
                    data: "{Name : '" + Name + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;
                        var ddlCustomers = $("[id*=student]");
                        ddlCustomers.empty();
                        $.each(xmlDoc, function (key, val) {

                            ddlCustomers.append('<option value= "' + val['TerName'] + '"</option>');
                        });

                    }
                });
            });

            $("#TerName").on('change', function () {
              //  debugger;
                var Name = $("#TerName").val();
                $.ajax({
                    type: "POST",
                    url: "PerBidMeting.aspx/PrebidtenderDetails",
                    data: "{Name : '" + Name + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        xmlDoc = r.d;

                        $("#TerName").val(xmlDoc[0].Tender_Name);
                        $("#ComName").val(xmlDoc[0].Company_Name);


                    }
                });
            });



        });           
        var Count = 1;
        var items = [];    
        $(document).ready(function () {
            $(function () {
               // debugger                

                jQuery('<tr  id="' + Count + '" class="item" style="display:table-row;"><td style="padding: 10px;"><label class="form-label ">Other Company Name</label><input type="text"  id="OtherComName1" class="form-control" /></td> &nbsp; &nbsp;'
                 + '<td style="padding: 10px;"><label class="form-label"> Other Company Query</label><input type="text" class="form-control" id="OtherComQuery1"></td> &nbsp; &nbsp;'
		         + '<td style="padding: 10px;"><label class="form-label"> Upload File</label> <input type="file" class="form-control" placeholder="" id="MyFile1"  accept=".xlsx,.xls,image/*,.doc, .docx,.ppt, .pptx,.txt,.pdf"/></td> &nbsp; &nbsp;'
               + '<td style="padding: 40px 10px 10px 10px;"><input type="button" style="visibility:hidden;"class="btn-warning removerow" value="Delete" onclick="DeleteFun(' + Count + ')" /></td> </tr>').appendTo("#MyTableList");
                items.push(Count);

                
              
            });
         
            var M=1;          
            $("#AddRow").click(function (e) {
                var table = document.getElementById("MyTableList");
                var rowCount = table.rows.length;              
                Count += 1;
             
                jQuery('<tr id="' + Count + '" class="item" style="display:table-row;"><td style="padding: 10px;"><label class="form-label">Other Company Name</label><input type="text"  id="OtherComName' + Count + '" class="form-control"/></td>&nbsp; &nbsp;'
                 + '<td style="padding: 10px;"><label class="form-label"> Other Company Query</label><input type="text" class="form-control" id="OtherComQuery' + Count + '"></td>&nbsp; &nbsp;'
		         + '<td style="padding: 10px;"><label class="form-label"> Upload File</label> <input type="file" class="form-control" placeholder="" id="MyFile' + Count + '"  accept=".xlsx,.xls,image/*,.doc, .docx,.ppt, .pptx,.txt,.pdf"/></td> &nbsp; &nbsp;'
                 + '<td style="padding: 40px 10px 10px 10px;"><input type="button" class="btn-warning removerow" value="Delete" onclick="DeleteFun(' + Count + ')" /></td> </tr>').appendTo("#MyTableList");
            
                items.push(Count);
             
               
                console.log(items);

            })




            $("#SaveBtn").click(function () {           
               // debugger;
              
                var masterKey = "";
                var Tender_Name = $("#TerName").val();
                var Company_Name = $("#ComName").val();
                var AttenderName = $("#AteenName").val();
                var Discussion = $("#Discuss").val();
                var OurQuery = $("#OQuery").val();
                var Status = $("#status").val();
                var MeetingDate = $("#meetingDate").val();
                var T_MeetingFile = $("#FileUpload")[0].files.length;

                if (Tender_Name == ' ' || Tender_Name.length == 0 || Company_Name == ' ' || Company_Name.length == 0 || MeetingDate == ' ' || MeetingDate.length == 0
                          || Discussion == ' ' || Discussion.length == 0 || AttenderName == ' ' || AttenderName.length == 0 || Status == ' ' || Status.length == 0
                    || OurQuery == ' ' || OurQuery.length == 0 || T_MeetingFile == ' ' || T_MeetingFile.length == 0 )
                {
                    Swal.fire('Please Fill All Required data');
                } else {

                                     
                    console.log(items)

                    items.forEach(function (item) {
                       
                       // alert(item);
                        var a = "#OtherComName" + item;
                        var b = "#OtherComQuery" + item;
                        var c = "#MyFile" + item;                       
                  
                   
                        if ($(a).val().length == 0 || $(a).val() == '' || $(b).val().length == 0 || $(b).val() == ' ' || $(c).val().length == 0 || $(c).val() == ' ')
                        {
                            Swal.fire('Please Put data');
                           
                        }                                                     
                            else {
                            Swal.fire({
                                title: 'Do you want to save the changes?',
                                showDenyButton: true,
                                showCancelButton: true,
                                timer: 3000,
                                confirmButtonText: 'Save',
                                denyButtonText: `Don't save`,
                            }).then((result) => {
                                /* Read more about isConfirmed, isDenied below */
                                if (result.isConfirmed) {
                                    a1();
                                    setTimeout(function () {
                                        location.reload();                                       
                                    }, 1000);
                                    Swal.fire('Saved!', '', 'success')
                                } else if (result.isDenied) {
                                    Swal.fire('Changes are not saved', '', 'info')

                                }

                            })
                            // 


                        }//else end
                        //  } //for loop end
                    });//each for loop
                         
                        //}//sucess function end
                  
                    //}); //ajax end

                    // Save Mul.. Date

                }//else end 


                /// mul
            });
        });

    

        function a1() {
          //  debugger;
            var masterKey = "";
            var Tender_Name = $("#TerName").val();
            var Company_Name = $("#ComName").val();
            var AttenderName = $("#AteenName").val();
            var Discussion = $("#Discuss").val();
            var OurQuery = $("#OQuery").val();
            var Status = $("#status").val();
            var MeetingDate = $("#meetingDate").val();
            var T_MeetingFile = $("#FileUpload")[0].files.length;

            var formData = new FormData();
            formData.append("Tender_Name", Tender_Name);
            formData.append("Company_Name", Company_Name);
            formData.append("AttenderName", AttenderName);
            formData.append("Discussion", Discussion);
            formData.append("OurQuery", OurQuery);
            formData.append("Status", Status);
            formData.append("MeetingDate", MeetingDate);
            formData.append("T_MeetingFile", $("#FileUpload")[0].files[0]);
            $.ajax({
                url: 'WebServerFile/TenderWebService.asmx/SavePreBidMeeting',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (Result) {
                    masterKey = Result;         
                    

                    items.forEach(function (item) {
                  

                        var a = "#OtherComName" + item;
                        var b = "#OtherComQuery" + item;
                        var c = "#MyFile" + item;
                       
                        var formData1 = new FormData();                        
                        formData1.append("MasterKey", masterKey);
                        formData1.append("Other_CompanyName", $(a).val());
                        formData1.append("Other_CompanyQuery", $(b).val());
                        formData1.append("File", $(c)[0].files[0]);
                         
                      
                            console.log(c);
                            console.log(formData1);

                            $.ajax({
                                url: 'WebServerFile/TenderWebService.asmx/SaveOtherCPreBidMeeting',
                                type: 'POST',
                                data: formData1,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (data) {
                                    ////                
                                    if (data[0].response == "Fail") {
                                        Swal.fire({
                                            icon: 'info',
                                            title: 'info',
                                            width: '300px',
                                            text: 'Tender Not  Apply !',
                                            timer: 1500
                                        })

                                    } else {
                                        Swal.fire({
                                            icon: 'success',
                                            width: '300px',
                                            text: "Tender bid Apply success",
                                            timer: 3000
                                        });
                                    }
                                }//success function end
                            }); //ajax end
                      //  }//for loop end
                    });
                }
            });//AJAX END
        }


        function DeleteFun(Count){
       //  debugger
         var p;
         var table = document.getElementById("MyTableList");
         var rowCount = table.rows.length;
      
        if (rowCount > 1) {         
            var p = document.getElementById(Count)
            p.remove();

            items = items.filter(item => item !== Count);

            console.log(items)
          }
      
        }

   
     
</script>


  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     
     <div class="container-fluid p-0">
                        <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3>Pre-Bid Meeting</h3>
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
                                        <h5 class="card-title mb-0">Tender Pre Bid Meeting</h5>
                                    </div>
                                    <div class="card-body">

                                        <div class="row mt-4">
                                            <div class="col-md-6">
                                                <label class="form-label">Tender Name</label>
                                                <input type="text" class="form-control" id="TerName"/>
                                                <datalist id="student"></datalist>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Company Name</label>
                                                <input type="text" class="form-control" id="ComName">
                                            </div>
                                            <div class="col-md-6 mt-4">
                                                <label class="form-label">Attender Name</label>
                                                <input type="text" class="form-control" id="AteenName">
                                            </div>
                                            <div class="col-md-6 mt-4">
                                                <label class="form-label">Discussion</label>
                                                <input type="text" class="form-control" id="Discuss">
                                            </div>
                                            <div class="col-md-6 mt-4">
                                                <label class="form-label">Our Query</label>
                                                <input type="text" class="form-control" id="OQuery">
                                            </div>
                                            <div class="col-md-6 mt-4">
                                                <label class="form-label">Status</label>
                                                <input type="text" class="form-control" id="status">
                                            </div>
                                            <div class="col-md-6 mt-4">
                                                <label class="form-label">Upload File</label>
                                                <input type="file" class="form-control" placeholder="" id="FileUpload"
                                                       accept=".xlsx,.xls,image/*,.doc, .docx,.ppt, .pptx,.txt,.pdf" multiple />
                                            </div>
                                            <div class="col-md-6 mt-4">
                                                <label class="form-label">Meeting Date</label>
                                                <input type="date" class="form-control" id="meetingDate">
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    
                          
                    <div class="row" id="datatables-dashboard-projects">
                    <div class=" col-md-12">
                        <div class="card width-100 p-2">
                            <div class="card-header">
                                <h6 class="card-title">Pre-Bid Multiple List</h6>

                            </div>
                            <table id="MyTableList">

                            </table>

                            <br>
                            <div class="row p-3" style="justify-content: space-around">
                                <div class="col-md-2 offset-md-8"  style="margin-left: 84%;">
                                    <div class="text-right mt-3 mb-3">
                                                               
                                           <button id="AddRow" type="button" class="btn btn-lg btn-primary float-end"
                                            style="width: 140px;">Add Row</button>
                                    </div>
                                    
                                </div>
                                 <div class="col-md-12 text-center mt-5">                                           

                                <button type="button" class="btn btn-lg btn-primary float-end"  id="SaveBtn">Save Pre-Bid</button>
                            </div>
                                
                            </div>

                          
                        </div>


                    </div>

                </div>                  
                        
                          

    </div>
       
     
</asp:Content>

