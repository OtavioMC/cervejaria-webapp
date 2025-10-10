package br.cefetrj.servlet;

import br.cefetrj.dao.GenericDAO;
import br.cefetrj.model.Entidade;
import br.cefetrj.model.Usuario;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.lang.reflect.ParameterizedType;
import java.util.List;

public abstract class GenericServlet<T extends Entidade> extends HttpServlet {

    protected GenericDAO<T> dao;
    private Class<T> clazz;

    @SuppressWarnings("unchecked")
    public GenericServlet() {
        this.clazz = (Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0];
        this.dao = new GenericDAO<T>(clazz) {
        };
    }

    // método utilitário para pegar o usuário logado
    protected Usuario getUsuarioLogado(HttpServletRequest request) {
        return (Usuario) request.getSession().getAttribute("usuarioLogado");
    }

    // método abstrato que cada servlet concreto implementa
    protected abstract T preencherEntidade(HttpServletRequest request);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String acao = request.getParameter("acao");
        if (acao == null)
            acao = "listar"; // comportamento padrão
        Usuario usuario = getUsuarioLogado(request);
        String urlSubmit = request.getContextPath() + "/" + clazz.getSimpleName().toLowerCase();
        request.setAttribute("urlSubmit", urlSubmit);

        if (usuario == null) {
            /**
             * Implementar redirecionamento para página de acesso negado. Faremos mais para
             * frente
             * response.sendRedirect("acesso-negado.jsp");
             * return;
             */
        }
        try {
            switch (acao) {
                case "deletar":
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.deletar(id);
                    response.sendRedirect(urlSubmit + "?acao=listar");
                    break;

                case "listar":
                    List<T> lista = dao.listarTodos();
                    request.setAttribute("lista", lista);
                    try {
                        request.getRequestDispatcher("/" + clazz.getSimpleName().toLowerCase() + "/listar.jsp")
                                .forward(request, response);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case "buscar":
                    int idBuscar = Integer.parseInt(request.getParameter("id"));
                    T entidade = dao.buscarPorId(idBuscar);
                    request.setAttribute("entidade", entidade);
                    try {
                        request.getRequestDispatcher("/" + clazz.getSimpleName().toLowerCase() + "/form.jsp")
                                .forward(request, response);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                case "novo":
                    try {
                        request.getRequestDispatcher("/" + clazz.getSimpleName().toLowerCase() + "/form.jsp")
                                .forward(request, response);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String acao = request.getParameter("acao");
        Usuario usuario = getUsuarioLogado(request);
        String urlSubmit = request.getContextPath() + "/" + clazz.getSimpleName().toLowerCase();
        request.setAttribute("urlSubmit", urlSubmit);
        try {
            switch (acao) {
                case "cadastrar":
                    T entidade = preencherEntidade(request);
                    dao.salvar(entidade, usuario);
                    break;
                case "editar":
                    T entidadeAtualizada = preencherEntidade(request);
                    dao.atualizar(entidadeAtualizada, usuario);
                    break;
            }
            response.sendRedirect(urlSubmit + "?acao=listar");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }
}
