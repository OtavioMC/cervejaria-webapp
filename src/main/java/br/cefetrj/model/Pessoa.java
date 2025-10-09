package br.cefetrj.model;

import java.time.LocalDate;

import jakarta.persistence.*;

@Entity
@MappedSuperclass
public abstract class Pessoa extends Entidade {

    private String nome;
    private LocalDate dataNascimento;
    private Long cpf;

    // Getters e Setters

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public Long getCpf() {
        return cpf;
    }

    public void setCpf(Long cpf) {
        this.cpf = cpf;
    }

}
