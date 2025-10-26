package br.cefetrj.dao;

import br.cefetrj.model.Usuario;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class UsuarioDAO extends GenericDAO<Usuario> {

    public UsuarioDAO() {
        super(Usuario.class);
    }

    public Usuario buscarPorEmail(String email) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            List<Usuario> usuarios = em.createQuery(
                            "SELECT u FROM Usuario u WHERE u.email = :email",
                            Usuario.class)
                    .setParameter("email", email)
                    .getResultList();
            return usuarios.isEmpty() ? null : usuarios.get(0);
        }
    }

    public Usuario buscarPorCpf(Long cpf) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            List<Usuario> usuarios = em.createQuery(
                            "SELECT u FROM Usuario u WHERE u.cpf = :cpf",
                            Usuario.class)
                    .setParameter("cpf", cpf)
                    .getResultList();
            return usuarios.isEmpty() ? null : usuarios.get(0);
        }
    }

    public Usuario autenticar(String email, String senha) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            List<Usuario> usuarios = em.createQuery(
                            "SELECT u FROM Usuario u WHERE u.email = :email AND u.senha = :senha AND u.ativo = true",
                            Usuario.class)
                    .setParameter("email", email)
                    .setParameter("senha", senha)
                    .getResultList();
            return usuarios.isEmpty() ? null : usuarios.get(0);
        }
    }

    public boolean emailExiste(String email, Integer idExcluir) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            String query = "SELECT COUNT(u) FROM Usuario u WHERE u.email = :email";
            if (idExcluir != null) {
                query += " AND u.id != :id";
            }

            var q = em.createQuery(query, Long.class)
                    .setParameter("email", email);

            if (idExcluir != null) {
                q.setParameter("id", idExcluir);
            }

            return q.getSingleResult() > 0;
        }
    }

    public List<Usuario> buscarAtivos() {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT u FROM Usuario u WHERE u.ativo = true ORDER BY u.nome",
                            Usuario.class)
                    .getResultList();
        }
    }

    public List<Usuario> buscarPorPapel(String papel) {
        try (EntityManager em = HibernateUtil.getEntityManager()) {
            return em.createQuery(
                            "SELECT u FROM Usuario u WHERE u.papel = :papel ORDER BY u.nome",
                            Usuario.class)
                    .setParameter("papel", papel)
                    .getResultList();
        }
    }

    public boolean alterarSenha(Integer usuarioId, String senhaAntiga, String senhaNova) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Usuario usuario = em.find(Usuario.class, usuarioId);

            if (usuario != null && usuario.getSenha().equals(senhaAntiga)) {
                usuario.setSenha(senhaNova);
                em.merge(usuario);
                em.getTransaction().commit();
                return true;
            }

            em.getTransaction().rollback();
            return false;
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