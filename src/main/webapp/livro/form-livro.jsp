<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Editora" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="cadastrar-livro" method="post">
        <label for="titulo">Título:</label>
        <input type="text" id="titulo" name="titulo" value="<%= livro != null ? livro.getTitulo() : "" %>" required><br><br>

        <label for="autores">Autores:</label>
        <input type="text" id="autores" name="autores" value="<%= livro != null ? livro.getAutores() : "" %>" required><br><br>


        <label for="editora">Editora:</label>
        <select id="editora" name="editoraId" required>
                        <%
    List<Editora> editoras = (List<Editora>) request.getAttribute("editoras");
    for (Editora editora : editoras) {
%>
        <option value="<%= editora.getId() %>" <%= livro != null && livro.getEditora().getId().equals(editora.getId()) ? "selected" : "" %>><%= editora.getNome() %></option>
    <%
    }
%>
        </select><br><br>
        <label for="anoPublicacao">Ano de Publicação:</label>
        <input type="number" id="anoPublicacao" name="anoPublicacao" value="<%= livro != null ? livro.getAnoPublicacao() : "" %>" required><br><br>
        <button type="submit">Cadastrar Livro</button>
</body>
</html>