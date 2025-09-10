package br.cefetrj.servlet;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/PrimeiroServlet")
public class PrimeiroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h1>Olá, mundo! Este é um Servlet.</h1>");
        response.getWriter().println("</body></html>");
    }
}
