package com.project.uiii_t9.controller;

import com.project.uiii_t9.model.Alumno;
import com.project.uiii_t9.model.dao.AlumnoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



import java.io.IOException;
import java.util.List;

@WebServlet(name = "alumnoServlet", value = "/alumno")
public class alumnoServlet extends HttpServlet {

    private final alumnoDao mascotaDao = new alumnoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Alumno> lista = AlumnoDao.getAll();
        request.setAttribute("listaAlumno", lista);
        request.getRequestDispatcher("gestion-alumnos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            int edad = Integer.parseInt(request.getParameter("edad"));
            String matricula = request.getParameter("matricula");
            String correo = request.getParameter("correo");
            String sexo = request.getParameter("sexo");

            Alumno nuevoAlumno = new Alumno();
            nuevoAlumno.setNombre(nombre);
            nuevoAlumno.setApellidos(apellidos);
            nuevoAlumno.setEdad(edad);
            nuevoAlumno.setMatricula(matricula);
            nuevoAlumno.setCorreo(correo);
            nuevoAlumno.setSexo(sexo);

            AlumnoDao.create(nuevoAlumno);
        } catch (NumberFormatException e) {
            System.err.println("Error al transformar datos numéricos en el registro: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect("alumno");
    }
}