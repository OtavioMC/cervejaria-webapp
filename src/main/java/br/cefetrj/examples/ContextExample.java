package br.cefetrj.examples;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import br.cefetrj.service.PedidoService;

public class ContextExample {
    public static void main(String[] args) {
        // Carrega o contexto da aplicação
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");

        // Recupera o bean PedidoService
        PedidoService service = context.getBean("pedidoService", PedidoService.class);
        service.processarPedido();
    }
}
