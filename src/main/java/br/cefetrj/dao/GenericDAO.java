package br.cefetrj.dao;

import java.util.List;

import br.cefetrj.model.Entidade;
import br.cefetrj.model.Usuario;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;

public abstract class GenericDAO<T extends Entidade> {
    private final Class<T> clazz; // precisamos guardar a classe real

    // construtor recebe a classe concreta
    public GenericDAO(Class<T> clazz) {
        this.clazz = clazz;
    }

    public void salvar(T entidade, Usuario usuario) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            entityManager.getTransaction().begin();
            // Só define o usuário se ele não for nulo
            if (usuario != null) {
                entidade.setCriadoPor(usuario);
            }
            entidade.setDataCriacao(java.time.LocalDate.now());
            entityManager.persist(entidade); // antes: save()
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    public void atualizar(T entidade, Usuario usuario) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        entityManager.getTransaction().begin();
        // Só define o usuário se ele não for nulo
        if (usuario != null) {
            entidade.setAlteradoPor(usuario);
        }
        entidade.setDataUltimaAlteracao(java.time.LocalDate.now());
        entityManager.merge(entidade); // antes: update()
        entityManager.getTransaction().commit();

    }

    public void deletar(int id) {

        EntityManager entityManager = HibernateUtil.getEntityManager();
        entityManager.getTransaction().begin();
        T usuario = entityManager.find(clazz, id);
        if (usuario != null) {
            entityManager.remove(usuario); // antes: delete()
        }
        entityManager.getTransaction().commit();

    }

    public T buscarPorId(int id) {
        try (EntityManager entityManager = HibernateUtil.getEntityManager()) {
            return entityManager.find(clazz, id);
        }
    }

    public List<T> listarTodos() {
        try (EntityManager entityManager = HibernateUtil.getEntityManager()) {
            return entityManager.createQuery("from " + clazz.getSimpleName(), clazz)
                    .getResultList();
        }
    }
}
