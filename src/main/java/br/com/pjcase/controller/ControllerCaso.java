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
        DaoCaso daoCaso = new DaoCaso();
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            System.out.println("Erro no charset ControllerCaso: " + e);
        }

        caso.setAssunto(request.getParameter("assunto"));
        caso.setMenssagem(request.getParameter("menssagem"));
        caso.setStatus(request.getParameter("status"));
        caso.setIdClienteRelacionado(request.getParameter("idClienteRelacionado"));
        caso.setIdEmpresaRelacionada(request.getParameter("idEmpresaRelacionada"));
        caso.setIdUsuarioRelacionado(request.getParameter("idUsuarioRelacionado"));

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

        }catch(Exception e)

    {
        System.out.println("Erro ao carregar 'meusCasos': " + e);
        return null;
    }
}

    /*@PostMapping("/cadastro/{id}")
    public void pegarCaso(@PathVariable("id") Optional<Integer> id, String emailUsuario){
        System.out.println("Chamou Post: " id);
        ModelAndView mv = new ModelAndView("testeCaso");
        DaoCaso daoCaso = new DaoCaso();
        Caso caso = new Caso();
        System.out.println(emailUsuario);
        try{
            caso = daoCaso.getById(String.valueOf(id));

            mv.addObject(caso);

        }catch (Exception e){
            System.out.println("Erro ao chamar tela de edição de caso: " + e);

        }

    }*/

    /*@GetMapping("/cadastro/{id}")
    public void pegarCaso(@PathVariable("id") Optional<Integer> id, Caso caso){
        ModelAndView mv = new ModelAndView("testeCaso");
        DaoCaso daoCaso = new DaoCaso();

        try{
            caso = daoCaso.getById(String.valueOf(id));

            mv.addObject(caso);

        }catch (Exception e){
            System.out.println("Erro ao chamar tela de edição de caso: " + e);

        }

    }*/

}
