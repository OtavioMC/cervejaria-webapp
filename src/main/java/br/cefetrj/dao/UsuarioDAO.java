package br.cefetrj.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.cefetrj.model.Usuario;
import br.cefetrj.utils.HibernateUtil;

import java.util.List;

public class UsuarioDAO {

    public void salvar(Usuario usuario) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(usuario);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public List<Usuario> listar() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Usuario", Usuario.class).list();
        }
    }
}
