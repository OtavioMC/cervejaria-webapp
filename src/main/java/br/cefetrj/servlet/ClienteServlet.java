package br.cefetrj.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println("<html><body>");
        response.getWriter().println("Nome: " + request.getParameter("nome") + "<br>");
        response.getWriter().println("Idade: " + request.getParameter("idade") + "<br>");
        response.getWriter().println("</body></html>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        List<Cliente> clientes = criaClientes();
        request.setAttribute("clientes", clientes);
        RequestDispatcher rd = request.getRequestDispatcher("lista-clientes.jsp");

        rd.forward(request, response);
    }

    private List<Cliente> criaClientes() {
        List<Cliente> clientes = new ArrayList<>();
        Cliente cliente1 = new Cliente("Cliente 1", 23);
        Cliente cliente2 = new Cliente("Cliente 2", 19);
        Cliente cliente3 = new Cliente("Cliente 3", 25);
        clientes.add(cliente1);
        clientes.add(cliente2);
        clientes.add(cliente3);
        return clientes;
    }
}
