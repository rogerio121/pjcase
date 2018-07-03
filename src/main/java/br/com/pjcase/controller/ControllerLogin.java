package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.Usuario;
import com.sun.deploy.net.HttpResponse;
import org.springframework.stereotype.Controller;
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

    @RequestMapping("logar")
    public ModelAndView logar(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        DaoUsuario daoUsuario = new DaoUsuario();
        DaoCaso daoCaso = new DaoCaso();
        Usuario usuario = new Usuario();
        List<Caso> casosSemProprietaio = new ArrayList<Caso>();

        ModelAndView mv;
        try {
            usuario = daoUsuario.getByEmailESenha(request.getParameter("email"), request.getParameter("senha"));

            if (usuario != null) {

                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuarioLogado", usuario);
                //sessao.setMaxInactiveInterval(3000);
                casosSemProprietaio = daoCaso.listarCasosSemProprietarios();

                System.out.println(daoCaso.listarCasosSemProprietarios());
                mv = new ModelAndView("telaInicial");
                mv.addObject(usuario);
                mv.addObject("x", casosSemProprietaio);
            }
            else
                mv = new ModelAndView("redirect:/");
                return mv;
        } catch (Exception e) {
                System.out.println("Erro ao logar: " + e);
                return  null;
        }
    }
}
