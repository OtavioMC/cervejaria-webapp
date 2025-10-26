package br.cefetrj.dao;

import br.cefetrj.model.Garcom;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class GarcomDAO extends GenericDAO<Garcom> {

    public GarcomDAO() {
        super(Garcom.class);
    }
    public List<Garcom> buscarAtivos() {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT g FROM Garcom g WHERE g.ativo = true ORDER BY g.nome",
                            Garcom.class)
                    .getResultList();
        }
    }

    public Garcom buscarPorMatricula(String matricula) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            List<Garcom> garcons = em.createQuery(
                            "SELECT g FROM Garcom g WHERE g.matricula = :matricula",
                            Garcom.class)
                    .setParameter("matricula", matricula)
                    .getResultList();
            return garcons.isEmpty() ? null : garcons.get(0);
        }
    }

    public List<Garcom> buscarPorTurno(String turno) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT g FROM Garcom g WHERE g.turno = :turno AND g.ativo = true ORDER BY g.nome",
                            Garcom.class)
                    .setParameter("turno", turno)
                    .getResultList();
        }
    }

    public void alterarStatus(Integer id, boolean ativo) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Garcom garcom = em.find(Garcom.class, id);
            if (garcom != null) {
                garcom.setAtivo(ativo);
                em.merge(garcom);
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

    public boolean matriculaExiste(String matricula) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            Long count = em.createQuery(
                            "SELECT COUNT(g) FROM Garcom g WHERE g.matricula = :matricula",
                            Long.class)
                    .setParameter("matricula", matricula)
                    .getSingleResult();
            return count > 0;
        }
    }
}
