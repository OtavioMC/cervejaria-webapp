<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Editora" %>
<%
    br.cefetrj.model.Editora editora = (br.cefetrj.model.Editora) request.getAttribute("editora");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="CadastroEditoraServlet" method="post">
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" value="<%= editora != null ? editora.getNome() : "" %>" required><br><br>
        <button type="submit">Cadastrar Editora</button>
</body>
</html>