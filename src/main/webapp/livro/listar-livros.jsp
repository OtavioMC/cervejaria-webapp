<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Livro" %>
<%

    List<Livro> livros = (List<Livro>) request.getAttribute("livros");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Listar Livros</title>
    <style>
        table { border-collapse: collapse; width: 60%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #f2f2f2; }
        a { margin-right: 8px; }
    </style>
</head>
<body>
    <h2>Lista de Livros</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Título</th>
            <th>Autor</th>
            <th>Editora</th>
            <th>Ano de Publicação</th>
            <th colspan="2">Ações</th>
        </tr>
        <%
            if (livros != null && !livros.isEmpty()) {
                for (Livro livro : livros) {
        %>
        <tr>
            <td><%= livro.getId() %></td>
            <td><%= livro.getTitulo() %></td>
            <td><%= livro.getAutores() %></td>
            <td><%= livro.getEditora().getNome() %></td>
            <td><%= livro.getAnoPublicacao() %></td>
            <td>
                <a href="CadastrarLivroServlet?id=<%= livro.getId() %>">Editar</a>
            </td>
            <td>
                <a href="RemoverLivroServlet?id=<%= livro.getId() %>" onclick="return confirm('Tem certeza que deseja remover?');">Remover</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="6">Nenhum livro encontrado.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>