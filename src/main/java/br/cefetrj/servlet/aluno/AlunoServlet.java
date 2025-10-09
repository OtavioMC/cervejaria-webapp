package br.cefetrj.servlet.aluno;

import br.cefetrj.model.Aluno;
import br.cefetrj.servlet.GenericServlet;
import br.cefetrj.utils.DateUtils;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;

@WebServlet("/aluno")
public class AlunoServlet extends GenericServlet<Aluno> {

    @Override
    protected Aluno preencherEntidade(HttpServletRequest request) {
        Aluno aluno = new Aluno();
        aluno.setId(request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0);
        aluno.setNome(request.getParameter("nome"));
        aluno.setMatricula(request.getParameter("matricula"));
        aluno.setCpf(Long.parseLong(request.getParameter("cpf")));
        aluno.setDataNascimento(DateUtils.parse(request.getParameter("dataNascimento")));
        return aluno;
    }
}
