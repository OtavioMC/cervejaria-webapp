package br.cefetrj.servlet;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Cadastro")
public class CadastroServlet extends HttpServlet {
    private static final long serialVersionUID = 2L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println("<html><body>");
        response.getWriter().println("Nome: " + request.getParameter("nome") + "<br>");
        response.getWriter().println("Idade: " + request.getParameter("idade") + "<br>");
        response.getWriter().println("</body></html>");
    }
}
