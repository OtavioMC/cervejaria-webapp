package br.cefetrj.servlet;

import br.cefetrj.dao.ProdutoDAO;
import br.cefetrj.model.Produto;
import br.cefetrj.servlet.GenericServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

@WebServlet("/produto")
public class ProdutoServlet extends GenericServlet<Produto> {

    private ProdutoDAO produtoDAO = new ProdutoDAO();

    public ProdutoServlet() {
        super();
        this.dao = produtoDAO;
    }

    @Override
    protected Produto preencherEntidade(HttpServletRequest request) {
        Produto produto = new Produto();

        String id = request.getParameter("id");
        produto.setId(id != null && !id.isEmpty() ? Integer.parseInt(id) : null);

        produto.setNome(request.getParameter("nome"));
        produto.setDescricao(request.getParameter("descricao"));
        produto.setPreco(new BigDecimal(request.getParameter("preco")));
        produto.setCategoria(request.getParameter("categoria"));
        produto.setDisponivel(request.getParameter("disponivel") != null);
        produto.setImagemUrl(request.getParameter("imagemUrl"));

        return produto;
    }
}