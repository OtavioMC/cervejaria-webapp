package br.cefetrj.servlet;

import br.cefetrj.dao.GarcomDAO;
import br.cefetrj.dao.PedidoDAO;
import br.cefetrj.model.Garcom;
import br.cefetrj.model.Pedido;
import br.cefetrj.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/pedido")
public class PedidoServlet extends HttpServlet {

    private PedidoDAO pedidoDAO = new PedidoDAO();
    private GarcomDAO garcomDAO = new GarcomDAO();

    protected Usuario getUsuarioLogado(HttpServletRequest request) {
        // Simulação - em produção viria da sessão
        Usuario usuario = new Usuario();
        usuario.setId(1);
        usuario.setNome("Usuário Teste");
        return usuario;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String acao = request.getParameter("acao");
        if (acao == null) acao = "listar";

        String contextPath = request.getContextPath();
        String urlSubmit = contextPath + "/pedido";
        request.setAttribute("urlSubmit", urlSubmit);

        try {
            switch (acao) {
                case "listar":
                    List<Pedido> pedidos = pedidoDAO.listarTodos();
                    request.setAttribute("lista", pedidos);
                    request.getRequestDispatcher("/pedido/listar.jsp").forward(request, response);
                    break;

                case "novo":
                    carregarGarcons(request);
                    request.getRequestDispatcher("/pedido/form.jsp").forward(request, response);
                    break;

                case "buscar":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Pedido pedido = pedidoDAO.buscarPorId(id);
                    request.setAttribute("entidade", pedido);
                    carregarGarcons(request);
                    request.getRequestDispatcher("/pedido/form.jsp").forward(request, response);
                    break;

                case "deletar":
                    int idDeletar = Integer.parseInt(request.getParameter("id"));
                    pedidoDAO.deletar(idDeletar);
                    response.sendRedirect(urlSubmit + "?acao=listar");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/erro.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String acao = request.getParameter("acao");
        Usuario usuario = getUsuarioLogado(request);
        String urlSubmit = request.getContextPath() + "/pedido";

        try {
            switch (acao) {
                case "cadastrar":
                    Pedido pedido = preencherPedido(request);
                    pedidoDAO.salvar(pedido, usuario);
                    break;

                case "editar":
                    Pedido pedidoAtualizado = preencherPedido(request);
                    pedidoDAO.atualizar(pedidoAtualizado, usuario);
                    break;
            }
            response.sendRedirect(urlSubmit + "?acao=listar");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/erro.jsp");
        }
    }

    private Pedido preencherPedido(HttpServletRequest request) {
        Pedido pedido = new Pedido();

        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            pedido.setId(Integer.parseInt(id));
        }

        String numeroMesa = request.getParameter("numeroMesa");
        pedido.setNumeroMesa(Integer.parseInt(numeroMesa));

        String garcomId = request.getParameter("garcomId");
        Garcom garcom = garcomDAO.buscarPorId(Integer.parseInt(garcomId));
        pedido.setGarcom(garcom);

        pedido.setObservacoes(request.getParameter("observacoes"));
        pedido.setStatus(request.getParameter("status"));

        if (id == null || id.isEmpty()) {
            pedido.setDataHoraPedido(LocalDateTime.now());
        }

        return pedido;
    }

    private void carregarGarcons(HttpServletRequest request) {
        List<Garcom> garcons = garcomDAO.buscarAtivos();
        request.setAttribute("garcons", garcons);
    }
}