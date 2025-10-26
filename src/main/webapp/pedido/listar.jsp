<%@ page import="br.cefetrj.model.Pedido" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  List<Pedido> pedidos = (List<Pedido>) request.getAttribute("lista");
  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Pedidos - Cervejaria</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
    .container { max-width: 1400px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h2 { color: #333; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #ff5722; }
    .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; }
    .btn-primary { background: #ff5722; color: white; }
    .btn-primary:hover { background: #e64a19; }
    .btn-danger { background: #dc3545; color: white; }
    .btn-danger:hover { background: #c82333; }
    .btn-edit { background: #ffc107; color: #333; }
    .btn-edit:hover { background: #e0a800; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
    th { background: #ff5722; color: white; font-weight: 500; }
    tr:hover { background: #f5f5f5; }
    .actions { display: flex; gap: 10px; }
    .badge { padding: 5px 10px; border-radius: 3px; font-size: 12px; font-weight: 500; }
    .badge-aberto { background: #4caf50; color: white; }
    .badge-preparo { background: #ffc107; color: #333; }
    .badge-pronto { background: #ff9800; color: white; }
    .badge-entregue { background: #2196f3; color: white; }
    .badge-pago { background: #8bc34a; color: white; }
    .badge-cancelado { background: #f44336; color: white; }
    .no-data { text-align: center; padding: 40px; color: #999; }
    .valor { color: #4caf50; font-weight: bold; }
    .mesa { background: #ff5722; color: white; padding: 5px 10px; border-radius: 5px; font-weight: bold; }
  </style>
</head>
<body>
<div class="container">
  <div class="header-actions">
    <h2>📋 Pedidos da Cervejaria</h2>
    <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary">➕ Novo Pedido</a>
  </div>

  <% if (pedidos != null && !pedidos.isEmpty()) { %>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>Mesa</th>
      <th>Garçom</th>
      <th>Data/Hora</th>
      <th>Valor Total</th>
      <th>Status</th>
      <th>Ações</th>
    </tr>
    </thead>
    <tbody>
    <% for (Pedido p : pedidos) {
      String statusClass = "badge-aberto";
      switch(p.getStatus()) {
        case "EM_PREPARO": statusClass = "badge-preparo"; break;
        case "PRONTO": statusClass = "badge-pronto"; break;
        case "ENTREGUE": statusClass = "badge-entregue"; break;
        case "PAGO": statusClass = "badge-pago"; break;
        case "CANCELADO": statusClass = "badge-cancelado"; break;
      }
    %>
    <tr>
      <td>#<%= p.getId() %></td>
      <td><span class="mesa">Mesa <%= p.getNumeroMesa() %></span></td>
      <td><%= p.getGarcom() != null ? p.getGarcom().getNome() : "-" %></td>
      <td><%= p.getDataHoraPedido() != null ? p.getDataHoraPedido().format(formatter) : "-" %></td>
      <td class="valor">R$ <%= String.format("%.2f", p.getValorTotal()) %></td>
      <td>
                <span class="badge <%= statusClass %>">
                    <%= p.getStatus().replace("_", " ") %>
                </span>
      </td>
      <td class="actions">
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=buscar&id=<%= p.getId() %>"
           class="btn btn-edit">✏️ Editar</a>
        <a href="<%= request.getAttribute("urlSubmit") %>?acao=deletar&id=<%= p.getId() %>"
           class="btn btn-danger"
           onclick="return confirm('Tem certeza que deseja excluir este pedido?')">🗑️ Excluir</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } else { %>
  <div class="no-data">
    <p>📭 Nenhum pedido registrado ainda.</p>
    <a href="<%= request.getAttribute("urlSubmit") %>?acao=novo" class="btn btn-primary" style="margin-top: 20px;">Criar primeiro pedido</a>
  </div>
  <% } %>
</div>
</body>
</html>