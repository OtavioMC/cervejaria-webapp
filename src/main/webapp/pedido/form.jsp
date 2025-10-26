<%@ page import="br.cefetrj.model.Pedido" %>
<%@ page import="br.cefetrj.model.Garcom" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Pedido pedido = (Pedido) request.getAttribute("entidade");
    List<Garcom> garcons = (List<Garcom>) request.getAttribute("garcons");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pedido != null ? "Editar" : "Novo" %> Pedido</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 30px; padding-bottom: 10px; border-bottom: 3px solid #ff5722; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; color: #555; font-weight: 500; }
        input[type="number"], select, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        textarea { resize: vertical; min-height: 80px; }
        .btn-group { display: flex; gap: 10px; margin-top: 30px; }
        button, .btn { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-primary { background: #ff5722; color: white; }
        .btn-primary:hover { background: #e64a19; }
        .btn-secondary { background: #757575; color: white; }
        .btn-secondary:hover { background: #616161; }
        .section-title { font-size: 16px; font-weight: 600; color: #ff5722; margin: 20px 0 15px 0; padding-bottom: 5px; border-bottom: 2px solid #f0f0f0; }
        .info-box { background: #fff3e0; padding: 15px; border-radius: 5px; margin-bottom: 20px; color: #e65100; }
    </style>
</head>
<body>
<div class="container">
    <h2>🍺 <%= pedido != null ? "Editar" : "Novo" %> Pedido</h2>

    <% if (pedido != null && pedido.getDataHoraPedido() != null) { %>
    <div class="info-box">
        <strong>📅 Pedido criado em:</strong> <%= pedido.getDataHoraPedido() %>
    </div>
    <% } %>

    <form action="<%= request.getAttribute("urlSubmit") %>" method="post">
        <input type="hidden" name="id" value="<%= pedido != null ? pedido.getId() : "" %>">
        <input type="hidden" name="acao" value="<%= pedido != null ? "editar" : "cadastrar" %>">

        <div class="section-title">Informações do Pedido</div>

        <div class="form-row">
            <div class="form-group">
                <label for="numeroMesa">Número da Mesa *</label>
                <input type="number" id="numeroMesa" name="numeroMesa"
                       value="<%= pedido != null ? pedido.getNumeroMesa() : "" %>"
                       min="1" required>
            </div>
            <div class="form-group">
                <label for="garcomId">Garçom Responsável *</label>
                <select id="garcomId" name="garcomId" required>
                    <option value="">Selecione um garçom...</option>
                    <% if (garcons != null) {
                        for (Garcom g : garcons) { %>
                    <option value="<%= g.getId() %>"
                            <%= pedido != null && pedido.getGarcom() != null && pedido.getGarcom().getId().equals(g.getId()) ? "selected" : "" %>>
                        <%= g.getNome() %> - <%= g.getMatricula() %>
                    </option>
                    <% } } %>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="status">Status do Pedido *</label>
                <select id="status" name="status" required>
                    <option value="ABERTO" <%= pedido == null || "ABERTO".equals(pedido.getStatus()) ? "selected" : "" %>>🟢 Aberto</option>
                    <option value="EM_PREPARO" <%= pedido != null && "EM_PREPARO".equals(pedido.getStatus()) ? "selected" : "" %>>🟡 Em Preparo</option>
                    <option value="PRONTO" <%= pedido != null && "PRONTO".equals(pedido.getStatus()) ? "selected" : "" %>>🟠 Pronto</option>
                    <option value="ENTREGUE" <%= pedido != null && "ENTREGUE".equals(pedido.getStatus()) ? "selected" : "" %>>🔵 Entregue</option>
                    <option value="PAGO" <%= pedido != null && "PAGO".equals(pedido.getStatus()) ? "selected" : "" %>>✅ Pago</option>
                    <option value="CANCELADO" <%= pedido != null && "CANCELADO".equals(pedido.getStatus()) ? "selected" : "" %>>❌ Cancelado</option>
                </select>
            </div>
            <% if (pedido != null && pedido.getValorTotal() != null) { %>
            <div class="form-group">
                <label>Valor Total</label>
                <input type="text" value="R$ <%= String.format("%.2f", pedido.getValorTotal()) %>" readonly style="background: #f5f5f5;">
            </div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="observacoes">Observações</label>
            <textarea id="observacoes" name="observacoes" placeholder="Observações sobre o pedido..."><%= pedido != null && pedido.getObservacoes() != null ? pedido.getObservacoes() : "" %></textarea>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">
                <%= pedido != null ? "Atualizar" : "Criar" %> Pedido
            </button>
            <a href="<%= request.getAttribute("urlSubmit") %>?acao=listar" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>