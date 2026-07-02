<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="layout/header.jsp" %>

<div class="row g-4 animate-fade-in">
    <div class="col-12">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-2">
            <div>
                <h1 class="display-6 fw-bold mb-1"><i class="bi bi-people-fill text-primary me-2"></i>Gestión de Alumnos</h1>
                <p class="section-subtitle mb-0">Gestiona y visualiza la lista de alumnos registrados de forma rápida y moderna</p>
            </div>
            <div>
                <a href="alumno" class="btn btn-outline-custom d-flex align-items-center gap-2">
                    <i class="bi bi-arrow-clockwise"></i> Recargar Lista
                </a>
            </div>
        </div>
    </div>

    <!-- Filtros y Búsqueda -->
    <div class="col-12">
        <div class="glass-panel p-3">
            <div class="row g-3 align-items-center">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-transparent border-end-0" style="border-color: var(--border-color)">
                            <i class="bi bi-search text-secondary"></i>
                        </span>
                        <input type="text" id="searchInput" class="form-control bg-transparent border-start-0 text-white"
                               placeholder="Buscar por nombre, apellidos o matrícula..." style="border-color: var(--border-color)" onkeyup="filterAlumnos()">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="d-flex gap-2 justify-content-md-end flex-wrap">
                        <button class="btn btn-sm btn-outline-custom active" onclick="filterGender('Todos', this)">Todos</button>
                        <button class="btn btn-sm btn-outline-custom" onclick="filterGender('Masculino', this)">Masculino</button>
                        <button class="btn btn-sm btn-outline-custom" onclick="filterGender('Femenino', this)">Femenino</button>
                        <button class="btn btn-sm btn-outline-custom" onclick="filterGender('Otro', this)">Otro</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Grid de Alumnos -->
    <div class="col-lg-8">
        <c:choose>
            <c:when test="${empty listaAlumno}">
                <div class="glass-panel empty-state text-center">
                    <div class="empty-state-icon">
                        <i class="bi bi-person-badge"></i>
                    </div>
                    <h3 class="fw-bold">No hay alumnos registrados</h3>
                    <p class="text-secondary max-width-xs mx-auto mb-4">Comienza registrando un alumno en el formulario lateral para verlo en la lista.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4" id="alumnosGrid">
                    <c:forEach items="${listaAlumno}" var="alumno">
                        <div class="col-md-6 col-xl-4 alumno-item" 
                             data-name="${alumno.nombre} ${alumno.apellidos}" 
                             data-matricula="${alumno.matricula}" 
                             data-gender="${alumno.sexo}">
                            <div class="movie-card">
                                <div class="movie-poster-wrapper" style="height: 200px; display: flex; align-items: center; justify-content: center; background: rgba(255, 255, 255, 0.03);">
                                    <span class="movie-rating-badge">
                                        <i class="bi bi-hash"></i> ${alumno.matricula}
                                    </span>
                                    <span class="movie-year-badge">
                                        ${alumno.edad} años
                                    </span>
                                    <c:set var="imgUrl" value="https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=150" />
                                    <c:if test="${alumno.sexo eq 'Masculino'}">
                                        <c:set var="imgUrl" value="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=150" />
                                    </c:if>
                                    <c:if test="${alumno.sexo eq 'Femenino'}">
                                        <c:set var="imgUrl" value="https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150" />
                                    </c:if>
                                    <img src="${imgUrl}" alt="${alumno.nombre}" class="rounded-circle" style="width: 100px; height: 100px; object-fit: cover; border: 3px solid var(--border-color);">
                                </div>
                                <div class="movie-card-body">
                                    <div>
                                        <h3 class="movie-title text-truncate" title="${alumno.nombre} ${alumno.apellidos}">${alumno.nombre} ${alumno.apellidos}</h3>
                                        <div class="movie-info-row d-flex flex-wrap gap-1">
                                            <span class="movie-meta-badge genre-badge">${alumno.sexo}</span>
                                            <span class="movie-meta-badge" title="${alumno.correo}"><i class="bi bi-envelope me-1"></i>Email</span>
                                        </div>
                                    </div>
                                    
                                    <div class="card-actions">
                                        <button class="btn btn-sm btn-outline-custom w-50" 
                                                onclick="openEditModal(${alumno.id}, '${alumno.nombre}', '${alumno.apellidos}', ${alumno.edad}, '${alumno.matricula}', '${alumno.correo}', '${alumno.sexo}')">
                                            <i class="bi bi-pencil-square me-1"></i> Editar
                                        </button>
                                        <button class="btn btn-sm btn-danger-gradient w-50" 
                                                onclick="confirmDelete(${alumno.id}, '${alumno.nombre} ${alumno.apellidos}')">
                                            <i class="bi bi-trash3 me-1"></i> Borrar
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Formulario para Registrar Alumno -->
    <div class="col-lg-4">
         <div class="glass-panel p-4">
             <h3 class="fw-bold mb-4 text-primary d-flex align-items-center gap-2">
                 <i class="bi bi-person-plus-fill"></i> Nuevo Alumno
             </h3>

             <form action="alumno" method="POST" class="form-floating-custom">
                 <div class="mb-3">
                     <label class="text-secondary small mb-1">Nombre(s)</label>
                     <input type="text" class="form-control" name="nombre" placeholder="Ej: Juan" required>
                 </div>

                 <div class="mb-3">
                     <label class="text-secondary small mb-1">Apellidos</label>
                     <input type="text" class="form-control" name="apellidos" placeholder="Ej: Pérez Gómez" required>
                 </div>

                 <div class="row">
                     <div class="col-6 mb-3">
                         <label class="text-secondary small mb-1">Edad</label>
                         <input type="number" class="form-control" name="edad" placeholder="Ej: 20" required min="1" max="120">
                     </div>
                     <div class="col-6 mb-3">
                         <label class="text-secondary small mb-1">Matrícula</label>
                         <input type="text" class="form-control" name="matricula" placeholder="Ej: 20233-AL01" required>
                     </div>
                 </div>

                 <div class="row">
                     <div class="col-6 mb-3">
                         <label class="text-secondary small mb-1">Sexo</label>
                         <select class="form-select" name="sexo" required>
                             <option value="" selected disabled>Selecciona...</option>
                             <option value="Masculino">Masculino</option>
                             <option value="Femenino">Femenino</option>
                             <option value="Otro">Otro</option>
                         </select>
                     </div>
                     <div class="col-6 mb-3">
                         <label class="text-secondary small mb-1">Correo Electrónico</label>
                         <input type="email" class="form-control" name="correo" placeholder="Ej: juan.perez@correo.com" required>
                     </div>
                 </div>

                 <div class="d-grid mt-3">
                     <button type="submit" class="btn btn-primary-gradient py-2">
                         <i class="bi bi-save me-2"></i> Registrar Alumno
                     </button>
                 </div>
             </form>
         </div>
    </div>
</div>

<!-- Modal para Editar Alumno -->
<div class="modal fade" id="editAlumnoModal" tabindex="-1" aria-labelledby="editAlumnoModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold text-white" id="editAlumnoModalLabel"><i class="bi bi-pencil-square text-primary me-2"></i>Editar Alumno</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="alumno" method="POST" class="form-floating-custom">
                <div class="modal-body p-4">
                    <input type="hidden" id="editId" name="id">

                    <div class="mb-3">
                        <label class="text-secondary small mb-1">Nombre(s)</label>
                        <input type="text" class="form-control" id="editNombre" name="nombre" required>
                    </div>

                    <div class="mb-3">
                        <label class="text-secondary small mb-1">Apellidos</label>
                        <input type="text" class="form-control" id="editApellidos" name="apellidos" required>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3">
                            <label class="text-secondary small mb-1">Edad</label>
                            <input type="number" class="form-control" id="editEdad" name="edad" required min="1" max="120">
                        </div>
                        <div class="col-6 mb-3">
                            <label class="text-secondary small mb-1">Matrícula</label>
                            <input type="text" class="form-control" id="editMatricula" name="matricula" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3">
                            <label class="text-secondary small mb-1">Sexo</label>
                            <select class="form-select" id="editSexo" name="sexo" required>
                                <option value="Masculino">Masculino</option>
                                <option value="Femenino">Femenino</option>
                                <option value="Otro">Otro</option>
                            </select>
                        </div>
                        <div class="col-6 mb-3">
                            <label class="text-secondary small mb-1">Correo Electrónico</label>
                            <input type="email" class="form-control" id="editCorreo" name="correo" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary-gradient px-4">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Formulario oculto para Borrar Alumno -->
<form id="deleteForm" action="alumno" method="POST" style="display: none;">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" id="deleteId" name="id">
</form>

<!-- Scripts para dinamismo -->
<script>
    function openEditModal(id, nombre, apellidos, edad, matricula, correo, sexo) {
        document.getElementById('editId').value = id;
        document.getElementById('editNombre').value = nombre;
        document.getElementById('editApellidos').value = apellidos;
        document.getElementById('editEdad').value = edad;
        document.getElementById('editMatricula').value = matricula;
        document.getElementById('editCorreo').value = correo;
        document.getElementById('editSexo').value = sexo;
        
        var editModal = new bootstrap.Modal(document.getElementById('editAlumnoModal'));
        editModal.show();
    }

    function confirmDelete(id, nombreCompleto) {
        if (confirm("¿Estás seguro de que deseas eliminar al alumno \"" + nombreCompleto + "\"?")) {
            document.getElementById('deleteId').value = id;
            document.getElementById('deleteForm').submit();
        }
    }

    // Filtro de búsqueda por texto
    function filterAlumnos() {
        var query = document.getElementById('searchInput').value.toLowerCase();
        var alumnos = document.querySelectorAll('.alumno-item');
        
        alumnos.forEach(function(alumno) {
            var name = alumno.getAttribute('data-name').toLowerCase();
            var matricula = alumno.getAttribute('data-matricula').toLowerCase();
            
            if (name.includes(query) || matricula.includes(query)) {
                alumno.style.display = '';
            } else {
                alumno.style.display = 'none';
            }
        });
    }

    // Filtro rápido por sexo
    var activeGender = 'Todos';
    function filterGender(gender, btn) {
        // Remover clase active de todos los botones de género
        var buttons = btn.parentElement.querySelectorAll('button');
        buttons.forEach(function(b) {
            b.classList.remove('active');
        });
        btn.classList.add('active');
        
        activeGender = gender;
        var alumnos = document.querySelectorAll('.alumno-item');
        
        alumnos.forEach(function(alumno) {
            var alumnoGender = alumno.getAttribute('data-gender');
            
            if (gender === 'Todos' || alumnoGender === gender) {
                alumno.style.display = '';
            } else {
                alumno.style.display = 'none';
            }
        });
        
        // Limpiar el input de búsqueda de texto al cambiar de filtro
        document.getElementById('searchInput').value = '';
    }
</script>

<%@ include file="layout/footer.jsp" %>