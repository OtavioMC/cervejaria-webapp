package br.cefetrj.servlet.editora;

import java.io.IOException;
import java.util.List;

import br.cefetrj.dao.EditoraDAO;
import br.cefetrj.model.Editora;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeletarEditoraServlet")
public class DeletarEditoraServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EditoraDAO editoraDAO = new EditoraDAO();
        Integer id = Integer.parseInt(request.getParameter("id"));
        Editora editora = editoraDAO.buscarPorId(id);
        editoraDAO.deletar(editora.getId());
        List<Editora> editoras = editoraDAO.listarTodos();
        request.setAttribute("editoras", editoras);
        RequestDispatcher rd = request.getRequestDispatcher("editora/listar-editoras.jsp");
        rd.forward(request, response);
    }
}
