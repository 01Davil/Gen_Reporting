<%@ Page Language="C#" AutoEventWireup="true" CodeFile="demo.aspx.cs" Inherits="demo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 1114px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <table style="width:100%;">
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style1">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style1">
                    <input id="Text1" type="text" /></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style1">
                    <input id="Text2" type="text" /></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
               <%-- <td>&nbsp;</td>
                <td class="auto-style1">
                    <input id="File1" type="file" /></td>
                <td>&nbsp;</td>--%>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="auto-style1">&nbsp;</td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Button" />
                </td>
            </tr>
        </table>
    </form>
    
    <script src="JsDB/jquery.js"></script>
    <script src="JsDB/popper.min.js"></script>
<script src="JsDB/bootstrap.js"></script>
    <script src="JsDB/javascript.js"></script>
    <script>
        $(document).ready(function () {
            var a=1;
                  var formData = new FormData();
                 //
                  $("#Button1").click(function (e) {
                      e.preventDefault();
                var Text1 = $("#Text1").val();
                var Text2 = $("#Text2").val();
                
                obj = {
                    Text1: Text1,
                    Text2: Text2,
                }
                var items = formData.length;
             
                var objNam = "obj" + a;
                formData.append(objNam, obj);

                a += 1;
                alert(a);
                console.log(formData);
            })
        })
    </script>
</body>
</html>
