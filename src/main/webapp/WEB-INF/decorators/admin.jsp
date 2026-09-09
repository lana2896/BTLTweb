<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%-- Decorator cho khu vuc quan tri (/admin/*, /manager/*): sidebar + topbar Bootstrap. --%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản trị - <sitemesh:write property='title'/></title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body { font-family: 'Segoe UI', Arial, sans-serif; background: #F4F6F5; }
    .admin-sidebar {
        width: 240px; min-height: 100vh; background: #1c2b22; color: #dcefe2;
        position: sticky; top: 0;
    }
    .admin-sidebar .brand { padding: 18px 20px; font-weight: 700; font-size: 18px; color: #fff; border-bottom: 1px solid rgba(255,255,255,.08); }
    .admin-sidebar .nav-link { color: #cfe8d8; padding: 10px 20px; font-size: 14px; border-left: 3px solid transparent; }
    .admin-sidebar .nav-link:hover, .admin-sidebar .nav-link.active { background: rgba(255,255,255,.06); color: #fff; border-left-color: #4CAF50; }
    .admin-topbar { background: #fff; border-bottom: 1px solid #E0E0E0; padding: 12px 24px; }
    .form-group { margin-bottom: 1rem; }
</style>

<sitemesh:write property="head"/>
</head>
<body>
<div class="d-flex">
    <%@ include file="/common/admin/left.jsp"%>

    <div class="flex-grow-1">
        <%@ include file="/common/admin/header.jsp"%>

        <main class="p-4">
            <sitemesh:write property="body"/>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
