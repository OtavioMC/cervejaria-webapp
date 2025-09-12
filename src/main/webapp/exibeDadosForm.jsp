<html>
<body>
    <form action="">
        <label for="nome">Nome:</label> <input type="text" name="nome" id="nome"/><br/>
        <label for="sobrenome">Sobrenome:</label> <input type="text" name="sobrenome" id="sobrenome"/><br/>
        Sexo: <input type="radio" name="sexo" id="checkM" value="M"/> <label for="checkM">Masculino</label> &nbsp;&nbsp;
        <input type="radio" name="sexo" value="F" id="checkF" /><label for="checkF">Feminino</label>
        <button type="submit">Enviar</button>
    </form>
<%
    String nome = request.getParameter("nome");
    String sobrenome = request.getParameter("sobrenome");
    String sexo = request.getParameter("sexo");
    if(nome!=null && sobrenome!=null && sexo!=null){
        String sexoTexto = "";
        if(sexo.equals("M"))
            sexoTexto = "Masculino";
        else
            sexoTexto = "Feminino";
        out.println("O nome é "+nome+" "+ sobrenome+ " e sexo "+sexoTexto);
    }
    // http://localhost:8080/AppCorporativaMavenWeb/exibeNome.jsp?nome=Vitor
%>
</body>
</html>
