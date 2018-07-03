package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Usuario;
import com.sun.deploy.net.HttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/")
public class ControllerLogin {

    @RequestMapping("/")
    public String chamaTelalogin() {
        return "login";
    }

    @RequestMapping("logar")
    public String logar(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        DaoUsuario daoUsuario = new DaoUsuario();
        Usuario usuario = new Usuario();

        System.out.println("chamou");
        try {
            usuario = daoUsuario.getByEmailESenha(request.getParameter("email"), request.getParameter("senha"));

            if (usuario.getDadosPessoais().getEmail() != null) {

                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuarioLogado", usuario);
                //sessao.setMaxInactiveInterval(3000);
            }
            return "telaInicial";

        } catch (Exception e) {
            return "redirect:/";
        }
    }
}
