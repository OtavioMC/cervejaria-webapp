package br.cefetrj.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.cefetrj.model.Entidade;
import br.cefetrj.model.Usuario;
import br.cefetrj.utils.HibernateUtil;

public abstract class GenericDAO<T extends Entidade> {
    private final Class<T> clazz; // precisamos guardar a classe real

    // construtor recebe a classe concreta
    public GenericDAO(Class<T> clazz) {
        this.clazz = clazz;
    }

    public void salvar(T entidade) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(entidade); // antes: save()
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public void atualizar(T entidade) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(entidade); // antes: update()
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public void deletar(int id) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            T usuario = session.find(clazz, id);
            if (usuario != null) {
                session.remove(usuario); // antes: delete()
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public T buscarPorId(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(clazz, id);
        }
    }

    public List<T> listarTodos() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from " + clazz.getSimpleName(), clazz)
                    .getResultList();
        }
    }
}
