package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoClienteDaEmpresa;
import br.com.pjcase.model.ClienteDaEmpresa;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;

@Controller
@RequestMapping("clienteempresa")
public class ControllerClienteDaEmpresa {

    @PostMapping("/vincular")
    public ResponseEntity<ClienteDaEmpresa> salvar(@RequestBody ClienteDaEmpresa clienteDaEmpresa){
        DaoClienteDaEmpresa daoClienteDaEmpresa = new DaoClienteDaEmpresa();

        System.out.println(clienteDaEmpresa);

        try {
            daoClienteDaEmpresa.insert(clienteDaEmpresa.getCpfCliente(), clienteDaEmpresa.getIdEmpresa());
            return (ResponseEntity<ClienteDaEmpresa>) ResponseEntity.ok(clienteDaEmpresa);
        }catch (SQLException erro){
            System.out.println("Erro ao inserir clienteDaEmpresa: " + erro);
            return ResponseEntity.status(204).build();
        }
    }

    @DeleteMapping("{id}")
    public ResponseEntity deletar(@PathVariable("id") String id){
        System.out.println(id);
        try {
            DaoClienteDaEmpresa daoClienteDaEmpresa = new DaoClienteDaEmpresa();
            daoClienteDaEmpresa.delete(id);
            return ResponseEntity.ok().build();
        }catch (SQLException erro){
            System.out.println("Erro ao excluir cliente: " + erro);
            return ResponseEntity.status(204).build();
        }
    }
}
