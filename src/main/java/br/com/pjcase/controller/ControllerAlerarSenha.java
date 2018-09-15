package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Usuario;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ControllerAlerarSenha {

    @RequestMapping("alterarsenha")
    public String chamaTelaAlterarSenha(){
        return "usuario/recuperarSenha";
    }

    @RequestMapping("alterar")
    public ResponseEntity alterarSenha(@RequestBody Usuario usuarioNovaSenha){
        ResponseEntity responseEntity;
        DaoUsuario daoUsuario = new DaoUsuario();
        Usuario usuarioVelhaSenha = new Usuario();

        usuarioVelhaSenha = daoUsuario.getByEmail(usuarioNovaSenha.getDadosPessoais().getEmail());

        if(usuarioVelhaSenha.getSenha().equalsIgnoreCase("")) {
            daoUsuario.alterarSenha(usuarioNovaSenha);
            responseEntity = ResponseEntity.ok().build();
        }
        else{
            responseEntity = ResponseEntity.status(204).build();
        }

        return responseEntity;
    }
}
