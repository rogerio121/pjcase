package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoCliente;
import br.com.pjcase.dao.DaoClienteDaEmpresa;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;
import com.google.gson.Gson;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cliente")
public class ControllerCliente {

    @RequestMapping("/cadastro")
    public String chamarTelaCliente() {
        return "cliente/cliente";
    }

    @RequestMapping("/salvar")
    public ModelAndView salvarCliente(HttpServletRequest request) {
        Cliente cliente = new Cliente();
        DadosPessoais dadosPessoais = new DadosPessoais();
        DaoCliente daoCliente = new DaoCliente();
        ModelAndView mv = new ModelAndView("cliente/clienteView");

        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            System.out.println("Erro no charset ControllerCaso: " + e);
        }

        dadosPessoais.setCpf(request.getParameter("cpf").replaceAll("[.-]", ""));
        dadosPessoais.setNome(request.getParameter("nome"));
        dadosPessoais.setEmail(request.getParameter("email"));
        dadosPessoais.setLogradouro(request.getParameter("logradouro"));
        dadosPessoais.setBairro(request.getParameter("bairro"));
        dadosPessoais.setCidade(request.getParameter("cidade"));
        dadosPessoais.setEstado(request.getParameter("estado"));
        dadosPessoais.setCep(request.getParameter("cep"));
        dadosPessoais.setTelefone(request.getParameter("telefone").replaceAll("[()-]","").replace(" ",""));

        cliente.setDadosPessoais(dadosPessoais);
        try {
            daoCliente.upsert(cliente);
        }catch (SQLException erro){
            mv.addObject("response","204");
            System.out.println("Erro ao fazer o upsert em clientes: " + erro);
        }


        Usuario usuarioLogado = new Usuario();
        usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
        if(!usuarioLogado.getAdmin()){
            DaoClienteDaEmpresa daoClienteDaEmpresa = new DaoClienteDaEmpresa();
            try {
                daoClienteDaEmpresa.insert(cliente.getDadosPessoais().getCpf(), usuarioLogado.getIdEmpresaRelacionada());
            } catch (SQLException erro) {
                System.out.println("Erro ao inserir clienteDaEmpresa: " + erro);
            }
        }

        mv.addObject("cliente", cliente);
        return mv;
    }

    @RequestMapping("/clientes")
    public ModelAndView buscaClientes(HttpServletRequest request) {
        String clientesJson = "";
        DaoCliente daoCliente = new DaoCliente();
        ModelAndView mv;

        try {
            Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");

            if (usuarioLogado.getAdmin())
                clientesJson = new Gson().toJson(daoCliente.buscaTodosClientes());
            else
                clientesJson = new Gson().toJson(daoCliente.buscaClientesPertecentesEmpresa(usuarioLogado.getIdEmpresaRelacionada()));

            mv = new ModelAndView("cliente/clientes");
            mv.addObject("clientesJson", clientesJson);
        } catch (Exception e) {
            System.out.println("Erro ao listar clientes: " + e);
            mv = new ModelAndView("redirect:/");
        }
        return mv;
    }

    @RequestMapping("/todosclientes")
    public ModelAndView buscaTodosClientes(HttpServletRequest request) {
        List<Cliente> clientes = new ArrayList<Cliente>();
        DaoCliente daoCliente = new DaoCliente();

        try {
            Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");

            if (usuarioLogado.getAdmin())
                clientes = daoCliente.buscaTodosClientes();
            else
                clientes = daoCliente.buscaClientesPertecentesEmpresa(usuarioLogado.getIdEmpresaRelacionada());

            ModelAndView mv = new ModelAndView("cliente/clientes");
            mv.addObject("clientes", clientes);
            return mv;
        } catch (Exception e) {
            System.out.println("Erro ao listar clientes: " + e);
            return null;
        }
    }

    @GetMapping("/cadastro/{id}")
    public ModelAndView chamaTelaView(@PathVariable String id){
        ModelAndView mv = new ModelAndView("cliente/clienteView");
        DaoCliente daoCliente = new DaoCliente();

        try {
            Cliente cliente = new Cliente();
            cliente = daoCliente.getById(id);

            mv.addObject("cliente", cliente);
        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de cliente view: " + e);

        }

        return mv;
    }

    @GetMapping("/cadastro/editar/{id}")
    public ModelAndView chamaTelaEditar(@PathVariable String id){
        ModelAndView mv = new ModelAndView("cliente/cliente");
        DaoCliente daoCliente = new DaoCliente();

        try {
            Cliente cliente = new Cliente();
            cliente = daoCliente.getById(id);

            mv.addObject("cliente", cliente);
        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de editar cliente: " + e);

        }

        return mv;
    }

    @DeleteMapping("/cadastro/{id}")
    public ResponseEntity deletarCliente(@PathVariable("id") Long id) {
        DaoCliente daoCliente = new DaoCliente();

        try {
            daoCliente.delete(String.valueOf(id));
            return ResponseEntity.status(200).build();

        } catch (SQLException erro) {
            System.out.println("Erro ao deletar Cliente: " + erro);
            return ResponseEntity.status(204).build();
        }
    }
}
