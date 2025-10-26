<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Cervejaria - Home</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2.5em;
            text-align: center;
        }
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 40px;
            font-size: 1.1em;
        }
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        .card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            text-decoration: none;
            color: white;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        .card-icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        .card-title {
            font-size: 1.5em;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .card-description {
            font-size: 0.95em;
            opacity: 0.9;
        }
        .card.produto { background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%); }
        .card.garcom { background: linear-gradient(135deg, #FF6B35 0%, #ff8c42 100%); }
        .card.caixa { background: linear-gradient(135deg, #4CAF50 0%, #8BC34A 100%); }
        .card.usuario { background: linear-gradient(135deg, #2196F3 0%, #42A5F5 100%); }
        .card.pedido { background: linear-gradient(135deg, #ff5722 0%, #ff7043 100%); }
        .footer {
            text-align: center;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
            color: #999;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🍺 Sistema de Gerenciamento - Cervejaria</h1>
    <p class="subtitle">Bem-vindo ao sistema de gestão completo para sua cervejaria</p>

    <div class="cards">
        <a href="<%= request.getContextPath() %>/produto?acao=listar" class="card produto">
            <div class="card-icon">📦</div>
            <div class="card-title">Produtos</div>
            <div class="card-description">Gerencie o cardápio de bebidas e alimentos</div>
        </a>

        <a href="<%= request.getContextPath() %>/garcom?acao=listar" class="card garcom">
            <div class="card-icon">🍺</div>
            <div class="card-title">Garçons</div>
            <div class="card-description">Cadastro e gestão de garçons</div>
        </a>

        <a href="<%= request.getContextPath() %>/caixa?acao=listar" class="card caixa">
            <div class="card-icon">💰</div>
            <div class="card-title">Caixas</div>
            <div class="card-description">Operadores de caixa e vendas</div>
        </a>

        <a href="<%= request.getContextPath() %>/pedido?acao=listar" class="card pedido">
            <div class="card-icon">📋</div>
            <div class="card-title">Pedidos</div>
            <div class="card-description">Controle de pedidos das mesas</div>
        </a>

        <a href="<%= request.getContextPath() %>/usuario?acao=listar" class="card usuario">
            <div class="card-icon">👥</div>
            <div class="card-title">Usuários</div>
            <div class="card-description">Usuários e permissões do sistema</div>
        </a>
    </div>

    <div class="footer">
        <p><strong>Sistema MVC com JSP + Servlets + Hibernate</strong></p>
        <p>CEFET-RJ - Programação de Aplicações Corporativas</p>
    </div>
</div>
</body>
</html>