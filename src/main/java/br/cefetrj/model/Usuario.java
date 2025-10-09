package br.cefetrj.model;

import jakarta.persistence.*;

@Entity
@Table(name = "usuarios")
public class Usuario extends Pessoa {

    private String email;
    private String senha;
    private boolean ativo;
    private String papel; // e.g., "ADMIN", "USER"

    // Getters e Setters

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
