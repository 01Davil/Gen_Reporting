<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="ProfilePage.aspx.cs" Inherits="ProfilePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3>Dashboard</h3>
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
                            <div class="col-md-4 col-xl-3">
                                <div class="card mb-3">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Profile Details</h5>
                                    </div>
                                    <div class="card-body text-center">
                                        <img src="img/av.png" alt="Stacie Hall" class="img-fluid rounded-circle mb-2" width="128" height="128" />
                                        <h5 class="card-title mb-0">Employee Name</h5>
                                        <div class="text-muted mb-2">Designation</div>

                                        <div>
                                            <a class="btn btn-primary btn-sm" href="#">Follow</a>
                                            <a class="btn btn-primary btn-sm" href="#"><span data-feather="message-square"></span> Message</a>
                                        </div>
                                    </div>
                                    <hr class="my-0" />
                                    <div class="card-body">
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
                                    </div>
                                    <hr class="my-0" />
                                    <div class="card-body">
                                        <h5 class="h6 card-title">About</h5>
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-1"><span data-feather="home" class="feather-sm me-1"></span> Lives in <a href="#">San Francisco, SA</a></li>

                                            <li class="mb-1"><span data-feather="briefcase" class="feather-sm me-1"></span> Works at <a href="#">GitHub</a></li>
                                            <li class="mb-1"><span data-feather="map-pin" class="feather-sm me-1"></span> From <a href="#">Boston</a></li>
                                        </ul>
                                    </div>
                                    <hr class="my-0" />
                                    <div class="card-body">
                                        <h5 class="h6 card-title">Elsewhere</h5>
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-1"><span class="fas fa-globe fa-fw me-1"></span> <a href="#">staciehall.co</a></li>
                                            <li class="mb-1"><span class="fab fa-twitter fa-fw me-1"></span> <a href="#">Twitter</a></li>
                                            <li class="mb-1"><span class="fab fa-facebook fa-fw me-1"></span> <a href="#">Facebook</a></li>
                                            <li class="mb-1"><span class="fab fa-instagram fa-fw me-1"></span> <a href="#">Instagram</a></li>
                                            <li class="mb-1"><span class="fab fa-linkedin fa-fw me-1"></span> <a href="#">LinkedIn</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-8 col-xl-9">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-actions float-end">
                                            
                                        </div>
                                        <h5 class="card-title mb-0">More Information</h5>
                                    </div>
                                    <div class="card-body h-100">

                                        <div class="d-flex align-items-start">
                                            <div class="flex-grow-1">
                                                <small class="float-end">Info Data</small>
                                                <strong>Information Heading</strong> Here <br />
                                                <small class="text-muted">Comment if any</small><br />

                                            </div>
                                        </div>

                                        <hr />
                                        <div class="d-flex align-items-start">
                                            <div class="flex-grow-1">
                                                <small class="float-end">Info Data</small>
                                                <strong>Information Heading</strong> Here <br />
                                                <small class="text-muted">Comment if any</small><br />

                                            </div>
                                        </div>

                                        <hr />
                                        <div class="d-flex align-items-start">
                                            <div class="flex-grow-1">
                                                <small class="float-end">Info Data</small>
                                                <strong>Information Heading</strong> Here <br />
                                                <small class="text-muted">Comment if any</small><br />

                                            </div>
                                        </div>

                                        <hr />
                                        <div class="d-flex align-items-start">
                                            <div class="flex-grow-1">
                                                <small class="float-end">Info Data</small>
                                                <strong>Information Heading</strong> Here <br />
                                                <small class="text-muted">Comment if any</small><br />

                                            </div>
                                        </div>

                                        <hr />
                                        
                                    </div>
                                </div>
                            </div>
                        </div>

</asp:Content>

