package br.com.pjcase.controller;


import javax.servlet.http.HttpServletRequest;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.dao.DaoCliente;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.Cliente;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import br.com.pjcase.dao.DaoEmpresa;
import br.com.pjcase.model.Empresa;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/empresa")
public class ControllerEmpresa {

    @RequestMapping("/cadastro")
    public String chamarTelaEmpresa() {
        return "empresa/empresa";
    }


    /*Caso a empresa já exista será feito um update
     * caso não exista será feita a inserção
     * a existencia da empresa será comprovada com uma pesquisa no banco com o CNPJ*/

    @RequestMapping("/salvar")
    public ModelAndView salvarEmpresa(HttpServletRequest request) {
        Empresa empresa = new Empresa();

        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            System.out.println("Erro no charset ControllerCaso: " + e);
        }

        empresa.setNome(request.getParameter("nome"));
        empresa.setCnpj((request.getParameter("cnpj").replaceAll("[./]", "")).replaceAll("-", ""));
        empresa.setLogradouro(request.getParameter("logradouro"));
        empresa.setBairro(request.getParameter("bairro"));
        empresa.setCidade(request.getParameter("cidade"));
        empresa.setEstado(request.getParameter("estado"));
        empresa.setCep(request.getParameter("cep"));

        DaoEmpresa daoEmpresa = new DaoEmpresa();


        daoEmpresa.upsert(empresa);
        ModelAndView mv = new ModelAndView("empresa/empresaView");
        mv.addObject("empresa", empresa);

        ConexaoBanco.FecharConexao();
        return mv;
    }

    @RequestMapping("/empresas")
    public ModelAndView buscarEmpresasCadastradaas() {
        DaoEmpresa daoEmpresa = new DaoEmpresa();
        List<Empresa> empresasCadastradas = new ArrayList<Empresa>();
        empresasCadastradas = daoEmpresa.buscaEmpresasCadastradas();

        ModelAndView mv = new ModelAndView("empresa/empresas");
        mv.addObject("empresasCadastradas", empresasCadastradas);
        return mv;
    }

    @GetMapping("/cadastro/{id}")
    public ModelAndView verEmpresa(@PathVariable("id") String id) {
        ModelAndView mv = new ModelAndView("empresa/empresaView");
        DaoEmpresa daoEmpresa = new DaoEmpresa();
        String clientesDaEmpresaJson = "";

        try {
            Empresa empresa = new Empresa();
            empresa = daoEmpresa.getById(String.valueOf(id));

            DaoCliente daoCliente = new DaoCliente();
            clientesDaEmpresaJson = daoCliente.buscaClientesPertecentesEmpresaJson(empresa.getCnpj());
            mv.addObject("empresa", empresa);
            mv.addObject("clientesDaEmpresaJson", clientesDaEmpresaJson);

        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de view empresa: " + e);

        }

        return mv;
    }

    @GetMapping("/cadastro/editar/{id}")
    public ModelAndView editarEmpresa(@PathVariable("id") String id) {
        ModelAndView mv = new ModelAndView("empresa/empresa");
        DaoEmpresa daoEmpresa = new DaoEmpresa();

        try {
            Empresa empresa = new Empresa();
            empresa = daoEmpresa.getById(String.valueOf(id));

            mv.addObject("empresa", empresa);

        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de edição empresa: " + e);

        }

        return mv;
    }

    @DeleteMapping("/cadastro/{id}")
    public ResponseEntity<Empresa> deletarEmpresa(@PathVariable("id") Long id) {
        ResponseEntity<Empresa> responseEntity = null;

        try {
            DaoEmpresa daoEmpresa = new DaoEmpresa();
            daoEmpresa.delete(String.valueOf(id));

            responseEntity.ok();
            responseEntity.status(200);

            return responseEntity;

        } catch (Exception e) {
            responseEntity.status(500);
            System.out.println("Erro na controller caso: statuscode 500 \n" + e);
            return responseEntity;
        }


    }
}
