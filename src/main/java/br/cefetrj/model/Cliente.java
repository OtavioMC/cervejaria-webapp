package br.cefetrj.model;

public class Cliente {
    public Integer id;
    public String nome;
    public Integer idade;

    public Cliente(Integer id, String nome, Integer idade) {
        this.id = id;
        this.nome = nome;
        this.idade = idade;
    }
}
