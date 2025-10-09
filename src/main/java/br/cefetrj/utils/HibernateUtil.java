package br.cefetrj.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class HibernateUtil {
    /*
     * A persistence unit name (no) deve estar no arquivo
     * src/main/resources/META-INF/persistence.xml
     */
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("meuPU");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}
