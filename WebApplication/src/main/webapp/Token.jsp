<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Cloud Land</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/token.css" ></link>
    <script src="https://code.jquery.com/jquery-3.1.1.js"></script>
    <script src="jquery.json-viewer.js"></script>
</head>
<body>
<body>
<div class="main-container">
    <pre id="json-renderer"></pre>
    <div class="top-container">
        <div class="flex-top">
            <img class="back-icon" src="images/back.png" onclick="history.back()"/>
        </div>
        <div class="flex-top">
            <p>Back</p>
        </div>
    </div>
    
    <div id="datadiv" class="bottom-container">
        <div class="flex-bottom">
            <h1>Access Token:</h1>
            
            
            <div id="accessTokenAttributes" class="token-info"></div>
        </div>
        <div class="flex-bottom">
            <h1>ID Token:</h1>
            
            <div id="idTokenAttributes" class="token-info"></div>
        </div>
    </div>
</div>


<script>

 
	var accessTokenPayload = ${access_token};
	var idTokenPayload = ${id_token};

	//alert(JSON.stringify(tokens.accessTokenPayload));
    $("#datadiv").attr('style', 'visibility: visible');

    $('#accessTokenAttributes').jsonViewer(accessTokenPayload, {collapsed: false});
    $('#idTokenAttributes').jsonViewer(idTokenPayload, {collapsed: false});


	
    // Get the tokens payload from the session and display them
    //var accessTokenInfo = JSON.parse(window.sessionStorage.getItem('accessTokenInfo'));
    //var idTokenInfo = JSON.parse(window.sessionStorage.getItem('idTokenInfo'));

    // Display the information
     // $('#accessTokenAttributes').jsonViewer(accessTokenInfo, {collapsed: false});
     // $('#idTokenAttributes').jsonViewer(idTokenInfo, {collapsed: false});
     // $("#datadiv").attr('style', 'visibility: visible');

    

</script>
</body>
</body>
</html>

