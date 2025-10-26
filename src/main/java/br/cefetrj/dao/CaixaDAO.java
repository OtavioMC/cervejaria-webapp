package br.cefetrj.dao;

import br.cefetrj.model.Caixa;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.math.BigDecimal;
import java.util.List;

public class CaixaDAO extends GenericDAO<Caixa> {

    public CaixaDAO() {
        super(Caixa.class);
    }

    public List<Caixa> buscarAtivos() {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT c FROM Caixa c WHERE c.ativo = true ORDER BY c.nome",
                            Caixa.class)
                    .getResultList();
        }
    }

    public Caixa buscarPorCodigo(String codigo) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            List<Caixa> caixas = em.createQuery(
                            "SELECT c FROM Caixa c WHERE c.codigo = :codigo",
                            Caixa.class)
                    .setParameter("codigo", codigo)
                    .getResultList();
            return caixas.isEmpty() ? null : caixas.get(0);
        }
    }

    public boolean codigoExiste(String codigo, Integer idExcluir) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            String query = "SELECT COUNT(c) FROM Caixa c WHERE c.codigo = :codigo";
            if (idExcluir != null) {
                query += " AND c.id != :id";
            }

            var q = em.createQuery(query, Long.class)
                    .setParameter("codigo", codigo);

            if (idExcluir != null) {
                q.setParameter("id", idExcluir);
            }

            return q.getSingleResult() > 0;
        }
    }

    public void atualizarTotalVendido(Integer caixaId, BigDecimal valorVenda) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Caixa caixa = em.find(Caixa.class, caixaId);
            if (caixa != null) {
                BigDecimal totalAtual = caixa.getTotalVendido() != null ?
                        caixa.getTotalVendido() : BigDecimal.ZERO;
                caixa.setTotalVendido(totalAtual.add(valorVenda));
                em.merge(caixa);
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

    public List<Caixa> buscarRankingVendas(int limite) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT c FROM Caixa c WHERE c.ativo = true " +
                                    "ORDER BY c.totalVendido DESC",
                            Caixa.class)
                    .setMaxResults(limite)
                    .getResultList();
        }
    }
}