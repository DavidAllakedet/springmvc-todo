package com.todo.app.mapper;

import com.todo.app.dto.TodoDto;
import com.todo.app.entities.TodoEntity;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class TodoMapper {

    public static TodoDto toTodoDto(TodoEntity entity) {
        if (entity == null) return null;
        return new TodoDto(
                entity.getId(),
                entity.getTitre(),
                entity.getDescription(),
                entity.getPriorite() != null ? entity.getPriorite().name() : null,
                entity.getStatut() != null ? entity.getStatut().name() : null,
                entity.getDateEcheance(),
                entity.getDateCreation()
        );
    }

    public static TodoEntity toTodoEntity(TodoDto dto) {
        if (dto == null) return null;
        TodoEntity entity = new TodoEntity();
        entity.setId(dto.getId());
        entity.setTitre(dto.getTitre());
        entity.setDescription(dto.getDescription());
        if (dto.getPriorite() != null) {
            entity.setPriorite(TodoEntity.Priorite.valueOf(dto.getPriorite()));
        }
        if (dto.getStatut() != null) {
            entity.setStatut(TodoEntity.Statut.valueOf(dto.getStatut()));
        }
        entity.setDateEcheance(dto.getDateEcheance());
        entity.setDateCreation(dto.getDateCreation());
        return entity;
    }

    public static List<TodoDto> toListTodoDto(List<TodoEntity> entities) {
        if (entities == null) return new ArrayList<>();
        return entities.stream()
                .map(TodoMapper::toTodoDto)
                .collect(Collectors.toList());
    }
}
