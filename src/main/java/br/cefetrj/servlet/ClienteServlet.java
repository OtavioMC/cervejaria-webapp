package br.cefetrj.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.cefetrj.dao.ClienteDAO;
import br.cefetrj.model.Cliente;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Cliente")
public class ClienteServlet extends HttpServlet {
    private static final long serialVersionUID = 3L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String nome = request.getParameter("nome");
        Integer idade = Integer.parseInt(request.getParameter("idade"));

        Cliente cliente = new Cliente(null, nome, idade);
        // Aqui você pode adicionar o cliente a um banco de dados ou a uma lista
        ClienteDAO dao = new ClienteDAO();
        try {
            dao.inserir(cliente);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        RequestDispatcher rd = request.getRequestDispatcher("cadastro-sucesso.jsp");

        rd.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        ClienteDAO dao = new ClienteDAO();
        List<Cliente> clientes;
        try {
            clientes = dao.listarTodos();
            request.setAttribute("clientes", clientes);
            RequestDispatcher rd = request.getRequestDispatcher("lista-clientes.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private List<Cliente> criaClientes() {
        List<Cliente> clientes = new ArrayList<>();
        Cliente cliente1 = new Cliente(1, "Cliente 1", 23);
        Cliente cliente2 = new Cliente(2, "Cliente 2", 19);
        Cliente cliente3 = new Cliente(3, "Cliente 3", 25);
        clientes.add(cliente1);
        clientes.add(cliente2);
        clientes.add(cliente3);
        return clientes;
    }
}
