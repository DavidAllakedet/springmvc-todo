package com.todo.app.dao;

import com.todo.app.config.HibernateUtil;
import com.todo.app.entities.TodoEntity;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class TodoDao extends RepositoryImpl<TodoEntity> implements ITodoDao {

    public TodoDao() {
        super(TodoEntity.class);
    }

    @Override
    public List<TodoEntity> findByStatut(TodoEntity.Statut statut) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<TodoEntity> query = session.createQuery(
                    "FROM TodoEntity t WHERE t.statut = :statut ORDER BY t.dateEcheance ASC", TodoEntity.class);
            query.setParameter("statut", statut);
            return query.list();
        }
    }

    @Override
    public List<TodoEntity> findByPriorite(TodoEntity.Priorite priorite) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<TodoEntity> query = session.createQuery(
                    "FROM TodoEntity t WHERE t.priorite = :priorite ORDER BY t.dateEcheance ASC", TodoEntity.class);
            query.setParameter("priorite", priorite);
            return query.list();
        }
    }

    @Override
    public List<TodoEntity> findByTitreContaining(String titre) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<TodoEntity> query = session.createQuery(
                    "FROM TodoEntity t WHERE LOWER(t.titre) LIKE LOWER(:titre) ORDER BY t.dateCreation DESC", TodoEntity.class);
            query.setParameter("titre", "%" + titre + "%");
            return query.list();
        }
    }
}
