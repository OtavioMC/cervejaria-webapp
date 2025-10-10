<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Aluno" %>
<%

    List<Aluno> alunos = (List<Aluno>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Listar Alunos</title>
    <style>
        table { border-collapse: collapse; width: 60%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #f2f2f2; }
        a { margin-right: 8px; }
    </style>
</head>
<body>
    <h2>Lista de Alunos</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Matrícula</th>
            <th colspan="2">Ações</th>
        </tr>
        <%
            if (alunos != null && !alunos.isEmpty()) {
                for (Aluno aluno : alunos) {
        %>
        <tr>
            <td><%= aluno.getId() %></td>
            <td><%= aluno.getNome() %></td>
            <td><%= aluno.getMatricula() %></td>
            <td>
                <a href="<%= request.getAttribute("urlSubmit") %>?acao=buscar&id=<%= aluno.getId() %>">Editar</a>
            </td>
            <td>
                <a href="<%= request.getAttribute("urlSubmit") %>?acao=remover&id=<%= aluno.getId() %>" onclick="return confirm('Tem certeza que deseja remover?');">Remover</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">Nenhum aluno encontrado.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>