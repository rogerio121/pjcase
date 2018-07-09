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
import java.io.UnsupportedEncodingException;
import java.util.Optional;

@Controller
@RequestMapping("/caso")
public class ControllerCaso {

    @RequestMapping("/cadastro")
    public String chamaTelaCaso(){
        return "caso";
    }

    @RequestMapping("/salvar")
    public String salvarCaso(HttpServletRequest request) {
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

        ConexaoBanco.FecharConexao();
        return "caso";
    }


    @PutMapping("/cadastro/{id}")
    public ResponseEntity<Caso> pegarCaso(@PathVariable("id") Long id, @RequestBody String emailUsuario){
        System.out.println("Chamou Put: " + id);
        System.out.println(emailUsuario);

        try{
            DaoCaso daoCaso = new DaoCaso();
            Caso caso = new Caso();
            caso = daoCaso.getById(String.valueOf(id));
            caso.setIdUsuarioRelacionado(emailUsuario);
            System.out.println(emailUsuario);
            System.out.println(caso);
            daoCaso.update(caso);

            return (ResponseEntity<Caso>) ResponseEntity.status(200);

        }catch (Exception e){
            System.out.println("Erro na controller caso: statuscode 500 \n" + e);
            return (ResponseEntity<Caso>) ResponseEntity.status(500);
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
