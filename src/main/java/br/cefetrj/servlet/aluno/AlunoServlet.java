package br.cefetrj.servlet.aluno;

import br.cefetrj.model.Aluno;
import br.cefetrj.servlet.GenericServlet;
import br.cefetrj.utils.DateUtils;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;

/**
 * Para acessar o formulário de cadastro:
 * http://localhost:8080/AppCorporativaWeb/aluno?acao=novo
 * Para listar todos os alunos:
 * http://localhost:8080/AppCorporativaWeb/aluno?acao=listar
 * Para editar um aluno (supondo que o ID seja 1):
 * http://localhost:8080/AppCorporativaWeb/aluno?acao=buscar&id=1
 */
@WebServlet("/aluno")
public class AlunoServlet extends GenericServlet<Aluno> {

    @Override
    protected Aluno preencherEntidade(HttpServletRequest request) {
        Aluno aluno = new Aluno();
        String id = request.getParameter("id");
        aluno.setId(id != null && !id.isEmpty() ? Integer.parseInt(id) : null);
        aluno.setNome(request.getParameter("nome"));
        aluno.setMatricula(request.getParameter("matricula"));

        aluno.setCpf(Long.parseLong(request.getParameter("cpf")));
        aluno.setDataNascimento(DateUtils.parse(request.getParameter("dataNascimento")));

        return aluno;
    }
}
