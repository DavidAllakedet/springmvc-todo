<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.pageTitle} - Todo App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important; }
        .card-stat { border: none; border-radius: 15px; transition: transform 0.2s; }
        .card-stat:hover { transform: translateY(-5px); }
        .card-stat .card-body { padding: 1.5rem; }
        .stat-icon { width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .stat-value { font-size: 2rem; font-weight: bold; }
        .stat-label { color: #6c757d; font-size: 0.9rem; }
        .bg-primary-soft { background-color: rgba(102, 126, 234, 0.15); color: #667eea; }
        .bg-warning-soft { background-color: rgba(255, 193, 7, 0.15); color: #ffc107; }
        .bg-info-soft { background-color: rgba(23, 162, 184, 0.15); color: #17a2b8; }
        .bg-success-soft { background-color: rgba(40, 167, 69, 0.15); color: #28a745; }
        .bg-danger-soft { background-color: rgba(220, 53, 69, 0.15); color: #dc3545; }
        .hero-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .btn-add { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; color: white; padding: 0.5rem 1.5rem; border-radius: 25px; }
        .btn-add:hover { opacity: 0.9; color: white; }
        .card-form { border: none; border-radius: 15px; }
        .btn-update { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); border: none; color: white; }
        .btn-update:hover { opacity: 0.9; color: white; }
        .form-label { font-weight: 500; }
        .table th { border-top: none; font-weight: 600; color: #495057; }
        .nav-active { border-bottom: 2px solid white; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
                <i class="bi bi-check2-square"></i> Todo App
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="navbar-nav ms-auto">
                    <a class="nav-link ${param.activePage == 'dashboard' ? 'nav-active' : ''}" href="${pageContext.request.contextPath}/">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                    <a class="nav-link ${param.activePage == 'todos' ? 'nav-active' : ''}" href="${pageContext.request.contextPath}/todos">
                        <i class="bi bi-list-task"></i> Taches
                    </a>
                    <a class="nav-link ${param.activePage == 'add' ? 'nav-active' : ''}" href="${pageContext.request.contextPath}/todos/add">
                        <i class="bi bi-plus-lg"></i> Ajouter
                    </a>
                </div>
            </div>
        </div>
    </nav>
