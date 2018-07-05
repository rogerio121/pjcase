package br.com.pjcase.controller;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.model.Caso;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Optional;

@Controller
@RequestMapping("/caso")
public class ControllerCaso {

    @RequestMapping("/cadastro")
    public String chamaTelaCaso(){
        return "caso";
    }

    @RequestMapping("/salvar")
    public String salvarCaso(HttpServletRequest request){
        Caso caso = new Caso();
        DaoCaso daoCaso = new DaoCaso();

        caso.setAssunto(request.getParameter("assunto"));
        caso.setMenssagem(request.getParameter("menssagem"));
        caso.setStatus(request.getParameter("status"));
        caso.setIdClienteRelacionado(request.getParameter("idClienteRelacionado"));
        caso.setIdEmpresaRelacionada(request.getParameter("idEmpresaRelacionada"));
        caso.setIdUsuarioRelacionado(request.getParameter("idUsuarioRelacionado"));

        daoCaso.upsert(caso);

        ConexaoBanco.FecharConexao();
        return "caso";
    }

    @PostMapping("/cadastro/{id}")
    public void pegarCaso(@PathVariable("id") Optional<Integer> id, Caso caso){
        System.out.println("Chamou Post");
        ModelAndView mv = new ModelAndView("testeCaso");
        DaoCaso daoCaso = new DaoCaso();

        try{
            caso = daoCaso.getById(String.valueOf(id));

            mv.addObject(caso);

        }catch (Exception e){
            System.out.println("Erro ao chamar tela de edição de caso: " + e);

        }

    }

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
