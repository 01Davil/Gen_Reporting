<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForGetPassword.aspx.cs" Inherits="ForGetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="Hemant" />

    <title>Create Password</title>
    <link rel="canonical" href="pages-sign-in.html" />
    <link rel="shortcut icon" href="img/Gen.png" />

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&amp;display=swap" rel="stylesheet" />
    <link href="css/light.css" rel="stylesheet" />
    <style>
        .Short {
            width: 100%;
            background-color: #dc3545;
            margin-top: 5px;
            height: 3px;
            color: #dc3545;
            font-weight: 500;
            font-size: 12px;
        }

        .Weak {
            width: 100%;
            background-color: #ffc107;
            margin-top: 5px;
            height: 3px;
            color: #ffc107;
            font-weight: 500;
            font-size: 12px;
        }

        .Good {
            width: 100%;
            background-color: #28a745;
            margin-top: 5px;
            height: 3px;
            color: #28a745;
            font-weight: 500;
            font-size: 12px;
        }

        .Strong {
            width: 100%;
            background-color: #d39e00;
            margin-top: 5px;
            height: 3px;
            color: #d39e00;
            font-weight: 500;
            font-size: 12px;
        }

        .b {
            width: 60%;
        }
    </style>
</head>

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-behavior="sticky">
    <form runat="server">
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
                                                <img src="img/pass.png" alt="" class="img-fluid rounded-circle mb-4" width="200" />
                                            </div>
                                            <div class="text-center mb-4">
                                                <h2 class="cv">Set Your Password</h2>
                                            </div>
                                            <form>
                                                <div class="mb-3">
                                                    <label class="form-label">Enter New Password</label>
                                                    <input class="form-control form-control-lg" type="password" id="Pass" name="" placeholder=" password" />
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Confirm Password</label>
                                                    <input class="form-control form-control-lg" type="password" id="ConPass" name="" placeholder="Confirm password" />

                                                </div>
                                                <h5 id="txtca"></h5>

                                                <div class="text-center mt-5">
                                                    <button type="submit" id="btnSet" class=" btn btn-lg btn-primary" style="width: 60%;">Set Password</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="JsDB/jquery.js"></script>
        <script src="JsDB/bootstrap.js"></script>
        <script src="JsDB/javascript.js"></script>
        <script src="JsDB/popper.min.js"></script>
        <script src="js/app.js"></script>
        <script src="vendor/sweetalert2.all.min.js"></script>
        <script  type="text/javascript">
            $(document).ready(function () {
                $("#btnSet").click(function (e) {
                    e.preventDefault();
                    var Sno = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                    //alert(Sno);
                    Sno = Sno.toString().replace("Sno=", "");
                    var Pass=$("#Pass").val();
                    var ConPass=$("#ConPass").val();

                    if (Pass.length == 0 || ConPass == 0 || Pass == " " || ConPass == " ") {
                        Swal.fire({
                            icon: 'error',
                            title: 'error',
                            width: '300px',
                            text: 'Please Enter  Password and Confirm Password : !'
                        });
                    } else {
                        if (Pass != ConPass) {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                width: '300px',
                                text: 'Please Enter Same Password: !'
                            });
                        } else {
                            // api 
                            var formData = new FormData();
                            formData.append("Sno", Sno);
                            formData.append("Pass", Pass);
                            $.ajax({
                                url: 'https://genesiscloudapps.com/Gen_Reporting/GenReporting/WebServerFile/CreatePasswordServer.asmx/ForGetPass',
                                type: 'POST',
                                data: formData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (data) {
                                    if (data == "1") {
                                        oo = {
                                            Sno: Sno
                                        }
                                        $.ajax({
                                            type: "POST",
                                            url: "ForGetPassword.aspx/sendHumm",
                                            data: JSON.stringify(oo),
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (r) {
                                                Swal.fire({
                                                    icon: 'success',
                                                    title: 'success',
                                                    width: '300px',
                                                    text: 'Password Forget  successfully!'
                                                });
                                            }
                                        });
                                        setTimeout(function () {
                                            location.replace("LoginPage.aspx");
                                        }, 1000);
                                    } else {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'error',
                                            width: '300px',
                                            text: 'Password Forget  Not successfully!'
                                        });
                                    }
                                }
                            });
                        }
                    }
                });
            });
</script>

    </form>
</body>
</html>


