<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/common/header.jsp">
    <jsp:param name="pageTitle" value="Modifier la Tache"/>
    <jsp:param name="activePage" value="todos"/>
</jsp:include>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card card-form shadow-sm">
                <div class="card-header bg-white">
                    <h4 class="mb-0"><i class="bi bi-pencil-square"></i> Modifier la Tache #${todo.id}</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty titreError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${titreError}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty dateError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${dateError}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/todos/update" method="post">
                        <input type="hidden" name="id" value="${todo.id}">

                        <div class="mb-3">
                            <label for="titre" class="form-label">Titre <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="titre" name="titre" value="${todo.titre}" required maxlength="100" minlength="3">
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3" maxlength="500">${todo.description}</textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="priorite" class="form-label">Priorite</label>
                                <select class="form-select" id="priorite" name="priorite">
                                    <option value="HAUTE" ${todo.priorite == 'HAUTE' ? 'selected' : ''}>Haute</option>
                                    <option value="MOYENNE" ${todo.priorite == 'MOYENNE' ? 'selected' : ''}>Moyenne</option>
                                    <option value="BASSE" ${todo.priorite == 'BASSE' ? 'selected' : ''}>Basse</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="statut" class="form-label">Statut</label>
                                <select class="form-select" id="statut" name="statut">
                                    <option value="EN_ATTENTE" ${todo.statut == 'EN_ATTENTE' ? 'selected' : ''}>En attente</option>
                                    <option value="EN_COURS" ${todo.statut == 'EN_COURS' ? 'selected' : ''}>En cours</option>
                                    <option value="TERMINEE" ${todo.statut == 'TERMINEE' ? 'selected' : ''}>Terminee</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="dateEcheance" class="form-label">Date d'echeance</label>
                            <input type="date" class="form-control" id="dateEcheance" name="dateEcheance" value="${todo.dateEcheance}">
                            <div class="form-text">La date ne doit pas etre dans le passe.</div>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-update">
                                <i class="bi bi-check-lg"></i> Mettre a jour
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

<jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
