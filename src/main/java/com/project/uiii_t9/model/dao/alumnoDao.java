package com.project.uiii_t9.model.dao;

import com.project.uiii_t9.model.Alumno;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class alumnoDao implements Dao<Alumno, Integer> {
    @Override
    public List<Alumno> getAll() {
        List<Alumno> listaAlumnos = new ArrayList<>();

        String sql = "SELECT * FROM alumnos";

        try {
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Alumno alumno = new Alumno();

                alumno.setNombre(rs.getString("nombre"));
                alumno.setApellidos(rs.getString("apellidos"));
                alumno.setEdad(rs.getInt("edad"));
                alumno.setMatricula(rs.getString("matricula"));
                alumno.setCorreo(rs.getString("correo_electronico"));
                alumno.setSexo(rs.getString("sexo"));

                listaAlumnos.add(alumno);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            System.out.println("error al consultar alumnos: " + e.getMessage());
        }

        return listaAlumnos;
    }

    @Override
    public boolean create(Alumno alumno) {
        String sql = "INSERT INTO alumnos " +
                "(nombre, apellidos, edad, matricula, correo_electronico, sexo) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, alumno.getNombre());
            ps.setString(2, alumno.getApellidos());
            ps.setInt(3, alumno.getEdad());
            ps.setString(4, alumno.getMatricula());
            ps.setString(5, alumno.getCorreo());
            ps.setString(6, alumno.getSexo());

            ps.executeUpdate();

            ps.close();
            con.close();

            return true;

        } catch (Exception e) {
            System.out.println("error al registrar alumno: " + e.getMessage());
            return false;
        }
    }

    @Override
    public Alumno getById(Integer id) {
        return null;
    }

    @Override
    public boolean update(Alumno entidad) {
        return false;
    }


    @Override
    public boolean delete(Integer id) {
        return false;
    }
}
