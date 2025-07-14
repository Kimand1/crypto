<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PBEWithMD5AndDES 암복호화</title>
</head>
<body>
<h2>암복호화 도구 (PBEWithMD5AndDES)</h2>

<form method="post" action="/encrypt">
    <label>텍스트:</label><br>
    <textarea name="inputText" rows="5" cols="50"><c:if test="${not empty inputText}">${inputText}</c:if></textarea><br>
    <label>비밀번호:</label><br>
    <input type="text" name="password" value="kiotPlatform"/><br>
    <button type="submit">암호화</button>
</form>

<form method="post" action="/decrypt" style="margin-top:20px;">
    <label>암호문:</label><br>
    <textarea name="inputDec" rows="5" cols="50"><c:if test="${not empty inputDec}">${inputDec}</c:if></textarea><br>
    <label>비밀번호:</label><br>
    <input type="text" name="password" value="kiotPlatform"/><br>
    <button type="submit">복호화</button>
</form>

<c:if test="${not empty result}">
    <h3>결과:</h3>
    <textarea rows="5" cols="50" readonly>${result}</textarea>
</c:if>
</body>
</html>