<%@ page import="br.cefetrj.model.Produto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Produto produto = (Produto) request.getAttribute("entidade");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= produto != null ? "Editar" : "Cadastrar" %> Produto</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 30px; padding-bottom: 10px; border-bottom: 3px solid #4CAF50; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; color: #555; font-weight: 500; }
        input[type="text"], input[type="number"], textarea, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        input[type="checkbox"] { width: auto; margin-right: 5px; }
        textarea { resize: vertical; min-height: 100px; }
        .checkbox-group { display: flex; align-items: center; }
        .btn-group { display: flex; gap: 10px; margin-top: 30px; }
        button, .btn { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-primary { background: #4CAF50; color: white; }
        .btn-primary:hover { background: #45a049; }
        .btn-secondary { background: #757575; color: white; }
        .btn-secondary:hover { background: #616161; }
    </style>
</head>
<body>
<div class="container">
    <h2><%= produto != null ? "Editar" : "Cadastrar" %> Produto</h2>
    <form action="<%= request.getAttribute("urlSubmit") %>" method="post">
        <input type="hidden" name="id" value="<%= produto != null ? produto.getId() : "" %>">
        <input type="hidden" name="acao" value="<%= produto != null ? "editar" : "cadastrar" %>">

        <div class="form-group">
            <label for="nome">Nome do Produto *</label>
            <input type="text" id="nome" name="nome" value="<%= produto != null ? produto.getNome() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="descricao">Descrição</label>
            <textarea id="descricao" name="descricao"><%= produto != null && produto.getDescricao() != null ? produto.getDescricao() : "" %></textarea>
        </div>

        <div class="form-group">
            <label for="preco">Preço (R$) *</label>
            <input type="number" id="preco" name="preco" step="0.01" min="0" value="<%= produto != null ? produto.getPreco() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="categoria">Categoria *</label>
            <select id="categoria" name="categoria" required>
                <option value="">Selecione...</option>
                <option value="Bebida" <%= produto != null && "Bebida".equals(produto.getCategoria()) ? "selected" : "" %>>Bebida</option>
                <option value="Entrada" <%= produto != null && "Entrada".equals(produto.getCategoria()) ? "selected" : "" %>>Entrada</option>
                <option value="Prato Principal" <%= produto != null && "Prato Principal".equals(produto.getCategoria()) ? "selected" : "" %>>Prato Principal</option>
                <option value="Sobremesa" <%= produto != null && "Sobremesa".equals(produto.getCategoria()) ? "selected" : "" %>>Sobremesa</option>
            </select>
        </div>

        <div class="form-group">
            <label for="imagemUrl">URL da Imagem</label>
            <input type="text" id="imagemUrl" name="imagemUrl" value="<%= produto != null && produto.getImagemUrl() != null ? produto.getImagemUrl() : "" %>">
        </div>

        <div class="form-group checkbox-group">
            <input type="checkbox" id="disponivel" name="disponivel" <%= produto == null || produto.getDisponivel() ? "checked" : "" %>>
            <label for="disponivel">Disponível para venda</label>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">
                <%= produto != null ? "Atualizar" : "Cadastrar" %> Produto
            </button>
            <a href="<%= request.getAttribute("urlSubmit") %>?acao=listar" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>