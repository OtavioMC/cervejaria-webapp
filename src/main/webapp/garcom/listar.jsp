<%@ page import="br.cefetrj.model.Garcom" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  List<Garcom> garcons = (List<Garcom>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Garçons - Cervejaria</title>
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
    .badge-danger { background: #dc3545; color: white; }
    .no-data { text-align: center; padding: 40px; color: #999; }
  </style>
</head>
<body>
<div class="container">
  <div class="header-actions">
    <h2>🍺 Garçons</h2>
    <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary">➕ Novo Garçom</a>
  </div>

  <% if (garcons != null && !garcons.isEmpty()) { %>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>Nome</th>
      <th>Matrícula</th>
      <th>Turno</th>
      <th>Salário</th>
      <th>Status</th>
      <th>Ações</th>
    </tr>
    </thead>
    <tbody>
    <% for (Garcom g : garcons) { %>
    <tr>
      <td>#<%= g.getId() %></td>
      <td><%= g.getNome() %></td>
      <td><%= g.getMatricula() %></td>
      <td><%= g.getTurno() != null ? g.getTurno() : "-" %></td>
      <td><%= g.getSalario() != null ? String.format("R$ %.2f", g.getSalario()) : "-" %></td>
      <td>
                <span class="badge <%= g.getAtivo() ? "badge-success" : "badge-danger" %>">
                    <%= g.getAtivo() ? "Ativo" : "Inativo" %>
                </span>
      </td>
      <td class="actions">
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=buscar&id=<%= g.getId() %>" class="btn btn-edit">✏️ Editar</a>
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=deletar&id=<%= g.getId() %>"
           class="btn btn-danger"
           onclick="return confirm('Tem certeza que deseja excluir este garçom?')">🗑️ Excluir</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } else { %>
  <div class="no-data">
    <p>📭 Nenhum garçom cadastrado ainda.</p>
    <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary" style="margin-top: 20px;">Cadastrar primeiro garçom</a>
  </div>
  <% } %>
</div>
</body>
</html>