<%@ page import="br.cefetrj.model.Produto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Produto> produtos = (List<Produto>) request.getAttribute("lista");
    String contextPath = request.getContextPath();
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
        .btn-primary:hover { background: #e85a2a; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-danger:hover { background: #c82333; }
        .btn-edit { background: #ffc107; color: #333; }
        .btn-edit:hover { background: #e0a800; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #FF6B35; color: white; font-weight: 500; }
        tr:hover { background: #f5f5f5; }
        .actions { display: flex; gap: 10px; }
        .badge { padding: 5px 10px; border-radius: 3px; font-size: 12px; }
        .badge-success { background: #28a745; color: white; }
        .badge-danger { background: #dc3545; color: white; }+
        .no-data { text-align: center; padding: 40px; color: #999; }
        .price { color: #28a745; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <div class="header-actions">
        <h2>📦 Produtos do Cardápio</h2>
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary">➕ Novo Produto</a>
    </div>

    <% if (produtos != null && !produtos.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Categoria</th>
            <th>Preço</th>
            <th>Status</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <% for (Produto p : produtos) { %>
        <tr>
            <td>#<%= p.getId() %></td>
            <td><%= p.getNome() %></td>
            <td><%= p.getCategoria() %></td>
            <td class="price">R$ <%= String.format("%.2f", p.getPreco()) %></td>
            <td>
                <span class="badge <%= p.getDisponivel() ? "badge-success" : "badge-danger" %>">
                    <%= p.getDisponivel() ? "Disponível" : "Indisponível" %>
                </span>
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