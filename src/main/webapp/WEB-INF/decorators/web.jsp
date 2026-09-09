<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Decorator chinh cho toan bo trang "web" (khach hang).
     <sitemesh:write .../> KHONG phai custom taglib: SiteMesh la 1 Filter,
     doc HTML da render cua trang goc va thay the cac the nay bang
     title/head/body that su cua trang do, nen KHONG can khai bao taglib. --%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Minh Thư Shop - <sitemesh:write property='title'/></title>

<!-- Bootstrap 5 (Template Bootstrap dung chung cho toan site) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600;700&display=swap" rel="stylesheet">

<style>
    :root { --brand: #2E7D32; --brand-dark: #256428; }
    body { font-family: 'Segoe UI', Arial, sans-serif; background: #F7F9F8; color: #333; }
    a { text-decoration: none; }
    .btn-brand { background: var(--brand); color: #fff; }
    .btn-brand:hover { background: var(--brand-dark); color: #fff; }
    .text-brand { color: var(--brand) !important; }
</style>

<!-- head/style rieng cua tung trang content se duoc chen vao day -->
<sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@ include file="/common/web/header.jsp"%>

    <main class="flex-grow-1">
        <sitemesh:write property="body"/>
    </main>

    <%@ include file="/common/web/footer.jsp"%>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
