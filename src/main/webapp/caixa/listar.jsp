<%@ page import="br.cefetrj.model.Caixa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Caixa> caixas = (List<Caixa>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Caixas - Cervejaria</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #4CAF50; }
        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; }
        .btn-primary { background: #4CAF50; color: white; }
        .btn-primary:hover { background: #45a049; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-danger:hover { background: #c82333; }
        .btn-edit { background: #ffc107; color: #333; }
        .btn-edit:hover { background: #e0a800; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #4CAF50; color: white; font-weight: 500; }
        tr:hover { background: #f5f5f5; }
        .actions { display: flex; gap: 10px; }
        .badge { padding: 5px 10px; border-radius: 3px; font-size: 12px; }
        .badge-success { background: #28a745; color: white; }
        .badge-danger { background: #dc3545; color: white; }
        .no-data { text-align: center; padding: 40px; color: #999; }
        .total-vendido { color: #2e7d32; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <div class="header-actions">
        <h2>💰 Operadores de Caixa</h2>
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary">➕ Novo Caixa</a>
    </div>

    <% if (caixas != null && !caixas.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Código</th>
            <th>Salário</th>
            <th>Total Vendido</th>
            <th>Status</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <% for (Caixa c : caixas) { %>
        <tr>
            <td>#<%= c.getId() %></td>
            <td><%= c.getNome() %></td>
            <td><%= c.getCodigo() %></td>
            <td><%= c.getSalario() != null ? String.format("R$ %.2f", c.getSalario()) : "-" %></td>
            <td class="total-vendido">
                <%= c.getTotalVendido() != null ? String.format("R$ %.2f", c.getTotalVendido()) : "R$ 0,00" %>
            </td>
            <td>
                <span class="badge <%= c.getAtivo() ? "badge-success" : "badge-danger" %>">
                    <%= c.getAtivo() ? "Ativo" : "Inativo" %>
                </span>
            </td>
            <td class="actions">
                <a href="<%= request.getAttribute("urlSubmit") %>?acao=buscar&id=<%= c.getId() %>" class="btn btn-edit">✏️ Editar</a>
                <a href="<%= request.getAttribute("urlSubmit") %>?acao=deletar&id=<%= c.getId() %>"
                   class="btn btn-danger"
                   onclick="return confirm('Tem certeza que deseja excluir este caixa?')">🗑️ Excluir</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <div class="no-data">
        <p>📭 Nenhum caixa cadastrado ainda.</p>
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary" style="margin-top: 20px;">Cadastrar primeiro caixa</a>
    </div>
    <% } %>
</div>
</body>
</html>