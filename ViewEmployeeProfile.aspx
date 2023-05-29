<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewEmployeeProfile.aspx.cs" Inherits="ViewEmployeeProfile" %>

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


                    <div class="navbar-collapse collapse">
                        <ul class="navbar-nav navbar-align">

                            

                            <li class="nav-item dropdown">
                                <a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
                                    <i class="align-middle" data-feather="settings"></i>
                                </a>

                                <a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                                    <img src="img/av.png" class="avatar img-fluid rounded-circle me-1" alt="" /> <span class="cw">User Name</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end">
                                    <a class="dropdown-item" href="pages-profile.html"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="pages-settings.html">Settings & Privacy</a>
                                    <a class="dropdown-item" href="#">Help</a>
                                    <a class="dropdown-item" href="#">Sign out</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>

                <main class="content">
                    <div class="container-fluid p-0">

                        <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3>Employee Details</h3>
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
                                        <img src="img/av.png" id="image1" alt="Stacie Hall" class="img-fluid rounded-circle mb-2" width="128" height="128" />
                                        <h5 class="card-title mb-0" id="EmpName1">Employee Name</h5>
                                        <div class="text-muted mb-2" id="JobProfile1">Designation</div>

                                        <div>
                                            <%--<a class="btn btn-primary btn-sm" href="#">Edit Image</a>--%>
                                            <input type="file"  id="EmpImage" class="form-control btn-sm"  accept=".png, .jpg, .jpeg" onchange="UpdateImage()" />
                                        </div>
                                    </div>
                                    <hr class="my-0" />
                                    <%--<div class="card-body">
                                        <h5 class="h6 card-title">Skills</h5>
                                        <a href="#" class="badge bg-primary me-1 my-1">HTML</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">JavaScript</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">Sass</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">Angular</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">Vue</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">React</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">Redux</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">UI</a>
                                        <a href="#" class="badge bg-primary me-1 my-1">UX</a>
                                    </div>--%>
                                    <hr class="my-0" />
                                    <div class="card-body">
                                        <h5 class="h6 card-title">About</h5>
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-1"><span data-feather="home" class="feather-sm me-1"></span> Lives in <a href="#">San Francisco, SA</a></li>

                                            <li class="mb-1"><span data-feather="briefcase" class="feather-sm me-1"></span> Works at <a href="#">GitHub</a></li>
                                            <li class="mb-1"><span data-feather="map-pin" class="feather-sm me-1"></span> From <a href="#">Boston</a></li>
                                        </ul>
                                    </div>

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
                                                <li class="nav-item"><a class="nav-link" href="#tab-2" data-bs-toggle="tab" role="tab">Educational Details</a></li>
                                                <li class="nav-item"><a class="nav-link" href="#tab-3" data-bs-toggle="tab" role="tab">Bank Details</a></li>
                                                <li class="nav-item"><a class="nav-link" href="#tab-4" data-bs-toggle="tab" role="tab">Personal Details</a></li>
                                                <li class="nav-item"><a class="nav-link" href="#tab-5" data-bs-toggle="tab" role="tab">Documents</a></li>
                                                <li class="nav-item"><a class="nav-link" href="#tab-6" data-bs-toggle="tab" role="tab">Salary details</a></li>
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

                                                           <%-- <select class="form-control form-select">
                                                                <option selected="">Genesis</option>
                                                                <option>Date 1</option>
                                                                <option>Date 2</option>
                                                                <option>Date 3</option>
                                                                <option>Date 4</option>
                                                            </select>--%>
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
                                                            <input type="date" class="form-control"  id="DOJ"/>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <hr>
                                                            <a href="#" class="btn btn-primary float-end" onclick="SaveProfessionalDetails()">Save</a>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="tab-pane" id="tab-2" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <h4>Graduation</h4>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">University</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">College</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Stream/Branch</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Passing Year</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Percentage/CGPA</label>
                                                            <input type="text" class="form-control" >
                                                        </div>

                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Post Graduation</h4>
                                                        </div>

                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">University</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">College</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Stream/Branch</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Passing Year</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Percentage/CGPA</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <a href="" class="btn btn-primary float-end">Save</a>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="tab-pane" id="tab-3" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Account Holder Name</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Bank Name</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Branch Name</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Branch Code</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Branch Address</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Account Number</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">IFSC Code</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">CIF No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <a href="" class="btn btn-primary float-end">Save</a>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="tab-pane" id="tab-4" role="tabpanel">
                                                    <div class="row">
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Date Of Birth</label>
                                                            <input type="date" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Contact No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Alternate Contact No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Personal Email</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Gender</label>
                                                            <select class="form-control  form-select">
                                                                <option selected="">Male</option>
                                                                <option>Female</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Blood Group</label>
                                                            <select class="form-control  form-select">
                                                                <option selected="">A+</option>
                                                                <option>B+</option>
                                                                <option>AB+</option>
                                                                <option>O+</option>
                                                                <option>O-</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Marital Status</label>
                                                            <select class="form-control  form-select">
                                                                <option selected="">Married</option>
                                                                <option>Unmarried</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Emergency Contact</h4>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Name</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Relation</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Contact No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Address</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Family Details</h4>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Father's Name</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Father's Contact No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Mother's Name</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Mother's Contact No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <h4>Address</h4>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">State</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">District</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">City</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Aadhar Card No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PAN Card No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Driving Licence No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Current Address</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Permanent Address</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PIN Code</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <a href="" class="btn btn-primary float-end">Save</a>
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
                                                            <label class="form-label">Emp. ID</label>
                                                            <input type="text" class="form-control" disabled>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Emp. Code</label>
                                                            <input type="text" class="form-control"  disabled>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Emp. Name</label>
                                                            <input type="text" class="form-control"  disabled>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Father's Name</label>
                                                            <input type="text" class="form-control"  disabled>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Mother's Name</label>
                                                            <input type="text" class="form-control"  disabled>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Department</label>
                                                            <input type="text" class="form-control"  disabled>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Job Profile</label>
                                                            <input type="text" class="form-control"  disabled>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">CTC</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Basic</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">HRA Amount</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PF_E Amount</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">PF_ER Amount</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">ESIC No.</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">ESIC Amount</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">ESIC_ER Amount</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Arrear Allowance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Bonus Allowance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Other Allowance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Other Advance Deduction</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Allowance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Extra Allowance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Medical Allowance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Special Allowance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Bonus</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">DA</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">TA</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">Conveyance</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-4 mt-3">
                                                            <label class="form-label">TDS</label>
                                                            <input type="text" class="form-control" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <hr>
                                                            <a href="" class="btn btn-primary float-end">Save</a>
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
