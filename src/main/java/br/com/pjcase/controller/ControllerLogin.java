package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.Usuario;
import com.google.gson.Gson;
import com.sun.deploy.net.HttpResponse;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/")
public class ControllerLogin {

    @RequestMapping("/")
    public String chamaTelalogin() {
        return "login";
    }

    @RequestMapping("telaInicial")
    public  ModelAndView login2(HttpServletRequest request){
        DaoCaso daoCaso = new DaoCaso();
        int meusCasosAbertos = 0;
        int meusCasosEmAtendimento = 0;
        ModelAndView mv;

        try {
            String casosSemProprietaioJson;

            Usuario usuarioLogado = new Usuario();
            usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
            casosSemProprietaioJson = new Gson().toJson(daoCaso.listarCasosSemProprietarios());
            meusCasosAbertos = daoCaso.buscarNumeroDeCasosPorStatusPorIdDoUsuario(usuarioLogado.getId(), "Aberto");
            meusCasosEmAtendimento = daoCaso.buscarNumeroDeCasosPorStatusPorIdDoUsuario(usuarioLogado.getId(), "Em atendimento");

            request.setAttribute("casosSemProprietaioJson", casosSemProprietaioJson);
            mv = new ModelAndView("telaInicial");
            mv.addObject("meusCasosAbertos", meusCasosAbertos);
            mv.addObject("meusCasosEmAtendimento", meusCasosEmAtendimento);
        } catch (Exception erro) {
            System.out.println("Erro ao acessar a Tela inicial: " + erro);
            mv = new ModelAndView("redirect:/");
        }

        return mv;
    }

    @RequestMapping("logar")
    public String login(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        DaoUsuario daoUsuario = new DaoUsuario();
        Usuario usuario = new Usuario();

        try {
            usuario = daoUsuario.getByEmailESenha(request.getParameter("email"), request.getParameter("senha"));

                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuarioLogado", usuario);
                //sessao.setMaxInactiveInterval(3000);
                return "redirect:/telaInicial";

        } catch (Exception e) {
            System.out.println("Erro ao logar: " + e);
            return  null;
        }
    }

    @PostMapping("validarusuario")
    public ResponseEntity<Usuario> validarUsuario(@RequestBody Usuario usuario) {
        DaoUsuario daoUsuario = new DaoUsuario();

        Usuario usuarioValidado = null;

        try {
            usuarioValidado = daoUsuario.getByEmailESenha(usuario.getDadosPessoais().getEmail(), usuario.getSenha());
            if (usuarioValidado != null)
                return ResponseEntity.ok(usuarioValidado);

            else
                return ResponseEntity.status(204).build();

        } catch (Exception e) {
            System.out.println("Erro ao validar usuário: " + e);
            return ResponseEntity.status(500).build();
        }
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}
