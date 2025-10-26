<%@ page import="br.cefetrj.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario usuario = (Usuario) request.getAttribute("entidade");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= usuario != null ? "Editar" : "Cadastrar" %> Usuário</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 30px; padding-bottom: 10px; border-bottom: 3px solid #2196F3; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; color: #555; font-weight: 500; }
        input[type="text"], input[type="email"], input[type="password"], input[type="number"], input[type="date"], select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        input[type="checkbox"] { width: auto; margin-right: 5px; }
        .checkbox-group { display: flex; align-items: center; }
        .btn-group { display: flex; gap: 10px; margin-top: 30px; }
        button, .btn { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-primary { background: #2196F3; color: white; }
        .btn-primary:hover { background: #1976D2; }
        .btn-secondary { background: #757575; color: white; }
        .btn-secondary:hover { background: #616161; }
        .section-title { font-size: 16px; font-weight: 600; color: #2196F3; margin: 20px 0 15px 0; padding-bottom: 5px; border-bottom: 2px solid #f0f0f0; }
    </style>
</head>
<body>
<div class="container">
    <h2>👤 <%= usuario != null ? "Editar" : "Cadastrar" %> Usuário</h2>
    <form action="<%= request.getAttribute("urlSubmit") %>" method="post">
        <input type="hidden" name="id" value="<%= usuario != null ? usuario.getId() : "" %>">
        <input type="hidden" name="acao" value="<%= usuario != null ? "editar" : "cadastrar" %>">

        <div class="section-title">Dados Pessoais</div>

        <div class="form-group">
            <label for="nome">Nome Completo *</label>
            <input type="text" id="nome" name="nome" value="<%= usuario != null ? usuario.getNome() : "" %>" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="cpf">CPF</label>
                <input type="text" id="cpf" name="cpf" value="<%= usuario != null && usuario.getCpf() != null ? usuario.getCpf() : "" %>" maxlength="11" placeholder="Somente números">
            </div>
            <div class="form-group">
                <label for="dataNascimento">Data de Nascimento</label>
                <input type="date" id="dataNascimento" name="dataNascimento" value="<%= usuario != null && usuario.getDataNascimento() != null ? usuario.getDataNascimento() : "" %>">
            </div>
        </div>

        <div class="section-title">Dados de Acesso</div>

        <div class="form-group">
            <label for="email">E-mail *</label>
            <input type="email" id="email" name="email" value="<%= usuario != null && usuario.getEmail() != null ? usuario.getEmail() : "" %>" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="senha">Senha <%= usuario != null ? "(deixe em branco para manter)" : "*" %></label>
                <input type="password" id="senha" name="senha" <%= usuario == null ? "required" : "" %>>
            </div>
            <div class="form-group">
                <label for="papel">Papel/Função</label>
                <select id="papel" name="papel">
                    <option value="">Selecione...</option>
                    <option value="ADMIN" <%= usuario != null && "ADMIN".equals(usuario.getPapel()) ? "selected" : "" %>>Administrador</option>
                    <option value="GERENTE" <%= usuario != null && "GERENTE".equals(usuario.getPapel()) ? "selected" : "" %>>Gerente</option>
                    <option value="USUARIO" <%= usuario != null && "USUARIO".equals(usuario.getPapel()) ? "selected" : "" %>>Usuário</option>
                </select>
            </div>
        </div>

        <div class="form-group checkbox-group">
            <input type="checkbox" id="ativo" name="ativo" <%= usuario == null || usuario.getAtivo() ? "checked" : "" %>>
            <label for="ativo">Usuário Ativo</label>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">
                <%= usuario != null ? "Atualizar" : "Cadastrar" %> Usuário
            </button>
            <a href="<%= request.getAttribute("urlSubmit") %>?acao=listar" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>