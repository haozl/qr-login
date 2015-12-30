<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>微信网页版</title>
    <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css" />">
    <script src="<c:url value="/resources/sockjs-0.3.4.js" />"></script>
    <script src="<c:url value="/resources/stomp.js" />"></script>
    <script src="<c:url value="/resources/jquery.min.js" />"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <h2>扫描二维码登录微信</h2>
        <img src="<c:url value="/resources/img/qr.jpg" />" alt="">
    </div>
    <div class="row">
        <button id="sim" class="btn btn-default btn-lg" target="_blank">模拟手机登陆</button>
    </div>
</div>
<script>
    var stompClient = null;
    var destination = Math.random().toString(36).slice(2);
    function connect() {
        var socket = new SockJS('/weixin');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/auth/' + destination, function (resp) {
                var token = resp.body;
                window.location.href = '<c:url value="/weixin/auth-token?token=" />' + token;
            });
        });
    }

    function disconnect() {
        if (stompClient != null) {
            stompClient.disconnect();
        }
        console.log("Disconnected");
    }

    $(function () {
        $('#sim').click(function () {
            var settings = "width=640, height=280, top=220, left=820, scrollbars=no, location=no, directories=no, status=no, menubar=no, toolbar=no, resizable=no, dependent=no";
            var url = '<c:url value="/weixin/snapshot?destination=" />' + destination;
            win = window.open(url, 'Phone', settings);
            win.focus();
        });
        connect();
    });

</script>
</body>
</html>
