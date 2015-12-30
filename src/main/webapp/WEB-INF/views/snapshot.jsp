<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>你的移动设备</title>
</head>
<body>
<div class="container">
    <div class="phone">
        <h2>网页登陆确认</h2>
        <c:url value="/weixin/snapshot" var="snapshotUrl"/>
        <form class="form" action="${snapshotUrl}" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="destination" value="${param.destination}">
            <label>授权用户: </label><input type="text" name="username" value="sa" style="pointer-events:none;"/>
            <input type="submit" value="登陆">
        </form>
    </div>
</div>
</body>
<style>

    .phone {
        width: 500px;
        margin: 20px auto;
        border: solid 1px #ccc;
    }

    .phone h2 {
        text-align: center;
    }

    .form {
        padding: 10px;
    }
</style>
</html>
