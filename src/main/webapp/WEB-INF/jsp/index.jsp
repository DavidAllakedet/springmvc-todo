<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todo App - Tableau de bord</title>
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
        .bg-success-soft { background-color: rgba(40, 167, 69, 0.15); color: #28a745; }
        .bg-danger-soft { background-color: rgba(220, 53, 69, 0.15); color: #dc3545; }
        .hero-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .btn-add { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; color: white; padding: 0.5rem 1.5rem; border-radius: 25px; }
        .btn-add:hover { opacity: 0.9; color: white; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
                <i class="bi bi-check2-square"></i> Todo App
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Dashboard</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/todos">Taches</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/todos/add">Ajouter</a>
            </div>
        </div>
    </nav>

    <div class="hero-section text-center">
        <div class="container">
            <h1 class="display-5 fw-bold">Tableau de bord</h1>
            <p class="lead">Gerez vos taches en toute simplicite</p>
        </div>
    </div>

    <div class="container">
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card card-stat shadow-sm">
                    <div class="card-body d-flex align-items-center">
                        <div class="stat-icon bg-primary-soft me-3">
                            <i class="bi bi-list-task"></i>
                        </div>
                        <div>
                            <div class="stat-value text-primary">${totalTaches}</div>
                            <div class="stat-label">Total Taches</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat shadow-sm">
                    <div class="card-body d-flex align-items-center">
                        <div class="stat-icon bg-warning-soft me-3">
                            <i class="bi bi-clock"></i>
                        </div>
                        <div>
                            <div class="stat-value text-warning">${enAttente}</div>
                            <div class="stat-label">En Attente</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat shadow-sm">
                    <div class="card-body d-flex align-items-center">
                        <div class="stat-icon bg-success-soft me-3">
                            <i class="bi bi-arrow-repeat"></i>
                        </div>
                        <div>
                            <div class="stat-value text-success">${enCours}</div>
                            <div class="stat-label">En Cours</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat shadow-sm">
                    <div class="card-body d-flex align-items-center">
                        <div class="stat-icon bg-danger-soft me-3">
                            <i class="bi bi-check-circle"></i>
                        </div>
                        <div>
                            <div class="stat-value text-danger">${terminee}</div>
                            <div class="stat-label">Terminees</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-list-ul"></i> Dernieres taches</h5>
                        <a href="${pageContext.request.contextPath}/todos" class="btn btn-sm btn-outline-primary">Voir tout</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty todos}">
                                <div class="text-center text-muted py-4">
                                    <i class="bi bi-inbox display-1"></i>
                                    <p class="mt-2">Aucune tache pour le moment</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Titre</th>
                                                <th>Priorite</th>
                                                <th>Statut</th>
                                                <th>Echeance</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="todo" items="${todos}" begin="0" end="4">
                                                <tr>
                                                    <td class="fw-semibold">${todo.titre}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${todo.priorite == 'HAUTE'}">
                                                                <span class="badge bg-danger">Haute</span>
                                                            </c:when>
                                                            <c:when test="${todo.priorite == 'MOYENNE'}">
                                                                <span class="badge bg-warning text-dark">Moyenne</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-info">Basse</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${todo.statut == 'EN_ATTENTE'}">
                                                                <span class="badge bg-secondary">En attente</span>
                                                            </c:when>
                                                            <c:when test="${todo.statut == 'EN_COURS'}">
                                                                <span class="badge bg-primary">En cours</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">Terminee</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:if test="${todo.dateEcheance != null}">
                                                            <fmt:parseDate value="${todo.dateEcheance}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/todos/edit/${todo.id}" class="btn btn-sm btn-outline-warning">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/todos/delete/${todo.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Supprimer cette tache?')">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <h5 class="mb-0"><i class="bi bi-funnel"></i> Filtrer</h5>
                    </div>
                    <div class="card-body">
                        <h6>Par Statut</h6>
                        <div class="d-grid gap-2 mb-3">
                            <a href="${pageContext.request.contextPath}/todos?statut=EN_ATTENTE" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-clock"></i> En attente
                            </a>
                            <a href="${pageContext.request.contextPath}/todos?statut=EN_COURS" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-arrow-repeat"></i> En cours
                            </a>
                            <a href="${pageContext.request.contextPath}/todos?statut=TERMINEE" class="btn btn-outline-success btn-sm">
                                <i class="bi bi-check-circle"></i> Terminee
                            </a>
                        </div>
                        <h6>Par Priorite</h6>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/todos?priorite=HAUTE" class="btn btn-outline-danger btn-sm">
                                <i class="bi bi-flag"></i> Haute
                            </a>
                            <a href="${pageContext.request.contextPath}/todos?priorite=MOYENNE" class="btn btn-outline-warning btn-sm">
                                <i class="bi bi-flag"></i> Moyenne
                            </a>
                            <a href="${pageContext.request.contextPath}/todos?priorite=BASSE" class="btn btn-outline-info btn-sm">
                                <i class="bi bi-flag"></i> Basse
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="text-center py-4 mt-4 text-muted">
        <p>Spring MVC - JSP - JSTL | Todo App</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
