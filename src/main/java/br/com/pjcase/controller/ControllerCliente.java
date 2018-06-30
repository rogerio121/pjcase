package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoCliente;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.DadosPessoais;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/cliente")
public class ControllerCliente {

    @RequestMapping("/cadastro")
    public String chamarTelaCliente(){
        return "cliente";
    }

    @RequestMapping("/salvar")
    public String salvarCliente(HttpServletRequest request){
        Cliente cliente = new Cliente();
        DadosPessoais dadosPessoais = new DadosPessoais();
        DaoCliente daoCliente = new DaoCliente();

        dadosPessoais.setNome(request.getParameter("nome"));
        dadosPessoais.setEmail(request.getParameter("email"));

        cliente.setDadosPessoais(dadosPessoais);
        daoCliente.upsert(cliente);

        return "cliente";
    }
}
