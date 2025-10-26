package br.cefetrj.servlet;

import br.cefetrj.dao.GarcomDAO;
import br.cefetrj.model.Garcom;
import br.cefetrj.utils.DateUtils;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

@WebServlet("/garcom")
public class GarcomServlet extends GenericServlet<Garcom> {

    // Sobrescreve o DAO genérico com o específico
    private GarcomDAO garcomDAO = new GarcomDAO();

    public GarcomServlet() {
        super();
        // Substitui o DAO genérico pelo específico
        this.dao = garcomDAO;
    }

    @Override
    protected Garcom preencherEntidade(HttpServletRequest request) {
        Garcom garcom = new Garcom();

        String id = request.getParameter("id");
        garcom.setId(id != null && !id.isEmpty() ? Integer.parseInt(id) : null);

        // Dados de Pessoa
        garcom.setNome(request.getParameter("nome"));
        String dataNascimento = request.getParameter("dataNascimento");
        if (dataNascimento != null && !dataNascimento.isEmpty()) {
            garcom.setDataNascimento(DateUtils.parse(dataNascimento));
        }
        String cpf = request.getParameter("cpf");
        if (cpf != null && !cpf.isEmpty()) {
            garcom.setCpf(Long.parseLong(cpf.replaceAll("[^0-9]", "")));
        }

        // Dados específicos de Garçom
        garcom.setMatricula(request.getParameter("matricula"));
        String salario = request.getParameter("salario");
        if (salario != null && !salario.isEmpty()) {
            garcom.setSalario(new BigDecimal(salario));
        }
        garcom.setTurno(request.getParameter("turno"));
        garcom.setAtivo(request.getParameter("ativo") != null);

        return garcom;
    }
}