package br.com.pjcase.controller;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/usuario")
public class ControllerUsuario {

    @RequestMapping("/cadastro")
    public String chamarTelaUsuario(){
        return "usuario";
    }

    @RequestMapping("/salvar")
    public String chamarTelaUsuario(HttpServletRequest request){
        Usuario usuario = new Usuario();
        DadosPessoais dadosPessoais = new DadosPessoais();
        DaoUsuario daoUsuario = new DaoUsuario();


        dadosPessoais.setNome(request.getParameter("nome"));
        dadosPessoais.setEmail(request.getParameter("email"));
        usuario.setSenha(request.getParameter("senha"));

        usuario.setDadosPessoais(dadosPessoais);
        daoUsuario.upsert(usuario);

        ConexaoBanco.FecharConexao();

        return "usuario";
    }
}