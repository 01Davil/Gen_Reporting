<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="AddTender.aspx.cs" Inherits="AddTender" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="JsDB/jquery.js" type="text/javascript"></script>
    <script src="JsDB/popper.min.js" type="text/javascript"></script>
   <%-- <script src="JsDB/bootstrap.js" type="text/javascript"></script>--%>
    <script src="JsDB/javascript.js" type="text/javascript"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js" type="text/javascript"></script>
    <style>
        /*  timepicker CSS */
        .ui-timepicker-container {
            position: absolute;
            overflow: hidden;
            box-sizing: border-box;
        }

        .ui-timepicker {
            box-sizing: content-box;
            display: block;
            height: 205px;
            list-style: none outside none;
            margin: 0;
            padding: 0 1px;
            text-align: center;
        }

        .ui-timepicker-viewport {
            box-sizing: content-box;
            display: block;
            height: 205px;
            margin: 0;
            padding: 0;
            overflow: auto;
            overflow-x: hidden;
            /* IE */
        }

        .ui-timepicker-standard {
            /* overwrites .ui-widget */
            font-family: Verdana, Arial, sans-serif;
            font-size: 1.1em;
            /* overwrites .ui-widget-content */
            background-color: #808080;
            /*  border: 1px solid #808080;*/
            color: #fff;
            /* overwrites .ui-menu */
            margin: 0;
            padding: 2px;
        }

            .ui-timepicker-standard a {
                /*  border: 1px solid transparent;*/
                color: #000;
                display: block;
                padding: 0.2em 0.4em;
                text-decoration: none;
                background-color: #fff;
            }

            .ui-timepicker-standard .ui-state-hover {
                /* overwrites .ui-state-hover */
                background-color: #e4e2fe;
                font-weight: normal;
                color: #000;
            }

            .ui-timepicker-standard .ui-menu-item {
                /* overwrites .ui-menu and .ui-menu-item */
                /*clear: left;
    float: left;*/
                margin: 0;
                padding: 0;
            }

        .ui-timepicker-corners,
        .ui-timepicker-corners .ui-corner-all {
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            border-radius: 4px;
        }

        .ui-timepicker-hidden {
            /* overwrites .ui-helper-hidden */
            display: none;
        }

        .ui-timepicker-no-scrollbar .ui-timepicker {
            border: none;
        }

        /* layout */
        body {
            background-color: #4e4e4e;
        }

        p {
            color: #fff;
            font-size: 20px;
        }

        input {
            height: 30px;
            margin-right: 50px;
            outline: none;
            background-color: #121528;
            border: 1px solid #00c768;
            border-radius: 5px;
            color: #fff;
            padding-left: 12px;
        }

        .timepicker {
            width: 200px;
        }

        .inputGroup {
            display: flex;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
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

        });
       
        $(document).ready(function () {
            $(function() {
                $('.single_cal4').daterangepicker({
                    timePicker : true,
                    singleDatePicker:true,
                    timePicker24Hour : false,
                    timePickerIncrement : 1,
                    timePickerSeconds : false,
                    locale : {
                        format : 'hh:mm A', // added A for AM/PM
                        meridiem: ['AM', 'PM'] // specify AM/PM strings
                    }
                }).on('show.daterangepicker', function(ev, picker) {
                    picker.container.find(".calendar-table").hide();
                });
            })
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
        var Count = 1;
        var items = [];
        $(document).ready(function () {
            $(function () {
              //  debugger            

                jQuery('<tr id="' + Count + '" class="item"><td style="padding: 5px;"><label class="form-label mt-3"> Upload File</label> <input type="file" class="form-control" placeholder="" id="MyFile1" accept=".xlsx,.xls,image/*,.doc, .docx,.ppt, .pptx,.txt,.pdf"/></td>'
                  + '<td style="padding: 50px 10px 10px 10px;"><input type="button" style="visibility:hidden;"class="btn-warning removerow" value="Delete" onclick="DeleteFun2(' + Count + ')" /></td> </tr>').appendTo("#MyTableList2");
                items.push(Count);
            });
        
            var M2 = 1;
          
            $("#AddRow2").click(function (e) {
                var table = document.getElementById("MyTableList2");
                var rowCount = table.rows.length;
                Count += 1;
                jQuery('<tr id="' + Count + '" class="item"><td style="padding: 5px;"><label class="form-label mt-3"> Upload File</label> <input type="file" class="form-control" placeholder="" id="MyFile' + Count + '" accept=".xlsx,.xls,image/*,.doc, .docx,.ppt,.pptx,.txt,.pdf"/ ></td>'
                      + '<td style="padding: 50px 10px 10px 10px;"><input type="button" class="btn-warning removerow" value="Delete" onclick="DeleteFun2(' + Count + ')" /></td> </tr>').appendTo("#MyTableList2");
                items.push(Count);
                console.log(items);
            })





            $("#SaveBtn2").click(function () {

               // debugger;               
                var masterKey2 = "";
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
                  

                         
                    console.log(items)

                    items.forEach(function (item) {

                        var a = "#MyFile" +item;

                         if ($(a).val().length == 0 || $(a).val() == '') {
                             Swal.fire('please put data')
                             //return false;
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
                                     A2();
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
                   
      
      


        function A2() {
           // debugger;
            var masterKey2 = "";
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

            var formData = new FormData();
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
            $.ajax({
                url: 'WebServerFile/TenderWebService.asmx/SaveTender',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (Result) {
                    masterKey2 = Result;

              items.forEach(function (item) {
                var a = "#MyFile" + item;
            
                var formData1 = new FormData();           
                formData1.append("Result", masterKey2);
                formData1.append("File", $(a)[0].files[0]);
                console.log(formData1);
                $.ajax({
                    url: 'WebServerFile/TenderWebService.asmx/Tenderuploadfile',
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

        function DeleteFun2(Count) {
           // debugger
            var p;
            var table = document.getElementById("MyTableList2");
            var rowCount = table.rows.length;

            if (rowCount > 1) {
                var p = document.getElementById(Count)
                p.remove();

                items = items.filter(item => item !== Count);

                console.log(items)
            }

        }


        function CheckAvailability() {
            //debugger;
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

       <div class="row" id="datatables-dashboard-projects">
            <div class=" col-md-12">
                <div class="card width-100 p-2">
                    <div class="card-header">
                        <h6 class="card-title">Upload file</h6>
                    </div>
                    <table id="MyTableList2">

                    </table>
                    <div class="row mb-2 mt-2">
                        <div class="offset-md-6 col-md-2" style="margin-left: 83%;">
                            <div>
                                <button id="AddRow2" type="button" class="btn btn-lg btn-primary float-end"
                                    style="width: 130px;">
                                    Add Row</button>
                            </div>

                        </div>
                        <div class="col-md-12 mt-4 pt-1">
                            <button type="button" id="SaveBtn2" class="btn btn-lg btn-primary float-end">
                                Save Tender
                            </button>
                        </div>
                    </div>
                     

                </div>


            </div>

 </div>

         
</asp:Content>

