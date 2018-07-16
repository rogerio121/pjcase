package br.com.pjcase.controller;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.Usuario;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/caso")
public class ControllerCaso {

    @RequestMapping("/cadastro")
    public String chamaTelaCaso() {
        return "caso/caso";
    }

    @RequestMapping("/salvar")
    public ModelAndView salvarCaso(HttpServletRequest request) {
        Caso caso = new Caso();
        Caso casoExistente = null;
        DaoCaso daoCaso = new DaoCaso();

        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            System.out.println("Erro no charset ControllerCaso: " + e);
        }

        caso.setAssunto(request.getParameter("assunto"));
        caso.setMensagem(request.getParameter("mensagem"));
        caso.setStatus(request.getParameter("status"));
        caso.setIdClienteRelacionado(request.getParameter("idClienteRelacionado"));
        caso.setIdEmpresaRelacionada(request.getParameter("idEmpresaRelacionada"));
        caso.setIdUsuarioRelacionado(request.getParameter("idUsuarioRelacionado"));
        //Caso seja uma edição o campo IdCaso será populado, do Contrário não
        try {
            caso.setIdCaso(Integer.parseInt(request.getParameter("idCaso")));
        }catch (Exception e){

        }


        System.out.println("Salvar caso: " + caso);

        daoCaso.upsert(caso);

        ModelAndView mv = new ModelAndView("caso/casoView");
        mv.addObject("caso", caso);

        ConexaoBanco.FecharConexao();
        return mv;
    }


    @PutMapping("/cadastro/{id}")
    public ResponseEntity<Caso> pegarCaso(@PathVariable("id") Long id, @RequestBody String emailUsuario) {
        ResponseEntity<Caso> responseEntity = null;

        try {
            DaoCaso daoCaso = new DaoCaso();
            Caso caso = new Caso();
            caso = daoCaso.getById(String.valueOf(id));
            caso.setIdUsuarioRelacionado(emailUsuario);

            daoCaso.update(caso);

            responseEntity.ok(caso);
            responseEntity.status(200);

            return responseEntity;

        } catch (Exception e) {
            responseEntity.status(500);
            System.out.println("Erro na controller caso: statuscode 500 \n" + e);
            return responseEntity;
        }


    }


    @RequestMapping("/meuscasos")
    public ModelAndView buscaMeusCasos(HttpServletRequest request, HttpServletResponse response) {
        DaoCaso daoCaso = new DaoCaso();
        List<Caso> casosDoUsuarioLogado = new ArrayList<Caso>();

        ModelAndView mv;
        try {
            Usuario usuario = new Usuario();
            usuario = (Usuario) request.getSession().getAttribute("usuarioLogado");

            casosDoUsuarioLogado = daoCaso.listarCasosPorProprietarios(usuario.getDadosPessoais().getEmail());

            mv = new ModelAndView("caso/meusCasos");
            mv.addObject("casosDoUsuarioLogado", casosDoUsuarioLogado);
            System.out.println(casosDoUsuarioLogado.get(0));
            return mv;

        } catch (Exception e)

        {
            System.out.println("Erro ao carregar 'meusCasos': " + e);
            return null;
        }
    }


    @GetMapping("/cadastro/{id}")
    public ModelAndView verCaso(@PathVariable("id") Long id) {
        ModelAndView mv = new ModelAndView("caso/casoView");
        DaoCaso daoCaso = new DaoCaso();

        try {
            Caso caso = new Caso();
            caso = daoCaso.getById(String.valueOf(id));

            mv.addObject("caso", caso);

        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de edição de caso: " + e);

        }

        return mv;
    }

    @GetMapping("/cadastro/editar/{id}")
    public ModelAndView editarCaso(@PathVariable("id") Long id) {

        ModelAndView mv = new ModelAndView("caso/caso");
        DaoCaso daoCaso = new DaoCaso();
        Caso caso = new Caso();

        try {
            caso = daoCaso.getById(String.valueOf(id));

            mv.addObject(caso);

        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de edição de caso: " + e);

        }
        return mv;
    }
}
