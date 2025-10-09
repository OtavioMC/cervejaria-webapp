<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Aluno" %>
<%@ page import="br.cefetrj.utils.DateUtils" %>
<%
    Aluno aluno = (Aluno) request.getAttribute("aluno");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Aluno</title>
</head>
<body>
    <h2><% if (aluno != null) { %>Editar Aluno<% } else { %>Cadastrar Aluno<% } %></h2>
    <form action="/aluno" method="post">
        <input type="hidden" name="id" value="<%= aluno != null ? aluno.getId() : '' %>">
        <input type="hidden" name="acao" value="<%= aluno != null ? 'editar' : 'cadastrar' %>">
        <label for="matricula">Matrícula:</label>  
        <input type="text" id="matricula" name="matricula" value="<%= aluno != null ? aluno.getMatricula() : '' %>" required><br><br>
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" value="<%= aluno != null ? aluno.getNome() : '' %>" required><br><br>
        <label for="dataNascimento">Data de Nascimento:</label>
        <input type="date" id="dataNascimento" name="dataNascimento" value="<%= aluno != null ? DateUtils.format(aluno.getDataNascimento()) : '' %>" required><br><br>
        <label for="cpf">CPF:</label>
        <input type="text" id="cpf" name="cpf" value="<%= aluno != null ? aluno.getCpf() : '' %>" required><br><br>
        <button type="submit"><%= aluno != null ? 'Editar Aluno' : 'Cadastrar Aluno' %></button>
</body>
</html>