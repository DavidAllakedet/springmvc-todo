package com.todo.app.service;

import com.todo.app.dto.TodoDto;
import com.todo.app.entities.TodoEntity;

import java.util.List;

public interface ITodoService {
    TodoDto save(TodoDto todoDto);
    TodoDto update(TodoDto todoDto);
    void delete(Long id);
    TodoDto findById(Long id);
    List<TodoDto> findAll();
    List<TodoDto> findByStatut(String statut);
    List<TodoDto> findByPriorite(String priorite);
    List<TodoDto> findByTitreContaining(String titre);
    long countByStatut(TodoEntity.Statut statut);
}
