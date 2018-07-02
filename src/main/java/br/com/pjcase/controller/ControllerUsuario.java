package br.com.pjcase.controller;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/usuario")
public class ControllerUsuario {

    @RequestMapping("/cadastro")
    public String chamarTelaUsuario() {
        return "usuario";
    }

    @RequestMapping("/salvar")
    public String chamarTelaUsuario(HttpServletRequest request) {
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

    @RequestMapping("/")
    public ModelAndView teste2(@RequestBody Usuario usuario) {
        ModelAndView mv = new ModelAndView();
        mv.addObject(usuario);

        System.out.println(usuario);
        return  mv;
    }
}
