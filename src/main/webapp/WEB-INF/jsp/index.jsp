<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/common/header.jsp">
    <jsp:param name="pageTitle" value="Tableau de bord"/>
    <jsp:param name="activePage" value="dashboard"/>
</jsp:include>

<div class="hero-section text-center">
    <div class="container">
        <h1 class="display-5 fw-bold">Tableau de bord</h1>
        <p class="lead">Gerez vos taches en toute simplicite</p>
    </div>
</div>

<div class="container">
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

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
                    <div class="stat-icon bg-info-soft me-3">
                        <i class="bi bi-arrow-repeat"></i>
                    </div>
                    <div>
                        <div class="stat-value text-info">${enCours}</div>
                        <div class="stat-label">En Cours</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card card-stat shadow-sm">
                <div class="card-body d-flex align-items-center">
                    <div class="stat-icon bg-success-soft me-3">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div>
                        <div class="stat-value text-success">${terminee}</div>
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
                    <h5 class="mb-0"><i class="bi bi-list-ul"></i> Dernieres taches <small class="text-muted">(les 5 plus recentes)</small></h5>
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
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/todos/edit/${todo.id}" class="btn btn-sm btn-outline-warning" title="Modifier">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/todos/delete/${todo.id}" method="post" style="display:inline" onsubmit="return confirm('Supprimer cette tache?')">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger" title="Supprimer">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
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
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/todos" method="get" class="mb-3">
                        <div class="input-group input-group-sm">
                            <input type="text" class="form-control" name="q" placeholder="Rechercher..." value="${searchQuery}">
                            <button type="submit" class="btn btn-add"><i class="bi bi-search"></i></button>
                        </div>
                    </form>
                    <div class="d-flex flex-wrap gap-1">
                        <a href="${pageContext.request.contextPath}/todos?statut=EN_ATTENTE" class="btn btn-sm btn-outline-secondary">En attente</a>
                        <a href="${pageContext.request.contextPath}/todos?statut=EN_COURS" class="btn btn-sm btn-outline-primary">En cours</a>
                        <a href="${pageContext.request.contextPath}/todos?statut=TERMINEE" class="btn btn-sm btn-outline-success">Terminee</a>
                        <a href="${pageContext.request.contextPath}/todos?priorite=HAUTE" class="btn btn-sm btn-outline-danger">Haute</a>
                        <a href="${pageContext.request.contextPath}/todos?priorite=MOYENNE" class="btn btn-sm btn-outline-warning">Moyenne</a>
                        <a href="${pageContext.request.contextPath}/todos?priorite=BASSE" class="btn btn-sm btn-outline-info">Basse</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
