package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoCliente;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cliente")
public class ControllerCliente {

    @RequestMapping("/cadastro")
    public String chamarTelaCliente(){
        return "cliente/cliente";
    }

    @RequestMapping("/salvar")
    public ModelAndView salvarCliente(HttpServletRequest request){
        Cliente cliente = new Cliente();
        DadosPessoais dadosPessoais = new DadosPessoais();
        DaoCliente daoCliente = new DaoCliente();

        dadosPessoais.setNome(request.getParameter("nome"));
        dadosPessoais.setEmail(request.getParameter("email"));

        cliente.setDadosPessoais(dadosPessoais);
        daoCliente.upsert(cliente);
        ModelAndView mv = new ModelAndView("cliente/clienteView");
        mv.addObject("cliente",cliente);
        return mv;
    }

    @RequestMapping("/clientes")
    public ModelAndView buscaClientes(HttpServletRequest request){
        List<Cliente> clientes = new ArrayList<Cliente>();
        DaoCliente daoCliente = new DaoCliente();


        Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
        clientes = daoCliente.buscaClientesPertecentesEmpresa(usuarioLogado.getIdEmpresaRelacionada());

        ModelAndView mv = new ModelAndView("cliente/clientes");
        mv.addObject("clientes",clientes);
        return mv;
    }
}
