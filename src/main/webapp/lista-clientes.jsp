<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="br.cefetrj.model.Cliente" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <table>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Idade</th>
            </tr>
        </thead>
        <tbody>
            <%
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    for (Cliente cliente : clientes) {
%>
    <tr>
        <td><%= cliente.nome %></td>
        <td><%= cliente.idade %></td>
    </tr>
<%
    }
%>
        </tbody>
    </table>
</body>
</html>
