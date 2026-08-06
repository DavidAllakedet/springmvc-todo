<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une Tache</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important; }
        .card-form { border: none; border-radius: 15px; }
        .btn-add { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; color: white; }
        .btn-add:hover { opacity: 0.9; color: white; }
        .form-label { font-weight: 500; }
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/todos/add">Ajouter</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card card-form shadow-sm">
                    <div class="card-header bg-white">
                        <h4 class="mb-0"><i class="bi bi-plus-circle"></i> Nouvelle Tache</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/todos/save" method="post">
                            <div class="mb-3">
                                <label for="titre" class="form-label">Titre <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="titre" name="titre" required placeholder="Entrez le titre de la tache">
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" placeholder="Decrivez la tache..."></textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="priorite" class="form-label">Priorite</label>
                                    <select class="form-select" id="priorite" name="priorite">
                                        <option value="HAUTE">Haute</option>
                                        <option value="MOYENNE" selected>Moyenne</option>
                                        <option value="BASSE">Basse</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="statut" class="form-label">Statut</label>
                                    <select class="form-select" id="statut" name="statut">
                                        <option value="EN_ATTENTE" selected>En attente</option>
                                        <option value="EN_COURS">En cours</option>
                                        <option value="TERMINEE">Terminee</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="dateEcheance" class="form-label">Date d'echeance</label>
                                <input type="date" class="form-control" id="dateEcheance" name="dateEcheance">
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-add">
                                    <i class="bi bi-check-lg"></i> Enregistrer
                                </button>
                                <a href="${pageContext.request.contextPath}/todos" class="btn btn-outline-secondary">
                                    <i class="bi bi-x-lg"></i> Annuler
                                </a>
                            </div>
                        </form>
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
