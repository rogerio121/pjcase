package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.model.Caso;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

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
        System.out.println(caso.getAssunto());
        daoCaso.upsert(caso);

        return "caso";
    }
}
