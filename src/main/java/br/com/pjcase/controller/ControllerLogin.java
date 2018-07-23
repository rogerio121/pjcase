package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.Usuario;
import com.sun.deploy.net.HttpResponse;
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

    @RequestMapping("telainicial")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        DaoUsuario daoUsuario = new DaoUsuario();
        DaoCaso daoCaso = new DaoCaso();
        Usuario usuario = new Usuario();
        List<Caso> casosSemProprietaio = new ArrayList<Caso>();

        ModelAndView mv;
        try {
            usuario = daoUsuario.getByEmailESenha(request.getParameter("email"), request.getParameter("senha"));

            if (usuario.getDadosPessoais() != null) {

                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuarioLogado", usuario);
                //sessao.setMaxInactiveInterval(3000);
                casosSemProprietaio = daoCaso.listarCasosSemProprietarios();

                mv = new ModelAndView("telaInicial");
                mv.addObject(usuario);
                mv.addObject("casosSemProprietaio", casosSemProprietaio);
            }
            else
                mv = new ModelAndView("redirect:/");
                return mv;
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
            System.out.println(usuarioValidado);
            if (usuarioValidado != null)
                return ResponseEntity.ok(usuarioValidado);

            else
                return ResponseEntity.noContent().build();

        } catch (Exception e) {
            System.out.println("Erro ao validar usuário: " + e);
            return (ResponseEntity<Usuario>) ResponseEntity.status(500);
        }
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}
