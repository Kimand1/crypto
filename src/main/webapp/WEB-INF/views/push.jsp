<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FCM Push 메시지 전송</title>
</head>
<body>
<h2>FCM Push 메시지 전송</h2>
<form method="post" action="/push">
    <label for="token">FCM 토큰:</label><br>
    <input type="text" id="token" name="token" style="width: 400px;" required><br><br>

    <label for="title">제목:</label><br>
    <input type="text" id="title" name="title" required><br><br>

    <label for="body">내용:</label><br>
    <input type="text" id="body" name="body" required><br><br>

    <input type="submit" value="푸시 전송">
</form>
</body>
</html>