<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginNot.aspx.cs" Inherits="LoginNot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <style>
        #network-status-online {
            background: green;
            padding: 15px;
            border-radius: 5px;
            color: white;
        }

        #network-status-offline {
            background: red;
            padding: 15px;
            border-radius: 5px;
            color: white;
        }

        .no-network {
            font-weight: bold;
            color: red;
        }

        .available-network {
            font-weight: bold;
            color: green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <center>
  <h2 id="network-status-offline" style="margin-top: 30px;"></h2>
  <h1>Oops, the internet went out.</h1>
  <p>How would you tell your user their internet connection is down but your site is working fine?</p>
  <p id='network-status-text' style="margin-bottom:30px;">Try switching off your wifi or mobile internet to see a <span class='no-network'>No network connection</span> message.</p>
            <a href="LoginPage.aspx" style="background-color:green; font-size:25px; border-color:green; padding:15px; color:white; border-radius:20px; text-decoration:none;">try again</a>
</center>


    </form>
    <script>
        document.getElementById('network-status-offline').innerHTML = "You might be offline, please check your internet connection! ☹️";

        //function showOnlineStatus(isOnline, msg) {
        //    const networkStatusOnline = document.getElementById('network-status-online');
        //    const networkStatusOffline = document.getElementById('network-status-offline');
        //    const networkStatusText = document.getElementById('network-status-text');

        //    if (isOnline) {
        //        networkStatusOffline.style.display = "none";
        //        networkStatusOnline.style.display = "inline-block";
        //        networkStatusOnline.innerText = msg;
        //        networkStatusText.innerHTML = "Try switching off your wifi or mobile internet to see a <span class='no-network'>no network connection</span> message.";
        //    } else {
        //        networkStatusOnline.style.display = "none";
        //        networkStatusOffline.style.display = "inline-block";
        //        networkStatusOffline.innerText = msg;
        //        networkStatusText.innerHTML = "Try switching on your wifi or mobile internet to see a <span class='available-network'>Back Online</span> message.";
        //    }

        //}



        //window.addEventListener('load', () => {
        //    if (navigator.onLine) {
        //        showOnlineStatus(true, "You're online! 😃");
        //    } else {
        //        showOnlineStatus(false, "You might be offline, please check your internet connection! ☹️");
        //    }

        //    window.addEventListener('online', () => {
        //        showOnlineStatus(true, "You are back online! 😎");
        //    });
        //    window.addEventListener('offline', () => {
        //        showOnlineStatus(false, "You might be offline, please check your internet connection! ☹️");
        //    });
        //});
    </script>
</body>
</html>
