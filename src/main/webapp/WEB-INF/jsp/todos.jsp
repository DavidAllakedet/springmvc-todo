<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/common/header.jsp">
    <jsp:param name="pageTitle" value="Liste des Taches"/>
    <jsp:param name="activePage" value="todos"/>
</jsp:include>

<div class="container mt-4">
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

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-list-task"></i> Liste des Taches</h2>
        <a href="${pageContext.request.contextPath}/todos/add" class="btn btn-add">
            <i class="bi bi-plus-lg"></i> Nouvelle Tache
        </a>
    </div>

    <c:if test="${not empty filterStatut or not empty filterPriorite or not empty searchQuery}">
        <div class="d-flex align-items-center gap-2 mb-3 p-2 bg-light rounded">
            <i class="bi bi-funnel-fill text-muted"></i>
            <span class="text-muted">
                <c:if test="${not empty searchQuery}">Recherche : "<strong>${searchQuery}</strong>"</c:if>
                <c:if test="${not empty filterStatut}">Statut : <strong>${filterStatut}</strong></c:if>
                <c:if test="${not empty filterPriorite}">Priorite : <strong>${filterPriorite}</strong></c:if>
            </span>
            <a href="${pageContext.request.contextPath}/todos" class="btn btn-sm btn-outline-secondary ms-auto">
                <i class="bi bi-x-lg"></i> Effacer
            </a>
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
                                        <td class="text-muted text-truncate" style="max-width: 200px;" title="${todo.description}">
                                            ${todo.description}
                                        </td>
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
                                                    <span class="badge bg-secondary"><i class="bi bi-clock"></i> En attente</span>
                                                </c:when>
                                                <c:when test="${todo.statut == 'EN_COURS'}">
                                                    <span class="badge bg-primary"><i class="bi bi-arrow-repeat"></i> En cours</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success"><i class="bi bi-check-circle"></i> Terminee</span>
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
                                            <form action="${pageContext.request.contextPath}/todos/delete/${todo.id}" method="post" style="display:inline" onsubmit="return confirm('Voulez-vous vraiment supprimer cette tache?')">
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

<jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
