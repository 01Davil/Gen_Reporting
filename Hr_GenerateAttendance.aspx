<%@ Page Title="" Language="C#" MasterPageFile="~/HRMasterPage.master" AutoEventWireup="true" CodeFile="Hr_GenerateAttendance.aspx.cs" Inherits="Hr_GenerateAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            const monthNames = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
              ];

            const d = new Date();
            
            // Check_AttebdanceGenerated
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
           $.ajax({
               url: 'WebServerFile/Hr_MasterWebService.asmx/Check_AttebdanceGenerated',
               type: 'POST',
               data: formData,
               cache: false,
               contentType: false,
               processData: false,
               success: function (data) {
                   if (data[0].response == '1' || data[0].response == 1) {
                       $("#div2").show();
                       $("#div1").hide();
                       var a = "This '" + monthNames[d.getMonth()] + "'  month's attendance has already been generated.";
                       $("#MyText").html(a);
                   } else if (data[0].response == '2' || data[0].response == 2) {
                       $("#div2").show();
                       $("#div1").show();
                       $("#btnSave").hide();
                       $("#MyText").html("This  '" + monthNames[d.getMonth()] + " ' month attendance has been approved");
                       ShowAttendance("one");
                   }
                   else {
                       $("#div1").show();
                       $("#div2").hide();

                       ShowAttendance("one");
                   }
               }

           })
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           var input = document.getElementById('SearchText');
           input.addEventListener('keydown', function (event) {
               const key = event.key;
               if (key === "Backspace") {
                   ShowAttendance("one");

               }
           });

           $("#SearchText").keypress(function () {
               var formData = new FormData();
               formData.append("Num", $("#SearchText").val());
               $.ajax({
                   url: 'WebServerFile/Employee_MasterService.asmx/GetNameList',
                   type: 'POST',
                   data: formData,
                   cache: false,
                   contentType: false,
                   processData: false,
                   success: function (data) {
                       var ddlCustomers = $("[id*=select2]");
                       ddlCustomers.empty();
                       $.each(data, function (key, val) {
                           ddlCustomers.append('<option value= "' + val['EmpName'] + '"</option>');
                       });

                   }

               });
           });

           $('#SearchText').on('change', function () {
               if ($("#SearchText").val().length > 3) {
                   ShowAttendance($("#SearchText").val());
               }
           });

        });
       function ShowAttendance(EmpEmail) {
           var formData = new FormData();
           formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
            formData.append("EmpEmail", EmpEmail);
            $.ajax({
                url: 'WebServerFile/Hr_MasterWebService.asmx/Show_MonthlyAttendance',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    if (data[0].response == 'Fail') {

                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "No details found.",
                            timer: 3000
                        });
                    } else {
                        $("#ShowTableWork").empty();
                        var j = 1;
                        for (var i = 0; i < data.length; i++) {

                            if (data[i].TotalPresent <= "25" || data[i].TotalPresent <= 25) {

                                $("#ShowTableWork").append('<tr class="table-danger"><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TotalDay + '</td> <td>' + data[i].TotalPresent + '</td><td>' + data[i].TotalAbsent + '</td> <td>' + data[i].EL + '</td> <td>' + data[i].SL + '</td> <td>' + data[i].CL + '</td> <td>' + data[i].EM + '</td> <td>' + data[i].WFH + '</td>    </tr>')
                                //<td>' + data[i].AdjustDay + '</td>
                            } else {
                                $("#ShowTableWork").append('<tr class="table-info"><td>' + j + '</td> <td>' + data[i].EmpName + '</td>  <td>' + data[i].TotalDay + '</td> <td>' + data[i].TotalPresent + '</td><td>' + data[i].TotalAbsent + '</td> <td>' + data[i].EL + '</td> <td>' + data[i].SL + '</td> <td>' + data[i].CL + '</td> <td>' + data[i].EM + '</td> <td>' + data[i].WFH + '</td>    </tr>')

                            }
                            j++;
                        }
                    }

                }

            });
        }
        function ShowALL() {
            ShowAttendance("ALL");
        }
        function SendAttendance() {
            var formData = new FormData();
            formData.append("Sno", "<%= Session["LoginSno"].ToString()%>");
             formData.append("Data", "No");
             $.ajax({
                 url: 'WebServerFile/Hr_MasterWebService.asmx/Update_AttebdanceGenerated',
                 type: 'POST',
                 data: formData,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (data) {
                     if (data[0].response == 'Fail') {
                         Swal.fire({
                             icon: 'info',
                             width: '300px',
                             text: "No details found.",
                             timer: 3000
                         });
                     } else {
                         // Done
                         Swal.fire({
                             icon: 'success',
                             width: '300px',
                             text: "Attendance Generate  success",
                             timer: 3000
                         });
                         setTimeout(function () {
                             location.reload();
                         }, 3000);
                     }
                 }

             });
         }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <div id="div2">
        
      <div class="card flex-fill" >
        <div class="card-header" style="text-align:center; color:red;">
                   <h1 id="MyText"></h1>
              </div>
            </div>
    </div>
    <div id="div1">
      <div class="card flex-fill" >
        <div class="card-header">
            <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">GENERATE  ATTENDANCE</h5>

            <div class="input-group input-group-sm m-lg-1" style="width: 100px; float: right;">
                <a class="btn" href="#" onclick="ShowALL()">
                    <h3><i class="fa-solid fa-user-group"></i>ALL</h3>
                </a>
            </div>
            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">
                <input list="select2" type="text" id="SearchText" class="form-control" placeholder="Enter Employee Name" style="border-radius: 4px;" />
                <datalist class="MeClass" id="select2">
                </datalist>
            </div>
        </div>
        <div>
      
                  <div style="margin: 4px, 4px; padding: 4px; width: auto; height: auto; max-height: 550px; overflow-x: hidden; overflow-y: auto; text-align: justify;">
                
                      <table id="datatables-dashboard-projects" class="table table-striped my-0">
                    <thead>
                        <tr>
                            <th>S.No.</th>
                            <th class="d-none d-xl-table-cell">Employee Name</th>
                            <th class="d-none d-xl-table-cell">Total Day</th>
                            <th class="d-none d-xl-table-cell">Total Present</th>
                            <th class="d-none d-xl-table-cell">Total Absent</th>
                            <th class="d-none d-xl-table-cell">Earned Leave </th>
                            <th class="d-none d-md-table-cell">Sick Leave</th>
                            <th class="d-none d-md-table-cell">Casual Leave</th>
                            <th class="d-none d-md-table-cell">Emergency Leave</th>
                            <th class="d-none d-md-table-cell">W.F.H</th>
                            <%--<th class="d-none d-md-table-cell">Adjust Day</th>--%>
                        </tr>
                    </thead>
                    <tbody id="ShowTableWork"></tbody>
                </table>
            </div>
            <div class="input-group input-group-sm m-lg-1" style="width: 250px; float: right;">
                <a class="btn" href="#" onclick="ShowALL()">
                    <a href="#" onclick="SendAttendance()" id="btnSave" class="btn btn-warning">APPROVED ATTENDANCE</a>
                </a>
            </div>
            </div>

    </div>
  </div>

</asp:Content>

