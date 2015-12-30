<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>User</title>
</head>
<body>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="principal"/>
</sec:authorize>
<div class="profile">
    <h1>Hello,${principal.username}</h1>
</div>
</body>
<style>
    .profile{
        width: 600px;
        margin: 30px auto;
    }
</style>
</html>
