<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="ShowHoliList.aspx.cs" Inherits="ShowHoliList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
         <script src="PdfJS/html2canvas.min.js"></script>
<script src="PdfJS/html2pdf.min.js"></script>
<script src="PdfJS/jquery.min.js"></script>
<script src="PdfJS/jspdf.debug.js"></script>
    

    <script>
        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                         var now = today.toLocaleString().toUpperCase();;
                $(".cv").text(now);

            }
            // 
            $(function () {
                var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("Type", "All");
                  $.ajax({
                      url: 'WebServerFile/Employee_MasterService.asmx/Get_HolidayList',
                      type: 'POST',
                      data: formData,
                      cache: false,
                      contentType: false,
                      processData: false,
                      success: function (data) {
                          if (data[0].response == "Fail") {
                            $("#holidayListTbl1").empty();                              
                              var List  = "<tr> <td> <strong> No Holiday </strong>  </td> </tr>"
                              $("#holidayListTbl1").append(List);
                          } else {
                              var j = 1;
                              var List1;                              
                                for (var i = 0; i < data.length; i++) {                                    


                                        if (data[i].Type == 0 || data[i].Type == '0') {

                                            List3 = "<tr class='table-danger'> <td> " + j + "  </td>  <td> " + data[i].HoliName + "  </td>  <td class='text-center'> " + data[i].HoliDate + " </td>  </tr> </br>";
                                            $("#holidayListTbl1").append(List3);
                                        } else if (data[i].Type == 1 || data[i].Type == '1') {

                                            List5 = "<tr class='table-success'> <td> " + j + "  </td>  <td> " + data[i].HoliName + "  </td>  <td class='text-center'> " + data[i].HoliDate + " </td>  </tr>  </br> ";
                                            $("#holidayListTbl1").append(List5);
                                        } else {

                                            List4 = "<tr class='table-primary'> <td> " + j + "  </td>  <td> " + data[i].HoliName + "  </td>  <td class='text-center'> " + data[i].HoliDate + " </td>   </tr>  </br>";
                                            $("#holidayListTbl1").append(List4);
                                        }

                                        j++;
                                    }
                                    //List3 = "<tr> <td> "+data[i].HoliName+"  </td>  <td class='text-end text-success'> "+data[i].HoliDate+" </td>  </tr> " ;
                                    //$("#holidayListTbl1").append(List3);
                                    //j++;
                                // end for loop                      
                              // App
                          }
                      }
                  })
            });
        });
                <%--var formData = new FormData();
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
                                   //+ '<small class="text-muted" id="Name3">' + data[i].LocationName + '</small><br />'
                                   + '</div> </div><hr />';

                                   $('#divHoliday').append(hello);
                               }
                           }

                       })
            })--%>
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Holiday List </h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                
                 <button class="btn btn-sm btn-primary float-end 0 m-1" id="generatePDF" type="submit"><i class="fa fa-print"></i>  Download  </button>

                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>

            </div>
        </div>
    </div>

      <div class="col-12  d-flex">
            <div class="card flex-fill w-100">
               
              <div class="card-body" style="overflow-y: auto !important;" id="divHoliday">
                   <table class="table mb-0 mt-1">
                        <thead>
                            <tr>
                                <th>SNO</th>
                                <th >Occasion</th>
                                <th class="text-center">Date</th>
                            </tr>
                        </thead>
                        <tbody id="holidayListTbl1">                                
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


     <script type="text/javascript">
     
     var dateObj = new Date();
     var year = dateObj.getUTCFullYear();

     newdate ="HoliList"+"_" + year+".pdf";
    

    const options = {
      margin: 0,
      filename: newdate,    
      image: { 
        type: 'pdf', 
        quality: 100
      },
      html2canvas: { 
        scale: 1 
      },
      jsPDF: { 
        unit: 'in', 
        format: 'a4',
         orientation: 'portrait'
      }
    }
    
    $('#generatePDF').click(function (e) {   
      e.preventDefault();
      const element = document.getElementById('divHoliday');
      html2pdf().from(element).set(options).save();
    });
  
    </script>
</asp:Content>

