package br.cefetrj.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public List<Cliente> listarTodos() throws SQLException {

        String sql = "select id, nome, idade from cliente";
        PreparedStatement stmt = con.prepareStatement(sql);

        ResultSet rs = stmt.executeQuery();
        Cliente cliente = null;

        List<Cliente> clientes = new ArrayList<Cliente>();
        while (rs.next()) {
            cliente = new Cliente(Integer.valueOf(rs.getInt("id")), rs.getString("nome"), rs.getInt("idade"));

            clientes.add(cliente);
        }

        stmt.close();
        con.close();
        return clientes;
    }

}
