<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="javax.security.auth.Subject" %>
    <%@ page import="com.ibm.websphere.security.auth.WSSubject" %>
    <%@page import="java.util.Set" %>
    <%@page import="java.util.Hashtable" %>
    <%@page import="org.apache.commons.codec.binary.Base64" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Cloud Land</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/welcome.css" ></link>
    <script src="https://code.jquery.com/jquery-3.1.1.js"></script>
    <script src="jquery.json-viewer.js"></script>
</head>
<body>
<div id="maindiv" class="main-container">
    <div class="top-container">
        <div class="flex-top">
            <img id="userProfileImg" class="user-profile" src="${userImage}"/>
        </div>

        <div class="flex-top">
            <h1>Hi  ${username} </h1>
            <h1>you are on the right track
            </h1>
            <div class="flex-top">

                <button class="button" type="button" onclick="window.location='Token.jsp'" > View token</button>                               
            </div>
        </div>
    </div>
    <div class="bottom-container">
        <div class="flex-bottom">
            <h2>Next steps:<br/>Test that everything is working and customize the UI from the console.</h2>
        </div>
    </div>
</div>


</body>
</html>
