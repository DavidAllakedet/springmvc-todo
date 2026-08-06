package com.todo.app.dao;

import com.todo.app.entities.TodoEntity;

import java.util.List;

public interface ITodoDao extends Repository<TodoEntity> {
    List<TodoEntity> findByStatut(TodoEntity.Statut statut);
    List<TodoEntity> findByPriorite(TodoEntity.Priorite priorite);
}
