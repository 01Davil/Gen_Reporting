<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeProfile.aspx.cs" Inherits="EmployeeProfile" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Responsive Bootstrap 5 Admin &amp; Dashboard Template">
        <meta name="author" content="Bootlab">

        <title>Employee Profile </title>
        <link rel="canonical" href="dashboard-default.html" />
        <link rel="shortcut icon" href="img/Gen.png">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&amp;display=swap" rel="stylesheet">
        <link href="css/light.css" rel="stylesheet"> 

</head>
<body>
    <form id="form1" runat="server">
     <div data-theme="dark" data-layout="fluid" data-sidebar-position="left" data-sidebar-behavior="sticky">
        <div class="wrapper">
            
            <div class="main">
                <nav class="navbar navbar-expand navbar-light navbar-bg" style="background-color: #262254 !important; color: #fff !important;">
                    <a href="#" onclick="ClosePage()" style="color: #fff; font-size: 20px; margin-right: 20px;">
                        <i class="fa fa-arrow-left"></i>
                    </a>


                    <strong class="cw">Employee Profile Page</strong>


                </nav>

                <main class="content">
                    <div class="container-fluid p-0">

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
                                                <li class="nav-item"><a class="nav-link" href="#tab-4" data-bs-toggle="tab" role="tab">Personal Details</a></li>
                                                <li class="nav-item"><a class="nav-link" href="#tab-2" data-bs-toggle="tab" role="tab">Educational Details</a></li>
                                                <li class="nav-item"><a class="nav-link" href="#tab-3" data-bs-toggle="tab" role="tab">Bank Details</a></li>
                                                <%--<li class="nav-item"><a class="nav-link" href="#tab-5" data-bs-toggle="tab" role="tab">Documents</a></li>--%>
                                                <li class="nav-item"><a class="nav-link" href="#tab-6" data-bs-toggle="tab" role="tab">Salary Details(CTC)</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane active" id="tab-1" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Employee Name</label>
                                                            <input type="text" class="form-control" id="EmpName" />
                                                        </div>
                                                        
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">File No</label>
                                                            <input type="text" class="form-control" id="Sno" disabled/>
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

                                                            <%--<select class="form-control  form-select">
                                                                <option selected="">Finance</option>
                                                                <option>Date 1</option>
                                                                <option>Date 2</option>
                                                                <option>Date 3</option>
                                                                <option>Date 4</option>
                                                            </select>--%>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Job Profile</label>
                                                            <input type="text" class="form-control" id="JobProfile" >

                                                            <%--<select class="form-control  form-select">
                                                                <option selected="">Finance</option>
                                                                <option>Date 1</option>
                                                                <option>Date 2</option>
                                                                <option>Date 3</option>
                                                                <option>Date 4</option>
                                                            </select>--%>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Date Of Joining</label>
                                                            <input type="text" class="form-control"  id="DOJ"/>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Biometric ID</label>
                                                            <input type="text" class="form-control"  id="Biometricid"/>
                                                        </div>


                                                        <div class="col-md-12">
                                                            <hr>
                                                            <%--<a href="#" class="btn btn-primary float-end" onclick="SaveProfessionalDetails()">Save</a>--%>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="tab-pane" id="tab-2" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <h4>10 (TH)</h4>
                                                        </div>
                                                        
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Board</label>
                                                            <input type="text" id="HBoard" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">School Name</label>
                                                            <input type="text" id="HName" class="form-control" >
                                                        </div>
                                                      
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Passing Year</label>
                                                            <input type="text" id="HPassingYear" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Percentage/CGPA</label>
                                                            <input type="text"id="HPercentage" class="form-control" >
                                                        </div>

                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>10+2 (TH)</h4>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Board</label>
                                                            <input type="text" id="IBoard" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">School Name</label>
                                                            <input type="text" id="IName" class="form-control" >
                                                        </div>
                                                        
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Passing Year</label>
                                                            <input type="text" id="IPassingYear" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Percentage/CGPA</label>
                                                            <input type="text"id="IPercentage" class="form-control" >
                                                        </div>
                                                     
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                                <hr>
                                                            <h4>Graduation</h4>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">University</label>
                                                            <input type="text"id="GUniversityName" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">College</label>
                                                            <input type="text"id="GCollegeName" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Stream/Branch</label>
                                                            <input type="text"id="GStreamBranch" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Passing Year</label>
                                                            <input type="text"id="GPassingYear" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Percentage/CGPA</label>
                                                            <input type="text"id="GPercentage" class="form-control" >
                                                        </div>

                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Post Graduation</h4>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">University</label>
                                                            <input type="text"id="PGUniversityName" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">College</label>
                                                            <input type="text" id="PGCollegeName" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Stream/Branch</label>
                                                            <input type="text"id="PGStreamBranch" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Passing Year</label>
                                                            <input type="text"id="PGPassingYear" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Percentage/CGPA</label>
                                                            <input type="text" id="PGPercentage" class="form-control" > 
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <%--<a href="" class="btn btn-primary float-end">Save</a>--%>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="tab-pane" id="tab-3" role="tabpanel">
                                                    <div class="row">
                                                      
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Bank Name</label>
                                                            <input type="text" id="BName" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Branch Name</label>
                                                            <input type="text"id="BRName" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Branch Code</label>
                                                            <input type="text"id="BRCode" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Branch Address</label>
                                                            <input type="text"id="BrAddress" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Account Number</label>
                                                            <input type="text"id="AccountNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">IFSC Code</label>
                                                            <input type="text"id="IFSCCode" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">CIF No.</label>
                                                            <input type="text"id="CIFNo" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <%--<a href="" class="btn btn-primary float-end">Save</a>--%>
                                                        </div>
                                                    </div>
                                                </div>


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
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <%--<a href="" class="btn btn-primary float-end">Save</a>--%>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="tab-pane" id="tab-5" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Upload Document</label>
                                                            <select class="form-control  form-select">
                                                                <option selected="">Select</option>
                                                                <option>Aadhar Card</option>
                                                                <option>PAN Card</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Upload File</label>
                                                            <input type="file" class="form-control" placeholder="">
                                                        </div>
                                                        <div class="col-md-4 mt-3 pt-1">
                                                            <button type="button" class="btn btn-primary w-100 mt-4"><i class="fa fa-download"></i> Download</button>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <a href="" class="btn btn-primary float-end">Save</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="tab-pane" id="tab-6" role="tabpanel">
                                                    <div class="row">
                                                       
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">CTC</label>
                                                            <input type="text"id="CTC" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Basic</label>
                                                            <input type="text"id="Basic" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">HRA Amount</label>
                                                            <input type="text"id="HRA" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PF_E Amount</label>
                                                            <input type="text"id="PF_E" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PF_ER Amount</label>
                                                            <input type="text"id="PF_ER" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">ESIC No.</label>
                                                            <input type="text"id="ESICNO" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">ESIC Amount</label>
                                                            <input type="text"id="ESIC_E" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">ESIC_ER Amount</label>
                                                            <input type="text"id="ESIC_ER" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Arrear Allowance</label>
                                                            <input type="text"id="ArrearAllowance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Bonus Allowance</label>
                                                            <input type="text"id="BonusAllowance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Other Allowance</label>
                                                            <input type="text"id="OtherAllowance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Other Advance Deduction</label>
                                                            <input type="text"id="OtherAdvanceDeduction" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Allowance</label>
                                                            <input type="text"id="Allowance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Extra Allowance</label>
                                                            <input type="text"id="ExtraAllowance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Medical Allowance</label>
                                                            <input type="text"id="MediAllowance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Special Allowance</label>
                                                            <input type="text"id="SpecialAllowance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Bonus</label>
                                                            <input type="text"id="Bonus" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">DA</label>
                                                            <input type="text"id="DA" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">TA</label>
                                                            <input type="text"id="TA" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Conveyance</label>
                                                            <input type="text"id="Conveyance" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">TDS</label>
                                                            <input type="text"id="TDS" class="form-control" >
                                                        </div>

                                                        
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <%--<a href="" class="btn btn-primary float-end">Save</a>--%>
                                                        </div>
                                                    </div>
                                                </div>




                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </main>

                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row text-muted">
                            <div class="col-6 text-start">
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Support</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Help Center</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Privacy</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Terms of Service</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-6 text-end">
                                <p class="mb-0">
                                    &copy; 2022 - <a href="index.html" class="text-muted">Genesis </a>
                                </p>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="js/app.js"></script>
         <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
         <script src="js/ViewProfileEmployee.js"></script>
    </div>
    </form>
</body>
</html>


