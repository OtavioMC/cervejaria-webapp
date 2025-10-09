package br.cefetrj.servlet.livro;

import java.io.IOException;
import java.util.List;

import br.cefetrj.dao.LivroDAO;
import br.cefetrj.model.Livro;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeletarLivroServlet")
public class DeletarLivroServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LivroDAO livroDAO = new LivroDAO();
        Integer id = Integer.parseInt(request.getParameter("id"));
        livroDAO.deletar(id);
        List<Livro> livros = livroDAO.listarTodos();
        request.setAttribute("livros", livros);
        RequestDispatcher rd = request.getRequestDispatcher("livro/listar-livros.jsp");
        rd.forward(request, response);
    }
}
