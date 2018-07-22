package br.com.pjcase.controller;


import javax.servlet.http.HttpServletRequest;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.model.Caso;
import org.springframework.stereotype.Controller;
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
        empresa.setCnpj(request.getParameter("cnpj"));
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

        try {
            Empresa empresa = new Empresa();
            empresa = daoEmpresa.getById(String.valueOf(id));

            mv.addObject("empresa", empresa);

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
}
