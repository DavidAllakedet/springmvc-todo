<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Taches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important; }
        .table th { border-top: none; font-weight: 600; color: #495057; }
        .btn-add { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; color: white; }
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/todos">Taches</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/todos/add">Ajouter</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-list-task"></i> Liste des Taches</h2>
            <a href="${pageContext.request.contextPath}/todos/add" class="btn btn-add">
                <i class="bi bi-plus-lg"></i> Nouvelle Tache
            </a>
        </div>

        <c:if test="${not empty filterStatut}">
            <div class="alert alert-info">
                Filtre par statut : <strong>${filterStatut}</strong>
                <a href="${pageContext.request.contextPath}/todos" class="float-end">Supprimer le filtre</a>
            </div>
        </c:if>
        <c:if test="${not empty filterPriorite}">
            <div class="alert alert-warning">
                Filtre par priorite : <strong>${filterPriorite}</strong>
                <a href="${pageContext.request.contextPath}/todos" class="float-end">Supprimer le filtre</a>
            </div>
        </c:if>

        <div class="card shadow-sm">
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty todos}">
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-inbox display-1"></i>
                            <p class="mt-3 fs-5">Aucune tache trouvee</p>
                            <a href="${pageContext.request.contextPath}/todos/add" class="btn btn-add mt-2">Creer une tache</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Titre</th>
                                        <th>Description</th>
                                        <th>Priorite</th>
                                        <th>Statut</th>
                                        <th>Echeance</th>
                                        <th class="text-center">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="todo" items="${todos}">
                                        <tr>
                                            <td class="text-muted">${todo.id}</td>
                                            <td class="fw-semibold">${todo.titre}</td>
                                            <td class="text-muted">${todo.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${todo.priorite == 'HAUTE'}">
                                                        <span class="badge bg-danger"><i class="bi bi-flag-fill"></i> Haute</span>
                                                    </c:when>
                                                    <c:when test="${todo.priorite == 'MOYENNE'}">
                                                        <span class="badge bg-warning text-dark"><i class="bi bi-flag-fill"></i> Moyenne</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-info"><i class="bi bi-flag"></i> Basse</span>
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
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/todos/edit/${todo.id}" class="btn btn-sm btn-outline-warning" title="Modifier">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/todos/delete/${todo.id}" class="btn btn-sm btn-outline-danger" title="Supprimer" onclick="return confirm('Voulez-vous vraiment supprimer cette tache?')">
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

    <footer class="text-center py-4 mt-4 text-muted">
        <p>Spring MVC - JSP - JSTL | Todo App</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
