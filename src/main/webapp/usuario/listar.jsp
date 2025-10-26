<%@ page import="br.cefetrj.model.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  List<Usuario> usuarios = (List<Usuario>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Usuários - Cervejaria</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
    .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h2 { color: #333; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #2196F3; }
    .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; }
    .btn-primary { background: #2196F3; color: white; }
    .btn-primary:hover { background: #1976D2; }
    .btn-danger { background: #dc3545; color: white; }
    .btn-danger:hover { background: #c82333; }
    .btn-edit { background: #ffc107; color: #333; }
    .btn-edit:hover { background: #e0a800; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
    th { background: #2196F3; color: white; font-weight: 500; }
    tr:hover { background: #f5f5f5; }
    .actions { display: flex; gap: 10px; }
    .badge { padding: 5px 10px; border-radius: 3px; font-size: 12px; }
    .badge-success { background: #28a745; color: white; }
    .badge-danger { background: #dc3545; color: white; }
    .badge-admin { background: #9c27b0; color: white; }
    .badge-gerente { background: #ff9800; color: white; }
    .badge-usuario { background: #607d8b; color: white; }
    .no-data { text-align: center; padding: 40px; color: #999; }
  </style>
</head>
<body>
<div class="container">
  <div class="header-actions">
    <h2>👥 Usuários do Sistema</h2>
    <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary">➕ Novo Usuário</a>
  </div>

  <% if (usuarios != null && !usuarios.isEmpty()) { %>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>Nome</th>
      <th>E-mail</th>
      <th>Papel</th>
      <th>Status</th>
      <th>Ações</th>
    </tr>
    </thead>
    <tbody>
    <% for (Usuario u : usuarios) { %>
    <tr>
      <td>#<%= u.getId() %></td>
      <td><%= u.getNome() %></td>
      <td><%= u.getEmail() != null ? u.getEmail() : "-" %></td>
      <td>
        <%
          String papel = u.getPapel() != null ? u.getPapel() : "";
          String badgeClass = "badge-usuario";
          if ("ADMIN".equals(papel)) badgeClass = "badge-admin";
          else if ("GERENTE".equals(papel)) badgeClass = "badge-gerente";
        %>
        <span class="badge <%= badgeClass %>">
                    <%= papel.isEmpty() ? "Usuário" : papel %>
                </span>
      </td>
      <td>
                <span class="badge <%= u.getAtivo() ? "badge-success" : "badge-danger" %>">
                    <%= u.getAtivo() ? "Ativo" : "Inativo" %>
                </span>
      </td>
      <td class="actions">
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=buscar&id=<%= u.getId() %>" class="btn btn-edit">✏️ Editar</a>
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=deletar&id=<%= u.getId() %>"
           class="btn btn-danger"
           onclick="return confirm('Tem certeza que deseja excluir este usuário?')">🗑️ Excluir</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } else { %>
  <div class="no-data">
    <p>📭 Nenhum usuário cadastrado ainda.</p>
    <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary" style="margin-top: 20px;">Cadastrar primeiro usuário</a>
  </div>
  <% } %>
</div>
</body>
</html>