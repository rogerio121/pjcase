package br.com.pjcase.controller;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.*;
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

        Usuario usuarioLogado = new Usuario();
        usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");

        caso.setAssunto(request.getParameter("assunto"));
        caso.setMensagem(request.getParameter("mensagem"));
        caso.setStatus(request.getParameter("status"));
        caso.setUsuario(usuarioLogado);
        caso.setResolucao(request.getParameter("resolucao"));

        //Cliente
        Cliente cliente = new Cliente();
        DadosPessoais dadosPessoaisCliente = new DadosPessoais();
        dadosPessoaisCliente.setCpf(request.getParameter("cliente.dadosPessoais.cnpj"));
        cliente.setDadosPessoais(dadosPessoaisCliente);

        //Empresa
        Empresa empresa = new Empresa();
        empresa.setCnpj(request.getParameter("empresa.cnpj"));

        /*
        //Usuario
        Usuario usuario = new Usuario();
        DadosPessoais dadosPessoaisUsuario = new DadosPessoais();
        dadosPessoaisUsuario.setCpf(request.getParameter("usuario.dadospessoais.cpf"));
        usuario.setDadosPessoais(dadosPessoaisCliente);
        */

        caso.setCliente(cliente);
        caso.setEmpresa(empresa);

        //Caso seja uma edição o campo IdCaso será populado, do Contrário não
        try {
            caso.setIdCaso(Integer.parseInt(request.getParameter("idCaso")));
        }catch (Exception e){

        }

        daoCaso.upsert(caso);

        ModelAndView mv = new ModelAndView("caso/casoView");
        mv.addObject("caso", caso);

        ConexaoBanco.FecharConexao();
        return mv;
    }


    @PutMapping("/cadastro/{id}")
    public ResponseEntity<Caso> pegarCaso(@PathVariable("id") Long id, @RequestBody String idUsuario) {
        ResponseEntity<Caso> responseEntity = null;

        try {
            DaoCaso daoCaso = new DaoCaso();
            Caso caso = new Caso();
            caso = daoCaso.getById(String.valueOf(id));

            DaoUsuario daoUsuario = new DaoUsuario();
            Usuario usuario = daoUsuario.getById(Integer.parseInt(idUsuario));

            caso.setUsuario(usuario);



            daoCaso.pegarCaso(caso);

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

            casosDoUsuarioLogado = daoCaso.listarCasosPorProprietarios(usuario.getId());

            mv = new ModelAndView("caso/casos");
            mv.addObject("casos", casosDoUsuarioLogado);
            mv.addObject("usuario", usuario);

            return mv;

        } catch (Exception e){
            System.out.println("Erro ao carregar 'meusCasos': " + e);
            return null;
        }
    }

    @RequestMapping("/todososcasos")
    public ModelAndView buscaTodosOsCasos(HttpServletRequest request, HttpServletResponse response) {
        DaoCaso daoCaso = new DaoCaso();
        List<Caso> todosOsCasos = new ArrayList<Caso>();

        ModelAndView mv;
        try {
            Usuario usuario = new Usuario();
            usuario = (Usuario) request.getSession().getAttribute("usuarioLogado");

            todosOsCasos = daoCaso.listarTodosOsCasos();

            mv = new ModelAndView("caso/casos");
            mv.addObject("casos", todosOsCasos);
            mv.addObject("usuario", usuario);

            return mv;

        } catch (Exception e){
            System.out.println("Erro ao carregar 'todosOsCasos': " + e);
            return null;
        }
    }

    @GetMapping("/cadastro/{id}")
    public ModelAndView verCaso(@PathVariable("id") Long id) {
        ModelAndView mv = new ModelAndView("caso/casoView");
        DaoCaso daoCaso = new DaoCaso();

        try {
            Caso caso = new Caso();
            caso = daoCaso.buscarCasoCompleto(Math.toIntExact(id));

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
            caso = daoCaso.buscarCasoCompleto(Math.toIntExact(id));

            mv.addObject(caso);

        } catch (Exception e) {
            System.out.println("Erro ao chamar tela de edição de caso: " + e);

        }
        return mv;
    }

    @DeleteMapping("/cadastro/{id}")
    public ResponseEntity<Caso> deletarCaso(@PathVariable("id") Long id) {
        ResponseEntity<Caso> responseEntity = null;

        try {
            DaoCaso daoCaso = new DaoCaso();
            daoCaso.delete(String.valueOf(id));

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
