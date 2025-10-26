package br.cefetrj.servlet;

import br.cefetrj.dao.CaixaDAO;
import br.cefetrj.model.Caixa;
import br.cefetrj.utils.DateUtils;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

@WebServlet("/caixa")
public class CaixaServlet extends GenericServlet<Caixa> {

    private CaixaDAO caixaDAO = new CaixaDAO();

    public CaixaServlet() {
        super();
        this.dao = caixaDAO;
    }

    @Override
    protected Caixa preencherEntidade(HttpServletRequest request) {
        Caixa caixa = new Caixa();

        String id = request.getParameter("id");
        caixa.setId(id != null && !id.isEmpty() ? Integer.parseInt(id) : null);

        caixa.setNome(request.getParameter("nome"));
        String dataNascimento = request.getParameter("dataNascimento");
        if (dataNascimento != null && !dataNascimento.isEmpty()) {
            caixa.setDataNascimento(DateUtils.parse(dataNascimento));
        }
        String cpf = request.getParameter("cpf");
        if (cpf != null && !cpf.isEmpty()) {
            caixa.setCpf(Long.parseLong(cpf.replaceAll("[^0-9]", "")));
        }

        caixa.setCodigo(request.getParameter("codigo"));
        String salario = request.getParameter("salario");
        if (salario != null && !salario.isEmpty()) {
            caixa.setSalario(new BigDecimal(salario));
        }
        caixa.setAtivo(request.getParameter("ativo") != null);

        return caixa;
    }
}