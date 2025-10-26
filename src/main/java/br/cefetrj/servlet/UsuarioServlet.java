package br.cefetrj.servlet;

import br.cefetrj.dao.UsuarioDAO;
import br.cefetrj.model.Usuario;
import br.cefetrj.utils.DateUtils;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;

@WebServlet("/usuario")
public class UsuarioServlet extends GenericServlet<Usuario> {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    public UsuarioServlet() {
        super();
        this.dao = usuarioDAO;
    }

    @Override
    protected Usuario preencherEntidade(HttpServletRequest request) {
        Usuario usuario = new Usuario();

        String id = request.getParameter("id");
        usuario.setId(id != null && !id.isEmpty() ? Integer.parseInt(id) : null);

        usuario.setNome(request.getParameter("nome"));
        String dataNascimento = request.getParameter("dataNascimento");
        if (dataNascimento != null && !dataNascimento.isEmpty()) {
            usuario.setDataNascimento(DateUtils.parse(dataNascimento));
        }
        String cpf = request.getParameter("cpf");
        if (cpf != null && !cpf.isEmpty()) {
            usuario.setCpf(Long.parseLong(cpf.replaceAll("[^0-9]", "")));
        }

        usuario.setEmail(request.getParameter("email"));

        String senha = request.getParameter("senha");
        if (senha != null && !senha.isEmpty()) {
            usuario.setSenha(senha);
        } else if (id != null && !id.isEmpty()) {
            Usuario usuarioExistente = usuarioDAO.buscarPorId(Integer.parseInt(id));
            if (usuarioExistente != null) {
                usuario.setSenha(usuarioExistente.getSenha());
            }
        }

        usuario.setPapel(request.getParameter("papel"));
        usuario.setAtivo(request.getParameter("ativo") != null);

        return usuario;
    }
}