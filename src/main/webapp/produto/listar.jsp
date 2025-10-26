<%@ page import="br.cefetrj.model.Produto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Produto> produtos = (List<Produto>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Produtos - Cervejaria</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #FF6B35; }
        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; }
        .btn-primary { background: #FF6B35; color: white; }
        .btn-primary:hover { background: #e55a2a; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-danger:hover { background: #c82333; }
        .btn-edit { background: #ffc107; color: #333; }
        .btn-edit:hover { background: #e0a800; }
        .btn-back { background: #6c757d; color: white; }
        .btn-back:hover { background: #5a6268; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #FF6B35; color: white; font-weight: 500; }
        tr:hover { background: #f5f5f5; }
        .actions { display: flex; gap: 10px; }
        .badge { padding: 5px 10px; border-radius: 3px; font-size: 12px; font-weight: bold; }
        .badge-cerveja { background: #FFC107; color: #333; }
        .badge-comida { background: #4CAF50; color: white; }
        .badge-bebida { background: #2196F3; color: white; }
        .badge-outro { background: #6c757d; color: white; }
        .no-data { text-align: center; padding: 40px; color: #999; }
        .preco { color: #2e7d32; font-weight: bold; font-size: 1.1em; }
    </style>
</head>
<body>
<div class="container">
    <div class="header-actions">
        <h2>📦 Cardápio - Produtos</h2>
        <div>
            <a href="<%= request.getContextPath() %>/" class="btn btn-back">🏠 Voltar</a>
            <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary">➕ Novo Produto</a>
        </div>
    </div>

    <% if (produtos != null && !produtos.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Descrição</th>
            <th>Preço</th>
            <th>Categoria</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <% for (Produto p : produtos) { %>
        <tr>
            <td>#<%= p.getId() %></td>
            <td><strong><%= p.getNome() %></strong></td>
            <td><%= p.getDescricao() != null ? p.getDescricao() : "-" %></td>
            <td class="preco">
                <%= p.getPreco() != null ? String.format("R$ %.2f", p.getPreco()) : "-" %>
            </td>
            <td>
                <% 
                String categoria = p.getCategoria() != null ? p.getCategoria().toLowerCase() : "outro";
                String badgeClass = "badge-outro";
                String categoriaDisplay = p.getCategoria() != null ? p.getCategoria() : "Outro";
                
                if (categoria.contains("cerveja")) {
                    badgeClass = "badge-cerveja";
                } else if (categoria.contains("comida") || categoria.contains("petisco")) {
                    badgeClass = "badge-comida";
                } else if (categoria.contains("bebida") || categoria.contains("drink")) {
                    badgeClass = "badge-bebida";
                }
                %>
                <span class="badge <%= badgeClass %>"><%= categoriaDisplay %></span>
            </td>
            <td class="actions">
                <a href="<%= request.getAttribute("urlSubmit") %>?acao=buscar&id=<%= p.getId() %>" class="btn btn-edit">✏️ Editar</a>
                <a href="<%= request.getAttribute("urlSubmit") %>?acao=deletar&id=<%= p.getId() %>"
                   class="btn btn-danger"
                   onclick="return confirm('Tem certeza que deseja excluir este produto?')">🗑️ Excluir</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <div class="no-data">
        <p>📭 Nenhum produto cadastrado ainda.</p>
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary" style="margin-top: 20px;">Cadastrar primeiro produto</a>
    </div>
    <% } %>
</div>
</body>
</html>
