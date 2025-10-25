package br.cefetrj.dao;

import br.cefetrj.model.Produto;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ProdutoDAO extends GenericDAO<Produto> {

    public ProdutoDAO() {
        super(Produto.class);
    }

    public List<Produto> buscarPorCategoria(String categoria) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT p FROM Produto p WHERE p.categoria = :categoria AND p.disponivel = true",
                            Produto.class)
                    .setParameter("categoria", categoria)
                    .getResultList();
        }
    }

    public List<Produto> buscarDisponiveis() {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT p FROM Produto p WHERE p.disponivel = true ORDER BY p.categoria, p.nome",
                            Produto.class)
                    .getResultList();
        }
    }
}