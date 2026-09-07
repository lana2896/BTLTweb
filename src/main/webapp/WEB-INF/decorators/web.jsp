<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Luu y: the <sitemesh:write ... /> KHONG phai custom JSP taglib.
     SiteMesh hoat dong nhu 1 Filter, doc HTML da render ra va thay the
     cac the nay bang noi dung that su (title/head/body cua trang content).
     Vi vay KHONG can khai bao <%@ taglib prefix="sitemesh" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><sitemesh:write property='title'/></title>
<sitemesh:write property="head"/>
</head>
<body>
    <div class="layout-header">
        <%@ include file="/common/web/header.jsp"%>
    </div>

    <div class="layout-content">
        <sitemesh:write property="body"/>
    </div>

    <div class="layout-footer">
        <%@ include file="/common/web/footer.jsp"%>
    </div>
</body>
</html>
