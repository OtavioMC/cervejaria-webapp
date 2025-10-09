<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Editora" %>
<%
    Editora editora = (Editora) request.getAttribute("editora");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2><% if (editora != null) { %>Editar Editora<% } else { %>Cadastrar Editora<% } %></h2>
    <form action="CadastroEditoraServlet" method="post">
        <input type="hidden" name="id" value="<%= editora != null ? editora.getId() : '' %>">
        <input type="hidden" name="acao" value="<%= editora != null ? 'editar' : 'cadastrar' %>">
        
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" value="<%= editora != null ? editora.getNome() : '' %>" required><br><br>
        <button type="submit"><%= editora != null ? 'Editar Editora' : 'Cadastrar Editora' %></button>
</body>
</html>