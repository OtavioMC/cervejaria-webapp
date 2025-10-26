package br.cefetrj.dao;

import br.cefetrj.model.ItemPedido;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ItemPedidoDAO {

    public void salvar(ItemPedido item) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(item);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public void atualizar(ItemPedido item) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(item);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public void deletar(Integer id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            ItemPedido item = em.find(ItemPedido.class, id);
            if (item != null) {
                em.remove(item);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public ItemPedido buscarPorId(Integer id) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.find(ItemPedido.class, id);
        }
    }

    public List<ItemPedido> buscarPorPedido(Integer pedidoId) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT i FROM ItemPedido i WHERE i.pedido.id = :pedidoId",
                            ItemPedido.class)
                    .setParameter("pedidoId", pedidoId)
                    .getResultList();
        }
    }

    public List<ItemPedido> buscarPorPedidoComProduto(Integer pedidoId) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT i FROM ItemPedido i " +
                                    "JOIN FETCH i.produto " +
                                    "WHERE i.pedido.id = :pedidoId",
                            ItemPedido.class)
                    .setParameter("pedidoId", pedidoId)
                    .getResultList();
        }
    }

    public List<Object[]> buscarProdutosMaisVendidos(int limite) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT i.produto.nome, SUM(i.quantidade) as total " +
                                    "FROM ItemPedido i " +
                                    "GROUP BY i.produto.id, i.produto.nome " +
                                    "ORDER BY total DESC",
                            Object[].class)
                    .setMaxResults(limite)
                    .getResultList();
        }
    }

    public Long contarItensPedido(Integer pedidoId) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT COUNT(i) FROM ItemPedido i WHERE i.pedido.id = :pedidoId",
                            Long.class)
                    .setParameter("pedidoId", pedidoId)
                    .getSingleResult();
        }
    }

    public void deletarTodosPorPedido(Integer pedidoId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("DELETE FROM ItemPedido i WHERE i.pedido.id = :pedidoId")
                    .setParameter("pedidoId", pedidoId)
                    .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}