<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Editora" %>
<%

    List<Editora> editoras = (List<Editora>) request.getAttribute("editoras");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Listar Editoras</title>
    <style>
        table { border-collapse: collapse; width: 60%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #f2f2f2; }
        a { margin-right: 8px; }
    </style>
</head>
<body>
    <h2>Lista de Editoras</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th colspan="2">Ações</th>
        </tr>
        <%
            if (editoras != null && !editoras.isEmpty()) {
                for (Editora editora : editoras) {
        %>
        <tr>
            <td><%= editora.getId() %></td>
            <td><%= editora.getNome() %></td>
            <td>
                <a href="CadastrarEditoraServlet?id=<%= editora.getId() %>">Editar</a>
            </td>
            <td>
                <a href="RemoverEditoraServlet?id=<%= editora.getId() %>" onclick="return confirm('Tem certeza que deseja remover?');">Remover</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3">Nenhuma editora encontrada.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>