
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erro - Sistema Cervejaria</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .error-container {
            max-width: 600px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            text-align: center;
        }
        .error-icon {
            font-size: 5em;
            margin-bottom: 20px;
        }
        h1 {
            color: #dc3545;
            margin-bottom: 15px;
            font-size: 2em;
        }
        p {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: transform 0.3s;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .error-details {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            text-align: left;
            font-size: 0.9em;
            color: #666;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">⚠️</div>
    <h1>Oops! Algo deu errado</h1>
    <p>Desculpe, ocorreu um erro ao processar sua solicitação. Por favor, tente novamente ou entre em contato com o suporte.</p>

    <% if (exception != null) { %>
    <div class="error-details">
        <strong>Detalhes do erro:</strong><br>
        <%= exception.getMessage() %>
    </div>
    <% } %>

    <div style="margin-top: 30px;">
        <a href="<%= request.getContextPath() %>/" class="btn">🏠 Voltar para Página Inicial</a>
    </div>
</div>
</body>
</html>