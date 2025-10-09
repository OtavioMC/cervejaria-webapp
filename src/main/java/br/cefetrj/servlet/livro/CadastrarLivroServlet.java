package br.cefetrj.servlet.livro;

import java.io.IOException;
import java.util.List;
import br.cefetrj.dao.EditoraDAO;
import br.cefetrj.dao.LivroDAO;
import br.cefetrj.model.Editora;
import br.cefetrj.model.Livro;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CadastrarLivroServlet")
public class CadastrarLivroServlet extends HttpServlet {
    private static final long serialVersionUID = 3L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String titulo = request.getParameter("titulo");
        String autores = request.getParameter("autores");
        Integer anoPublicacao = Integer.parseInt(request.getParameter("anoPublicacao"));
        Integer idEditora = Integer.parseInt(request.getParameter("editoraId"));

        Livro livro = new Livro();
        livro.setTitulo(titulo);
        livro.setAutores(autores);
        livro.setAnoPublicacao(anoPublicacao);

        EditoraDAO editoraDAO = new EditoraDAO();
        Editora editora = editoraDAO.buscarPorId(idEditora);
        livro.setEditora(editora);

        // Aqui você pode adicionar o cliente a um banco de dados ou a uma lista
        LivroDAO dao = new LivroDAO();

        dao.salvar(livro, null);

        RequestDispatcher rd = request.getRequestDispatcher("livro/cadastro-sucesso.jsp");

        rd.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (request.getParameter("id") != null && request.getParameter("acao").equals("cadastrar")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            LivroDAO livroDAO = new LivroDAO();
            request.setAttribute("livro", livroDAO.buscarPorId(id));

        }

        EditoraDAO editoraDAO = new EditoraDAO();
        List<Editora> editoras;

        editoras = editoraDAO.listarTodos();
        request.setAttribute("editoras", editoras);
        RequestDispatcher rd = request.getRequestDispatcher("livro/form-livro.jsp");
        rd.forward(request, response);
    }

}