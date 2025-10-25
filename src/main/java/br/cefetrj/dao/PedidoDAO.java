package br.cefetrj.dao;

import br.cefetrj.model.Pedido;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class PedidoDAO extends GenericDAO<Pedido> {

    public PedidoDAO() {
        super(Pedido.class);
    }

    public List<Pedido> buscarPorStatus(String status) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT p FROM Pedido p WHERE p.status = :status ORDER BY p.dataHoraPedido DESC",
                            Pedido.class)
                    .setParameter("status", status)
                    .getResultList();
        }
    }

    public List<Pedido> buscarPorMesa(Integer numeroMesa) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT p FROM Pedido p WHERE p.numeroMesa = :mesa ORDER BY p.dataHoraPedido DESC",
                            Pedido.class)
                    .setParameter("mesa", numeroMesa)
                    .getResultList();
        }
    }

    public List<Pedido> buscarAbertos() {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT p FROM Pedido p WHERE p.status = 'ABERTO' ORDER BY p.dataHoraPedido DESC",
                            Pedido.class)
                    .getResultList();
        }
    }
}