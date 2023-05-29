<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="Hemant" />
    <title>GenReporting | Login</title>
    <link rel="canonical" href="pages-sign-in.html" />
    <link rel="shortcut icon" href="img/Gen.png" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&amp;display=swap" rel="stylesheet" />
    <link href="css/light.css" rel="stylesheet" />
    <style>
        /*.MY{ 
             padding: 12px 20px;
             display: inline-block;
             border: 1px solid #ccc;
             border-radius: 4px;
             box-sizing: border-box;

        }*/
    </style>
</head>

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-behavior="sticky" onload="createCaptcha()">
    <form id="form1" runat="server">

        <div class="main d-flex justify-content-center w-100">
            <main class="content d-flex p-0">
                <div class="container d-flex flex-column">
                    <div class="row h-100">
                        <div class="col-sm-8 col-md-6 col-lg-5 mx-auto d-table h-100">
                            <div class="d-table-cell align-middle">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="m-sm-4">
                                            <div class="text-center">
                                                <img src="img/log.png" alt="" class="img-fluid rounded-circle mb-2" width="200" height="200" />
                                            </div>
                                            <div class="text-center mb-3">
                                                <h2 class="cv">Login to Get Started</h2>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Email</label>
                                                <%--<asp:TextBox ID="TextBox1"  CssClass=""></asp:TextBox>--%>
                                                <input list="select2" type="text" id="SearchText" class="form-control form-control-lg" style="border-radius: 4px;" />
                                                <datalist class="MeClass" id="select2">
                                                </datalist>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Password</label>
                                                <%--<asp:TextBox ID="TextBox2" runat="server"  CssClass="form-control form-control-lg" TextMode="Password"></asp:TextBox>--%>
                                                <input type="text" class="form-control form-control-lg" id="PasswordText" />

                                            </div>
                                            <div class="mb-3">

                                                <label class="form-label">Captcha</label>
                                                <div id="captcha" class="form-control form-control-sm" style="text-decoration: line-through !important; text-align: center; background-color: #ede7f6; border-radius: 10px; border: none; outline: none; color: #1d1d1d;"></div>
</div>                                            
                                            <div class="mb-3">
                                                <label class="form-label">Enter Captcha</label>

                                                <input type="text" placeholder="Captcha" class="form-control form-control-lg" id="cpatchaTextBox"   autocomplete="off"/>
                                            </div>
                                            <div class="mb-3">
                                                <small>
                                                    <a onclick="ForGetPasswordFun()" style="color: blue;">Forgot password?</a> &nbsp; &nbsp;
                                                    <%--<a  onclick="Logintosysystem()" style="color : blue;">Login  System</a>--%>
                                                </small>
                                            </div>
                                            <div class="text-center mt-3">
                                                <%--<asp:Button CssClass="btn btn-lg btn-primary" OnClick="ButtonLogin_Click" ID="Button1" runat="server"  style="width: 60%;"  Text="Sign in" />--%>
                                                <button type="submit" id="BtnLogin" class="btn btn-lg btn-primary" style="width: 60%;">Sign</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <div id="splash" class="splash">
            <div class="mdv">
                <img src="img/Gen.png">
                <h1>GenReporting</h1>
                <div class="item loading-6">
                    <svg viewBox="25 25 50 50">
                        <circle cx="50" cy="50" r="20"></circle>
                    </svg>
                </div>

            </div>
        </div>
        <script src="vendor/sweetalert2.all.min.js"></script>
        <script src="js/app.js"></script>
        <script src="JsDB/popper.min.js"></script>
        <script src="JsDB/jquery.js"></script>
        <%--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
        <script>
            var code;
            var LoginSno;
            var LoginIDMax;
            var LoginType;
            var LoginEmpCode;
            var LoginName;
            var LoginEmail;
            var LoginImage;
            var RoleId;
            function createCaptcha() {
                //clear the contents of captcha div first 
                document.getElementById('captcha').innerHTML = "";
                var charsArray =
                "0123456789abcdefghijklmnopqrstuvwxyz.~`)(*&^%$#@!~=-][}{';/.,?><ABCDEFGHIJKLMNOPQRSTUVWXYZ@!#$%^&*";
                var lengthOtp = 6;
                var captcha = [];
                for (var i = 0; i < lengthOtp; i++) {
                    //below code will not allow Repetition of Characters
                    var index = Math.floor(Math.random() * charsArray.length + 1); //get the next character from the array
                    if (captcha.indexOf(charsArray[index]) == -1)
                        captcha.push(charsArray[index]);
                    else i--;
                }
                var canv = document.createElement("canvas");
                canv.id = "captcha";
                canv.width = 100;
                canv.height = 50;
                var ctx = canv.getContext("2d");
                ctx.font = "25px Georgia";
                ctx.strokeText(captcha.join(""), 0, 30);
                code = captcha.join("");
                document.getElementById("captcha").appendChild(canv);
            }
            function validateCaptcha() {
                if (document.getElementById("cpatchaTextBox").value == code) {
                    return ("1")
                } else {
                    createCaptcha();
                    return ("0");
                }
            }


            $(document).ready(function () {

                document.getElementById("splash").classList.remove('splash');
                document.getElementById("splash").classList.add('splash1');
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

            // Logintosysystem
            function Logintosysystem() {
                $.ajax({
                    type: "POST",
                    url: "LoginPage.aspx/LoginSystemSe",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var s = r.d;
                    }
                });
            }
            function ForGetPasswordFun() {
                var Email = $("#SearchText").val();
                if (Email == " " || Email.length == 0) {
                    Swal.fire({
                        icon: 'info',
                        title: 'info',
                        width: '300px',
                        text: 'Please enter email Id !'
                    });
                } else {
                    if ($("#cpatchaTextBox").val().length == 0 || $("#cpatchaTextBox").val() == "") {
                        Swal.fire({
                            icon: 'info',
                            title: 'info',
                            width: '300px',
                            text: 'Please enter Captcha !'
                        });
                    } else {
                        if (validateCaptcha() == "1") {
                            ob = {
                                Email: $("#SearchText").val()
                            }

                            $.ajax({
                                type: "POST",
                                url: "LoginPage.aspx/ForGetPassword",
                                data: JSON.stringify(ob),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (r) {
                                    if (r.d == "No") {
                                        Swal.fire({
                                            icon: 'info',
                                            title: 'info',
                                            width: '300px',
                                            text: 'Please enter valid email id!'
                                        });
                                    } else {
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'success',
                                            width: '300px',
                                            text: 'Email send successfully !'
                                        });
                                        setTimeout(function () {
                                            location.reload();
                                        }, 2000)
                                    }
                                },
                                error: function (r) {
                                    alert("Error Forget Password");
                                }
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                width: '300px',
                                text: 'Invalid Captcha. try Again!'
                            });
                            createCaptcha();
                        }
                    }
                }
            }

            $(document).ready(function () {
              
                $(function () {
                    document.getElementById("splash").classList.remove('splash');
                    document.getElementById("splash").classList.add('splash1');
                }, 2000);

                $("#BtnLogin").click(function (e) {
                    e.preventDefault();
                    var UserId = $("#SearchText").val();
                    var Pass = $("#PasswordText").val();
                    var cpatcha = $("#cpatchaTextBox").val();
                    if (UserId.length == 0 || UserId == " " || Pass.length == 0 || Pass == " ") {
                        Swal.fire({
                            icon: 'error',
                            title: 'error',
                            width: '300px',
                            text: 'Please enter your email password !'
                        });
                    } else {
                        if (cpatcha.length == 0 || cpatcha == " ") {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                width: '300px',
                                text: 'Please Enter Cpatcha  !'
                            });
                        } else {
                           
                            if (validateCaptcha() == "1") {
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                var formData = new FormData();
                                formData.append("UserId", UserId);
                                formData.append("Pass", Pass);
                                formData.append("Lon", "Lon");
                                formData.append("Lat", "Lat");
                                formData.append("Type", "System");
                                $.ajax({
                                    url: 'WebServerFile/LoginLogoutService.asmx/LoginEmployee',
                                    type: 'POST',
                                    data: formData,
                                    cache: false,
                                    contentType: false,
                                    processData: false,
                                    success: function (data) {
                                        if (data[0].response == "success") {
                                            //
                                            LoginSno = data[0].Sno;
                                            LoginIDMax = data[0].MaxId;
                                            LoginType = data[0].DesigiId;
                                            LoginEmpCode = data[0].EmpCode;
                                            LoginName = data[0].EmpName;
                                            LoginEmail = data[0].OfficeEmail;
                                            LoginImage = data[0].Image;
                                            LoginRoleId = data[0].Roleid;
                                            // start 1.1
                                            if (LoginType == 400 || LoginType == "400") {
                                                window.open("CreatePassword.aspx?Sno=" + LoginSno);
                                            }
                                            else if (LoginType == 404 || LoginType == "404") {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'error',
                                                    width: '300px',
                                                    text: 'Invalid Email. Try Again !'
                                                })
                                            }
                                            else if (LoginType == 399 || LoginType == "399") {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'error',
                                                    width: '300px',
                                                    text: 'Invalid Password. Try Again !'
                                                })
                                            }
                                            else if (LoginType == 500 || LoginType == "500") {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'error',
                                                    width: '300px',
                                                    text: 'System MAC  address  Not Found  !'
                                                })
                                            }
                                            else {
                                                setobj = {
                                                    LoginSno: LoginSno,
                                                    LoginIDMax: LoginIDMax,
                                                    LoginEmpCode: LoginEmpCode,
                                                    LoginName: LoginName,
                                                    LoginEmail: LoginEmail,
                                                    LoginImage: LoginImage,
                                                    LoginRoleId: LoginRoleId
                                                }
                                                $.ajax({
                                                    type: "POST",
                                                    url: "LoginPage.aspx/SetValuse",
                                                    data: JSON.stringify(setobj),
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    success: function (r) {
                                                        if (LoginType == 101 || LoginType == "101") {
                                                            location.replace("AdminHomePage.aspx");
                                                        }
                                                        else if (LoginType == 102 || LoginType == "102") {
                                                            location.replace("Hr_HomePage.aspx");
                                                        }
                                                        else if (LoginType == 103 || LoginType == "103") {
                                                            location.replace("Finance_HomePage.aspx");
                                                        }
                                                        else {
                                                            location.replace("Emp_HomePage.aspx");
                                                        }
                                                    }
                                                });

                                            }
                                            //
                                        } else {
                                            Swal.fire({
                                                icon: 'warning',
                                                title: 'warning',
                                                width: '300px',
                                                text: 'Web Service Not Working  !'
                                            })
                                         
                                        }
                                    }
                                });
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'error',
                                    width: '300px',
                                    text: 'Invalid Captcha. try Again!'
                                });
                                createCaptcha();
                            }
                        }
                    }
                });

            });
            // 
         

//

        </script>
    </form>
</body>
</html>
