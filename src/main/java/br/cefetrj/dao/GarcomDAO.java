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

    public List<Garcom> buscarPorTurno(String turno) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT g FROM Garcom g WHERE g.turno = :turno AND g.ativo = true ORDER BY g.nome",
                            Garcom.class)
                    .setParameter("turno", turno)
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

    public boolean matriculaExiste(String matricula, Integer idExcluir) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            String query = "SELECT COUNT(g) FROM Garcom g WHERE g.matricula = :matricula";
            if (idExcluir != null) {
                query += " AND g.id != :id";
            }

            var q = em.createQuery(query, Long.class)
                    .setParameter("matricula", matricula);

            if (idExcluir != null) {
                q.setParameter("id", idExcluir);
            }

            return q.getSingleResult() > 0;
        }
    }
}