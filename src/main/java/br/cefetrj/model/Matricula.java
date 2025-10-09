package br.cefetrj.model;

import java.time.LocalDate;

import jakarta.persistence.*;

@Entity
public class Matricula {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Aluno aluno;

    @ManyToOne
    private Curso curso;

    private LocalDate dataMatricula;

    // Getters e Setters
}
