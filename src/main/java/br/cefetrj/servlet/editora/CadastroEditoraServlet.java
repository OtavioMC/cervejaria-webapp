package br.cefetrj.servlet.editora;

import java.io.IOException;

import br.cefetrj.dao.EditoraDAO;
import br.cefetrj.model.Editora;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CadastroEditoraServlet")
public class CadastroEditoraServlet extends HttpServlet {
    private static final long serialVersionUID = 4L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String nome = request.getParameter("nome");

        Editora editora = new Editora();
        editora.setNome(nome);

        // Aqui você pode adicionar o cliente a um banco de dados ou a uma lista
        EditoraDAO dao = new EditoraDAO();

        dao.salvar(editora, null);

        RequestDispatcher rd = request.getRequestDispatcher("cadastro-sucesso.jsp");

        rd.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (request.getParameter("id") != null && request.getParameter("acao").equals("cadastrar")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            EditoraDAO editoraDAO = new EditoraDAO();
            request.setAttribute("editora", editoraDAO.buscarPorId(id));

        }

        RequestDispatcher rd = request.getRequestDispatcher("editora/form-editora.jsp");
        rd.forward(request, response);
    }

}
