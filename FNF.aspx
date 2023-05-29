<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="FNF.aspx.cs" Inherits="FNF" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="JsDB/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var a;
            a = setInterval(fun, 1000);
            function fun() {
                var today = new Date();
                var now = today.toLocaleString().toUpperCase(); ;
                $(".cv").text(now);

            }
           
          

        });

        
      
      
        $(document).ready(function () {

            GetListAll();

            //search 

            $("#btnserver").click(function () {
                debugger;
                $.ajax({
                    type: "POST",
                    url: "FNF.aspx/SearchView",
                    data: '{"EmpCode":"' + $("#EmpCode").val().trim() + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.length > 0) {
                            xmlDoc = response.d;
                            $("#EmployeeTable").empty();
                            $("#EmployeeTable").append("<thead><tr> <th>S.No</th> <th >Empolyee Code</th> <th >Empolyee Name</th> <th >View</th> </tr> </thead>");
                            var j = 1;
                            for (var i = 0; i <= xmlDoc.length - 1; i++) {
                                jQuery('<tr ><td>' + j + '</td><td>' + xmlDoc[i].EmpCode + '</td> <td>' + xmlDoc[i].EmpName + '</td>    <td> <button type="button" class="btn btn-primary" style="background-color:#47336e; outline:none; border:none;" id="update' + j + ' " onclick="NextPage(' + j + ')">  F & F Print </button> </td> </tr>').appendTo("#EmployeeTable");
                                j++;
                            }
                        }
                        else {
                            $("#EmployeeTable").empty();
                            Swal.fire("Data not Found.:");
                           
                        }
                    },
                    error: function (data) {
                        Swal.fire("Get date function Error :");
                    }
                });

            });
                   
                });

        function GetListAll() {
            debugger;
         //   var EmpCode = document.getElementById("EmployeeTable").rows[j].cells.item(1).innerHTML;
            $.ajax({
                type: "POST",
                url: "FNF.aspx/SearchView2",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.length > 0) {
                        xmlDoc = response.d;
                        $("#EmployeeTable").empty();
                        $("#EmployeeTable").append("<thead><tr> <th>S.No</th><th style='Display:none'>S.NoEmp</th> <th >Empolyee Code</th> <th >Empolyee Name</th> <th >View</th> </tr> </thead>");
                        var j = 1;
                        for (var i = 0; i <= xmlDoc.length - 1; i++) {
                            jQuery('<tr ><td>' + j + '</td><td style="Display:none">' + xmlDoc[i].SNO + '</td><td>' + xmlDoc[i].EmpCode + '</td> <td>' + xmlDoc[i].EmpName + '</td>    <td> <button type="button" class="btn btn-primary" style="background-color:#47336e; outline:none; border:none;" id="update' + j + ' " onclick="NextPage(' + j + ')">  F & F Print </button> </td> </tr>').appendTo("#EmployeeTable");
                            j++;
                        }
                    }
                    else {
                        $("#EmployeeTable").empty();
                        Swal.fire("Data not Found:");
                    }
                },
                error: function (data) {
                    Swal.fire("Get date function Error :");
                }
            });
        }

        function NextPage(j) {

            var EmpCode = $("#EmpCode").val();
           window.open("Fnfview.aspx?EmpCode=" + EmpCode);

        }
        function NextPage(j) {

            var EmpCode = document.getElementById("EmployeeTable").rows[j].cells.item(1).innerHTML;
            window.open("Fnfview.aspx?EmpCode=" + EmpCode);

        }


            $(document).on("click", "#js-download", function (e) {
                e.preventDefault();
                $.ajax({
                    url: 'Fnfview/download',
                    data: $("#js-pdf-form").serialize(),
                    success: function (data) {
                        console.log(data)
                    },
                    error: function () {
                    }
                });

            });
    
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row mb-2 mb-xl-3">
        <div class="col-auto d-none d-sm-block">
            <h3>Full and Final Settlement Print</h3>
        </div>

        <div class="col-auto ms-auto text-end mt-n1">

            <div class=" me-2 d-inline-block">
                <span class="btn btn-light bg-white shadow-sm ">
                    <i class="align-middle mt-n1" data-feather="calendar"></i><strong class="cv">2022/10/12 - 12:11:47</strong>
                </span>
            </div>
        </div>
    </div>

   <div class="container-fluid p-0">
                      
                          <div class="row">
                            <div class="col-12 col-lg-15 d-flex">
                                <div class="card flex-fill w-100">
                                    <div class="card-header">

                                        <h5 class="card-title mb-0">Search to FNF</h5>
                                    </div>
                                    <div class="card-body w-100">
                                        <div class="row">
                                            <div class="col-md-10">
                                                <div class="mb-2">
                                                     <div class="form-floating mb-3">
                                                        <input type="text" id="EmpCode" class="form-control" 
                                                               placeholder="Search " required/>
                                                        <label for="floatingInput"> Emp Code / Emp Email</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <button type="button" class="btn btn-lg btn-primary" id="btnserver" style="margin-top:10px;" <i class="fa fa-search"></i> Search</button>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

         

     <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">View Updated Requisition</h5>
                            </div>
                            <div class="table-responsive">
                                <table class="table mb-0" id="EmployeeTable">
                                    <thead>
                                        <tr>
                                            <th scope="col">Sno </th>
                                            <th scope="col">Empolyee Code</th>
                                            <th scope="col">Empolyee Name</th>                                          
                                                                                   
                                            <th scope="col">View </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>  


    
  <div class="modal fade" id="ViewListModal" tabindex="-1" role="dialog" aria-hidden="true" >
                            <div class="modal-dialog modal-lg"  role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">View Material</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                  
                                    <div class="modal-body">
                                      
                                        <div class="col-12 col-xl-12">
                                       
                                            <div class="card">
                                                
                                                <div class="card-body" style="overflow:auto;">
                                                    <table id="Table1" class="table table-striped my-0 table-bordered">
                                                      
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                       <%-- </div>--%>

                                  
                                    
                                </div>
                            </div>
                        </div>


</asp:Content>

