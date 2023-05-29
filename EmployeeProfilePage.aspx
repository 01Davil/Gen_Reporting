<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeProfilePage.aspx.cs" Inherits="EmployeeProfilePage" %>

<html lang="en">

    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Responsive Bootstrap 5 Admin &amp; Dashboard Template">
        <meta name="author" content="Bootlab">

        <title>GenReporting HR Dashboard</title>
        <link rel="shortcut icon" href="img/Gen.png"/>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&amp;display=swap" rel="stylesheet"/>
        <link href="css/light.css" rel="stylesheet"/> 

    </head>

    <body data-theme="dark" data-layout="fluid" data-sidebar-position="left" data-sidebar-behavior="sticky">
        <div class="wrapper">
            <nav id="sidebar" class="sidebar">
                <div class="sidebar-content js-simplebar" style="background: linear-gradient(121deg, rgba(96, 86, 255, 1) 0%, rgba(120, 112, 251, 1) 100%) !important;">
                    <a class="sidebar-brand" href="index.html">
                        <img src="img/Gen.png" style="width: 50px;">


                        <span class="align-middle me-3">GenReporting</span>
                    </a>

                    <ul class="sidebar-nav">
                        <li class="sidebar-header">
                            MENU
                        </li>
                        <li class="sidebar-item active">
                            <a href="dashboard.html"  class="sidebar-link">
                                <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">DASHBOARD</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#pages" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="layout"></i> <span class="align-middle">RECRUITMENT</span>
                            </a>
                            <ul id="pages" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="">Offer Letter</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="">Joining Letter</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="">Boimetric</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="">Existing Employee</a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a href="emp_profile.html" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="users"></i> <span class="align-middle">EMPLOYEE PROFILE</span>
                            </a>

                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#documentation" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="book-open"></i> <span class="align-middle">ATTENDANCE</span>
                            </a>
                            <ul id="documentation" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="">Show Attendance</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="">Add Attendance</a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#ui" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="grid"></i> <span class="align-middle">LEAVES</span>
                            </a>
                            <ul id="ui" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="">Show Leave</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="">Apply Leave</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="">Adjust Leave</a></li>
                            </ul>
                        </li>

                        <li class="sidebar-item">
                            <a href="payroll.html" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="check-square"></i> <span class="align-middle">PAYROLL SYSTEM</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="meeting.html">
                                <i class="align-middle" data-feather="list"></i> <span class="align-middle">MEETING</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="mail.html">
                                <i class="align-middle" data-feather="list"></i> <span class="align-middle">EMPLOYEE SEND MAIL</span>
                            </a>
                        </li>



                        <li class="sidebar-header">
                            <br>
                            <br>
                            <br>
                        </li>
                        <li class="sidebar-header">
                            Addons
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#icons" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="heart"></i> <span class="align-middle">Icons</span>
                                <span class="badge badge-sidebar-primary">1500+</span>
                            </a>
                            <ul id="icons" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="icons-feather.html">Feather</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="icons-font-awesome.html">Font Awesome</a></li>
                            </ul>
                        </li>

                        <li class="sidebar-item">
                            <a data-bs-target="#multi" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="share-2"></i> <span class="align-middle">Multi Level</span>
                            </a>
                            <ul id="multi" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                                <li class="sidebar-item">
                                    <a data-bs-target="#multi-2" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                        Two Levels
                                    </a>
                                    <ul id="multi-2" class="sidebar-dropdown list-unstyled collapse">
                                        <li class="sidebar-item">
                                            <a class="sidebar-link" data-bs-target="#">Item 1</a>
                                            <a class="sidebar-link" data-bs-target="#">Item 2</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="sidebar-item">
                                    <a data-bs-target="#multi-3" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                        Three Levels
                                    </a>
                                    <ul id="multi-3" class="sidebar-dropdown list-unstyled collapse">
                                        <li class="sidebar-item">
                                            <a data-bs-target="#multi-3-1" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                                Item 1
                                            </a>
                                            <ul id="multi-3-1" class="sidebar-dropdown list-unstyled collapse">
                                                <li class="sidebar-item">
                                                    <a class="sidebar-link" data-bs-target="#">Item 1</a>
                                                    <a class="sidebar-link" data-bs-target="#">Item 2</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="sidebar-item">
                                            <a class="sidebar-link" data-bs-target="#">Item 2</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>

                </div>
            </nav>
            <div class="main">
                <nav class="navbar navbar-expand navbar-light navbar-bg" style="background-color: #262254 !important; color: #fff !important;">
                    <a class="sidebar-toggle">
                        <i class="hamburger align-self-center"></i>
                    </a>


                    <strong class="cw">HR Master Login</strong>


                    <div class="navbar-collapse collapse">
                        <ul class="navbar-nav navbar-align">

                            <li class="nav-item dropdown">
                                <a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
                                    <div class="position-relative">
                                        <i class="align-middle" data-feather="bell"></i>
                                        <span class="indicator">4</span>
                                    </div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
                                    <div class="dropdown-menu-header">
                                        4 New Notifications
                                    </div>
                                    <div class="list-group">
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-danger" data-feather="alert-circle"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Update completed</div>
                                                    <div class="text-muted small mt-1">Restart server 12 to complete the update.</div>
                                                    <div class="text-muted small mt-1">2h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-warning" data-feather="bell"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Notification for Salary generation</div>
                                                    <div class="text-muted small mt-1">Aliquam ex eros, imperdiet vulputate hendrerit et.</div>
                                                    <div class="text-muted small mt-1">6h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-primary" data-feather="home"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Vishal Has Birthday Tomorrow</div>
                                                    <div class="text-muted small mt-1">8h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-success" data-feather="user-plus"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">New Employee</div>
                                                    <div class="text-muted small mt-1">Amit Dubey Joined Embedded.</div>
                                                    <div class="text-muted small mt-1">12h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="dropdown-menu-footer">
                                        <a href="#" class="text-muted">Show all notifications</a>
                                    </div>
                                </div>
                            </li>

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


    </body>
</html>