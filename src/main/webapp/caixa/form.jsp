<%@ page import="br.cefetrj.model.Caixa" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Caixa caixa = (Caixa) request.getAttribute("entidade");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= caixa != null ? "Editar" : "Cadastrar" %> Caixa</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 30px; padding-bottom: 10px; border-bottom: 3px solid #4CAF50; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; color: #555; font-weight: 500; }
        input[type="text"], input[type="number"], input[type="date"] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        input[type="checkbox"] { width: auto; margin-right: 5px; }
        .checkbox-group { display: flex; align-items: center; }
        .btn-group { display: flex; gap: 10px; margin-top: 30px; }
        button, .btn { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-primary { background: #4CAF50; color: white; }
        .btn-primary:hover { background: #45a049; }
        .btn-secondary { background: #757575; color: white; }
        .btn-secondary:hover { background: #616161; }
        .section-title { font-size: 16px; font-weight: 600; color: #4CAF50; margin: 20px 0 15px 0; padding-bottom: 5px; border-bottom: 2px solid #f0f0f0; }
        .info-box { background: #e8f5e9; padding: 15px; border-radius: 5px; margin-top: 20px; color: #2e7d32; }
    </style>
</head>
<body>
<div class="container">
    <h2>💰 <%= caixa != null ? "Editar" : "Cadastrar" %> Caixa</h2>
    <form action="<%= request.getAttribute("urlSubmit") %>" method="post">
        <input type="hidden" name="id" value="<%= caixa != null ? caixa.getId() : "" %>">
        <input type="hidden" name="acao" value="<%= caixa != null ? "editar" : "cadastrar" %>">

        <div class="section-title">Dados Pessoais</div>

        <div class="form-group">
            <label for="nome">Nome Completo *</label>
            <input type="text" id="nome" name="nome" value="<%= caixa != null ? caixa.getNome() : "" %>" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="cpf">CPF</label>
                <input type="text" id="cpf" name="cpf" value="<%= caixa != null && caixa.getCpf() != null ? caixa.getCpf() : "" %>" maxlength="11" placeholder="Somente números">
            </div>
            <div class="form-group">
                <label for="dataNascimento">Data de Nascimento</label>
                <input type="date" id="dataNascimento" name="dataNascimento" value="<%= caixa != null && caixa.getDataNascimento() != null ? caixa.getDataNascimento() : "" %>">
            </div>
        </div>

        <div class="section-title">Dados Profissionais</div>

        <div class="form-row">
            <div class="form-group">
                <label for="codigo">Código do Caixa *</label>
                <input type="text" id="codigo" name="codigo" value="<%= caixa != null ? caixa.getCodigo() : "" %>" required maxlength="20">
            </div>
            <div class="form-group">
                <label for="salario">Salário (R$)</label>
                <input type="number" id="salario" name="salario" step="0.01" min="0" value="<%= caixa != null && caixa.getSalario() != null ? caixa.getSalario() : "" %>">
            </div>
        </div>

        <div class="form-group checkbox-group">
            <input type="checkbox" id="ativo" name="ativo" <%= caixa == null || caixa.getAtivo() ? "checked" : "" %>>
            <label for="ativo">Funcionário Ativo</label>
        </div>

        <% if (caixa != null && caixa.getTotalVendido() != null && caixa.getTotalVendido().compareTo(java.math.BigDecimal.ZERO) > 0) { %>
        <div class="info-box">
            <strong>💵 Total Vendido:</strong> R$ <%= String.format("%.2f", caixa.getTotalVendido()) %>
        </div>
        <% } %>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">
                <%= caixa != null ? "Atualizar" : "Cadastrar" %> Caixa
            </button>
            <a href="<%= request.getAttribute("urlSubmit") %>?acao=listar" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>