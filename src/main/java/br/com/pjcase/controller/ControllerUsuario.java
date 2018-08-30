package br.com.pjcase.controller;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/usuario")
public class ControllerUsuario {

    @RequestMapping("/cadastro")
    public String chamarTelaUsuario() {
        return "usuario/usuario";
    }

    @RequestMapping("/salvar")
    public String chamarTelaUsuario(HttpServletRequest request) {
        Usuario usuario = new Usuario();
        Usuario usuarioExistente = null;
        DadosPessoais dadosPessoais = new DadosPessoais();
        DaoUsuario daoUsuario = new DaoUsuario();

        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            System.out.println("Erro no charset ControllerCaso: " + e);
        }

        dadosPessoais.setNome(request.getParameter("nome"));
        dadosPessoais.setEmail(request.getParameter("email"));
        usuario.setSenha(request.getParameter("senha"));
        usuario.setIdEmpresaRelacionada(request.getParameter("idEmpresaRelacionada"));

        System.out.println(usuario);
        if (!request.getParameter("id").equals(""))
            usuario.setId(Integer.parseInt(request.getParameter("id")));

        if (request.getParameter("admin") != null)
            usuario.setAdmin(true);
        else
            usuario.setAdmin(false);

        usuario.setDadosPessoais(dadosPessoais);

        usuarioExistente = daoUsuario.getByEmail(usuario.getDadosPessoais().getEmail());
        if (usuarioExistente == null)
            daoUsuario.insert(usuario);
        else
            daoUsuario.update(usuario);

        return "redirect:/usuario/usuarios";
    }

    @RequestMapping("/usuarios")
    public ModelAndView listarUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        DaoUsuario daoUsuario = new DaoUsuario();

        usuarios = daoUsuario.buscarTodosUsuarios();

        ModelAndView mv = new ModelAndView("usuario/todosusuarios");
        mv.addObject("usuarios", usuarios);

        return mv;
    }

    @GetMapping("/cadastro/{id}")
    public ModelAndView verUsuario(@PathVariable("id") Long id) {
        ModelAndView mv = new ModelAndView("usuario/usuarioView");
        DaoUsuario daoUsuario = new DaoUsuario();

        try {
            Usuario usuario = new Usuario();
            usuario = daoUsuario.buscaPorIdentificador(Math.toIntExact(id));

            mv.addObject("usuario", usuario);

        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de edição de usuario: " + e);

        }
        return mv;

    }

    @GetMapping("/cadastro/editar/{id}")
    public ModelAndView editarUsuario(@PathVariable("id") Long id) {
        ModelAndView mv = new ModelAndView("usuario/usuario");
        DaoUsuario daoUsuario = new DaoUsuario();

        try {
            Usuario usuario = new Usuario();
            usuario = daoUsuario.buscaPorIdentificador(Math.toIntExact(id));

            mv.addObject("usuario", usuario);

        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de edição de usuario: " + e);

        }
        return mv;

    }

    @DeleteMapping("/cadastro/{id}")
    public ResponseEntity<Usuario> deletarCliente(@PathVariable("id") Long id) {
        ResponseEntity<Usuario> responseEntity = null;

        try {
            DaoUsuario daoUsuario = new DaoUsuario();
            daoUsuario.delete(Math.toIntExact(id));

            responseEntity.ok();
            responseEntity.status(200);

            return responseEntity;

        } catch (Exception e) {
            responseEntity.status(500);
            System.out.println("Erro na controller caso: statuscode 500 \n" + e);
            return responseEntity;
        }


    }
}
