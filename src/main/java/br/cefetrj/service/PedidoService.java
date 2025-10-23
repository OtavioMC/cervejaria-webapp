package br.cefetrj.service;

import br.cefetrj.repository.PedidoRepository;

public class PedidoService {

    private final PedidoRepository repository;

    public PedidoService(PedidoRepository repository) {
        this.repository = repository;
    }

    public void processarPedido() {
        String resultado = repository.buscarPedido();
        System.out.println("Processando: " + resultado);
    }
}
