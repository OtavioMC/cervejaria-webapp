package br.cefetrj.model;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE) // ou JOINED ou TABLE_PER_CLASS
@DiscriminatorColumn(name = "tipo")
public class Aluno extends Pessoa {

    private String matricula;
    @ManyToMany
    @JoinTable(name = "aluno_curso", // nome da tabela intermediária
            joinColumns = @JoinColumn(name = "aluno_id"), // FK para Aluno
            inverseJoinColumns = @JoinColumn(name = "curso_id") // FK para Curso
    )
    private Set<Curso> cursos = new HashSet<>();

    public Set<Curso> getCursos() {
        return cursos;
    }

    public void setCursos(Set<Curso> cursos) {
        this.cursos = cursos;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
}