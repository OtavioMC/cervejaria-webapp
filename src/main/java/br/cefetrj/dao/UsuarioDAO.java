package br.cefetrj.dao;

import br.cefetrj.model.Usuario;
import br.cefetrj.utils.HibernateUtil;
import jakarta.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class UsuarioDAO extends GenericDAO<Usuario> {

    public UsuarioDAO() {
        super(Usuario.class);
    }
}
