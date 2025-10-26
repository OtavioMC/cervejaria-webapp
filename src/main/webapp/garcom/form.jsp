<%@ page import="br.cefetrj.model.Garcom" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Garcom garcom = (Garcom) request.getAttribute("entidade");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= garcom != null ? "Editar" : "Cadastrar" %> Garçom</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 30px; padding-bottom: 10px; border-bottom: 3px solid #FF6B35; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        .form-group.full { grid-column: 1 / -1; }
        label { display: block; margin-bottom: 5px; color: #555; font-weight: 500; }
        input[type="text"], input[type="number"], input[type="date"], select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        input[type="checkbox"] { width: auto; margin-right: 5px; }
        .checkbox-group { display: flex; align-items: center; }
        .btn-group { display: flex; gap: 10px; margin-top: 30px; }
        button, .btn { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-primary { background: #FF6B35; color: white; }
        .btn-primary:hover { background: #e85a2a; }
        .btn-secondary { background: #757575; color: white; }
        .btn-secondary:hover { background: #616161; }
        .section-title { font-size: 16px; font-weight: 600; color: #FF6B35; margin: 20px 0 15px 0; padding-bottom: 5px; border-bottom: 2px solid #f0f0f0; }
    </style>
</head>
<body>
<div class="container">
    <h2>🍺 <%= garcom != null ? "Editar" : "Cadastrar" %> Garçom</h2>
    <form action="<%= request.getAttribute("urlSubmit") %>" method="post">
        <input type="hidden" name="id" value="<%= garcom != null ? garcom.getId() : "" %>">
        <input type="hidden" name="acao" value="<%= garcom != null ? "editar" : "cadastrar" %>">

        <div class="section-title">Dados Pessoais</div>

        <div class="form-group">
            <label for="nome">Nome Completo *</label>
            <input type="text" id="nome" name="nome" value="<%= garcom != null ? garcom.getNome() : "" %>" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="cpf">CPF</label>
                <input type="text" id="cpf" name="cpf" value="<%= garcom != null && garcom.getCpf() != null ? garcom.getCpf() : "" %>" maxlength="11" placeholder="Somente números">
            </div>
            <div class="form-group">
                <label for="dataNascimento">Data de Nascimento</label>
                <input type="date" id="dataNascimento" name="dataNascimento" value="<%= garcom != null && garcom.getDataNascimento() != null ? garcom.getDataNascimento() : "" %>">
            </div>
        </div>

        <div class="section-title">Dados Profissionais</div>

        <div class="form-row">
            <div class="form-group">
                <label for="matricula">Matrícula *</label>
                <input type="text" id="matricula" name="matricula" value="<%= garcom != null ? garcom.getMatricula() : "" %>" required>
            </div>
            <div class="form-group">
                <label for="salario">Salário (R$)</label>
                <input type="number" id="salario" name="salario" step="0.01" min="0" value="<%= garcom != null && garcom.getSalario() != null ? garcom.getSalario() : "" %>">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="turno">Turno</label>
                <select id="turno" name="turno">
                    <option value="">Selecione...</option>
                    <option value="Manhã" <%= garcom != null && "Manhã".equals(garcom.getTurno()) ? "selected" : "" %>>Manhã</option>
                    <option value="Tarde" <%= garcom != null && "Tarde".equals(garcom.getTurno()) ? "selected" : "" %>>Tarde</option>
                    <option value="Noite" <%= garcom != null && "Noite".equals(garcom.getTurno()) ? "selected" : "" %>>Noite</option>
                </select>
            </div>
            <div class="form-group checkbox-group" style="align-self: end; padding-bottom: 10px;">
                <input type="checkbox" id="ativo" name="ativo" <%= garcom == null || garcom.getAtivo() ? "checked" : "" %>>
                <label for="ativo">Funcionário Ativo</label>
            </div>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">
                <%= garcom != null ? "Atualizar" : "Cadastrar" %> Garçom
            </button>
            <a href="<%= request.getAttribute("urlSubmit") %>?acao=listar" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>