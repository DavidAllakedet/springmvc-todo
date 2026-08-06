package com.todo.app.service;

import com.todo.app.dao.ITodoDao;
import com.todo.app.dao.TodoDao;
import com.todo.app.dto.TodoDto;
import com.todo.app.entities.TodoEntity;
import com.todo.app.mapper.TodoMapper;

import java.util.List;

public class TodoService implements ITodoService {

    private final ITodoDao todoDao = new TodoDao();

    @Override
    public TodoDto save(TodoDto todoDto) {
        TodoEntity entity = TodoMapper.toTodoEntity(todoDto);
        todoDao.save(entity);
        return TodoMapper.toTodoDto(entity);
    }

    @Override
    public TodoDto update(TodoDto todoDto) {
        TodoEntity entity = TodoMapper.toTodoEntity(todoDto);
        todoDao.update(entity);
        return TodoMapper.toTodoDto(entity);
    }

    @Override
    public void delete(Long id) {
        todoDao.delete(id);
    }

    @Override
    public TodoDto findById(Long id) {
        TodoEntity entity = todoDao.findById(id);
        return TodoMapper.toTodoDto(entity);
    }

    @Override
    public List<TodoDto> findAll() {
        return TodoMapper.toListTodoDto(todoDao.findAll());
    }

    @Override
    public List<TodoDto> findByStatut(String statut) {
        TodoEntity.Statut s = TodoEntity.Statut.valueOf(statut);
        return TodoMapper.toListTodoDto(todoDao.findByStatut(s));
    }

    @Override
    public List<TodoDto> findByPriorite(String priorite) {
        TodoEntity.Priorite p = TodoEntity.Priorite.valueOf(priorite);
        return TodoMapper.toListTodoDto(todoDao.findByPriorite(p));
    }

    @Override
    public long countByStatut(TodoEntity.Statut statut) {
        return todoDao.findByStatut(statut).size();
    }
}
