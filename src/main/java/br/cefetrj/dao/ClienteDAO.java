package br.cefetrj.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.cefetrj.commons.ConnectionFactory;
import br.cefetrj.model.Cliente;

public class ClienteDAO {

    private Connection con;

    public ClienteDAO() {
        con = ConnectionFactory.getConnection();
    }

    public void inserir(Cliente cliente) throws SQLException {
        String sql = "insert into cliente(nome) values(?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, cliente.nome);
        stmt.execute();
        stmt.close();
        con.close();
    }

}
