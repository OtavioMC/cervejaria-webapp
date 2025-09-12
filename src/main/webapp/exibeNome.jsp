<html>

<body>
    <%
        String nome = request.getParameter("nome");

        out.println("Nome é:"+nome);
        // http://localhost:8080/AppCorporativaMavenWeb/exibeNome.jsp?nome=Vitor
    %>
</body>
</html>
