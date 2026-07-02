package com.project.uiii_t9.model.dao;

import com.project.uiii_t9.model.Alumno;

import java.util.List;


public interface Dao<T, K> {
    boolean create(T entidad);
    List<T> getAll();
    T getById(K id);
    boolean update(T entidad);
    boolean delete(K id);
}