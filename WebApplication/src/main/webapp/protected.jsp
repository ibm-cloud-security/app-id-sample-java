<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sample App</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/protected.css" ></link>
    <script src="https://code.jquery.com/jquery-3.1.1.js"></script>
    <script src="jquery.json-viewer.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="stylesheets/jquery.json-viewer.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div id="maindiv" class="maindiv">
    <div class="top-container">
        <div class="top">
            <div class="logout">
                <a href='/appidSample/logout'><img class="logout-icon" href='/logout' id="logoutIcon"
                                       src="images/logout.svg"></a>
            </div>
        </div>
    </div>

    <div class="middle-container">
        <div class="hello-text">
            Hi ${name}, Congratulations!<br>
            You’ve made your first authentication.<br>
        </div>
        <div class="above-button-text">
            What you can do next:
        </div>
        <a href="https://cloud.ibm.com/docs/services/appid?topic=appid-web-apps" target="_blank">
            <button class="button">
                <div class="button-text">
                    Add App ID to your own app
                </div>
            </button>
        </a>
    </div>

    <div class="bottom-container">
        <div class="bottom-container-data">
            <div class="token-title">
                ID Token
            </div>
            <div id="idTokenAttributes" class="token-info"></div>
        </div>
    </div>
</div>

<script>
    $('#idTokenAttributes').jsonViewer(${id_token}, {collapsed: false});
</script>

</body>
</html>
