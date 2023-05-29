<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGen.master" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script src="JsDB/jquery.js"></script>

<script>
    $(document).ready(function () {

            var formData = new FormData();
            formData.append("Sno",  "<%= Session["LoginSno"].ToString()%>");
            jQuery.ajax({
                url: 'WebServerFile/Hr_MasterWebService.asmx/GetEmployeeFullDetails',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (date) {
                    if (date[0].response == 'Fail') {
                        Swal.fire({
                            icon: 'info',
                            width: '300px',
                            text: "No details found.",
                            timer: 3000
                        });

                    } else {

                        if (date[0].Image == "NA") {

                            $('#image1').attr('src', "img/av.png");
                        } else {
                            $('#image1').attr('src', date[0].Image);
                        }
                        $("#EmpName").val(date[0].EmpName);
                        $("#EmpName1").html(date[0].EmpName);
                        $("#EmpCode").val(date[0].EmpCode);
                        $("#officialEmail").val(date[0].officeEmail);
                        $("#Branch").val(date[0].Branch);
                        $("#Biometricid").val(date[0].Biometricid);
                        $("#Sno").val(date[0].Sno);
                        $("#Department").val(date[0].Department);
                        $("#JobProfile").val(date[0].JobProfile);
                        $("#JobProfile1").html(date[0].JobProfile);
                        $("#DOB").val(date[0].DOB1);
                        $("#DOJ").val(date[0].DOJ1);
                        $("#Contact").val(date[0].Mobile);
                        $("#AlterContactNo").val(date[0].AlterContactNo);
                        $("#PersonalEmail").val(date[0].Email);
                        $("#Gender").val(date[0].Gender);
                        $("#BloodGroup").val(date[0].BloodGroup);
                        $("#Married").val(date[0].Married);
                        $("#EmerName").val(date[0].EmerName);
                        $("#EmerRealtion").val(date[0].EmerRealtion);
                        $("#EmerContNo").val(date[0].EmerContNo);
                        $("#EmerAddress").val(date[0].EmerAddress);
                        $("#Fname").val(date[0].Fname);
                        $("#Mname").val(date[0].Mname);
                        $("#FContactNo").val(date[0].FContactNo);
                        $("#MConatctNo").val(date[0].MConatctNo);
                        $("#SelectState").val(date[0].SelectState);
                        $("#SelectDistrict").val(date[0].SelectDistrict);
                        $("#City").val(date[0].City);
                        $("#AdharNo").val(date[0].AdharNo);
                        $("#PanNo").val(date[0].PanNo);
                        $("#DrivingLicenceNo").val(date[0].DrivingLicenceNo);
                        $("#LocalAddress").val(date[0].LocalAddress);
                        $("#PermanentAddress").val(date[0].PermanentAddress);
                        $("#PinCode").val(date[0].PinCode);
                        ////////////////////////////////////////////////
                
                    }
                },
                error: function (sd) {
                    // alert("fail");
                }
            });

    });

    function UpdateImage() {
     //   debugger;
        var formData = new FormData();
        formData.append("Slip", $("#EmpImage")[0].files[0]);
        formData.append("Sno",  "<%= Session["LoginSno"].ToString()%>");
        $.ajax({
            url: 'WebServerFile/Hr_MasterWebService.asmx/UpdateImageEmp',
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (Result) {
              //  alert(Result);
                if (Result == 'Save') {
                    Swal.fire({
                        icon: 'success',
                        width: '300px',
                        text: "Image Update"
                    });
                    setTimeout(function () {
                        location.replace("MyProfile.aspx");
                    }, 2000);
                } else {
                    Swal.fire({
                        icon: 'info',
                        width: '300px',
                        text: "Image  Not Update"

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

    function SaveProfessionalDetails (){

        var oldpass= $("#oldpass").val().trim();
        var newPassword =$("#newPassword").val().trim();
        var Cpassword= $("#Cpassword").val().trim();

        if (oldpass == " " || oldpass.length == 0 || newPassword == " " || newPassword.length == 0 || Cpassword == " " || Cpassword.length == 0) {
            Swal.fire({
                icon: 'warning',
                width: '300px',
                text: "Please enter your Old Password and password",
                timer: 3000
            });
        } else {

            if (newPassword == Cpassword) {
                  var formData = new FormData();
        formData.append("Sno",  "<%= Session["LoginSno"].ToString()%>");
        formData.append("oldpass",oldpass);
        formData.append("newPassword", newPassword);
        $.ajax({
            url: 'WebServerFile/WebService.asmx/ChangePasssword',
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                
                if (data[0].response == '1' || data[0].response == 1) {
                    Swal.fire({
                        icon: 'warning',
                        width: '300px',
                        text: "old password doesn't match"
                    });
                } else 
                {
                  
                    Swal.fire({
                        icon: 'success',
                        width: '300px',
                        text: "Password Change success",
                        timer: 3000
                    });

                ///
                }
          
            },
            xhr: function () {
                var fileXhr = $.ajaxSettings.xhr();
                if (fileXhr.upload) {

                }
                return fileXhr;
            }
        });
            } else {
                Swal.fire({
                    icon: 'warning',
                    width: '300px',
                    text: "The password and confirmation password do not match.",
                    timer: 3000
                });
            }
        }
        

    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                
                            </div>

                            <div class="col-auto ms-auto text-end mt-n1">

                                <div class=" me-2 d-inline-block">
                                    <span class="btn btn-light bg-white shadow-sm " >
                                        <i class="align-middle mt-n1" data-feather="calendar"></i> <strong class="cv">2022/10/12 - 12:11:47</strong>
                                    </span>
                                </div>

                                <button class="btn btn-primary shadow-sm">
                                    <i class="align-middle" data-feather="refresh-cw">&nbsp;</i>
                                </button>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-4 col-xl-3 h-100">
                                <div class="card mb-3">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Profile Details</h5>
                                    </div>
                                    <div class="card-body text-center">
                                        <img src="img/av.png" id="image1" alt="Stacie Hall" class="img-fluid rounded-circle mb-2" width="128px" height="128px" />
                                        <br />
                                        <br />
                                        <h5 class="card-title mb-0" id="EmpName1">Employee Name</h5>
                                        <br />
                                        <br />

                                        <div class="text-muted mb-2" id="JobProfile1">Designation</div>

                                        <div>
                                            <%--<a class="btn btn-primary btn-sm" href="#">Edit Image</a>--%>
                                            <input type="file"  id="EmpImage" class="form-control btn-sm"  accept=".png, .jpg, .jpeg" onchange="UpdateImage()" />
                                        </div>
                                    </div>
                                    <hr class="my-0" />
                            
                                    <hr class="my-0" />
                            

                                </div>
                            </div>

                            <div class="col-md-8 col-xl-9 h-100">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-actions float-end">

                                        </div>
                                        <h5 class="card-title mb-0">Employee Details</h5>
                                    </div>
                                    <div class="card-body h-100 p-0 pb-0">
                                        <div class="tab">
                                            <ul class="nav nav-tabs" role="tablist">
                                                <li class="nav-item"><a class="nav-link active" href="#tab-1" data-bs-toggle="tab" role="tab">Professional Details</a></li>
                                                <%--<li class="nav-item"><a class="nav-link" href="#tab-4" data-bs-toggle="tab" role="tab">Personal Details</a></li>--%>
                                              <li class="nav-item"><a class="nav-link" href="#tab-2" data-bs-toggle="tab" role="tab">Setting</a></li>
                                    
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane active" id="tab-1" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Employee Name</label>
                                                            <input type="text" class="form-control" id="EmpName" />
                                                        </div>
                                                
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Employee Code</label>
                                                            <input type="text" class="form-control" id="EmpCode" disabled />
                                                        </div>
                                                        
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Official Email</label>
                                                            <input type="text" class="form-control" id="officialEmail" />
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Branch</label>
                                                            <input type="text" class="form-control" id="Branch" />

                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Department</label>
                                                            <input type="text" class="form-control" id="Department"/ >

                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Job Profile</label>
                                                            <input type="text" class="form-control" id="JobProfile" >

                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Date Of Joining</label>
                                                            <input type="text" class="form-control"  id="DOJ"/>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Biometric ID</label>
                                                            <input type="text" class="form-control"  id="Biometricid"/>
                                                        </div>


                                                    </div>
                                                </div>
                                                <%--  --%>
                                                <div class="tab-pane" id="tab-4" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Date Of Birth</label>
                                                            <input type="text" id="DOB" class="form-control"/>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Contact No.</label>
                                                            <input type="text" id="Contact" class="form-control"/>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Alternate Contact No.</label>
                                                            <input type="text" id="AlterContactNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Personal Email</label>
                                                            <input type="text" id="PersonalEmail" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Gender</label>
                                                            <input type="text" id="Gender" class="form-control" >

                                                           <%-- <select class="form-control  form-select">
                                                                <option selected="">Male</option>
                                                                <option>Female</option>
                                                            </select>--%>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Blood Group</label>
                                                          <input type="text" id="BloodGroup" class="form-control" >

                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Marital Status</label>
                                                            
                                                          <input type="text" id="Married" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Emergency Contact</h4>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Name</label>
                                                            <input type="text"  id="EmerName" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Relation</label>
                                                            <input type="text"  id="EmerRealtion" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Contact No.</label>
                                                            <input type="text" id="EmerContNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Address</label>
                                                            <input type="text" id="EmerAddress" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Family Details</h4>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Father's Name</label>
                                                            <input type="text" id="Fname" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Father's Contact No.</label>
                                                            <input type="text" id="FContactNo"  class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Mother's Name</label>
                                                            <input type="text" id="Mname" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Mother's Contact No.</label>
                                                            <input type="text"  id="MConatctNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Address</h4>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">State</label>
                                                            <input type="text"  id="SelectState"  class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">District</label>
                                                            <input type="text" id="SelectDistrict" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">City</label>
                                                            <input type="text" id="City" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Aadhar Card No.</label>
                                                            <input type="text" id="AdharNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PAN Card No.</label>
                                                            <input type="text" id="PanNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Driving Licence No.</label>
                                                            <input type="text" id="DrivingLicenceNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Current Address</label>
                                                            <input type="text" id="LocalAddress" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Permanent Address</label>
                                                            <input type="text" id="PermanentAddress" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PIN Code</label>
                                                            <input type="text" id="PinCode" class="form-control" >
                                                        </div>
                                                  
                                                    </div>
                                                </div>

                                                <%--  --%>
                                                <div class="tab-pane" id="tab-2" role="tabpanel">
                                                    
                                                    <div class="row">
                                                       
                                                         <div class="col-md-12">
                                                            <h4>Change Password </h4>
                                                        </div>
                                                        
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Old Paasword</label>
                                                            <input type="text" id="oldpass" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Enter New Password</label>
                                                            <input type="password" id="newPassword" class="form-control" >
                                                        </div>
                                                      
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">ReEnter Password</label>
                                                            <input type="password" id="Cpassword" class="form-control" >
                                                        </div>
                                                   
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <a href="#" class="btn btn-primary float-end" onclick="SaveProfessionalDetails()">Save Change</a>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
</asp:Content>

