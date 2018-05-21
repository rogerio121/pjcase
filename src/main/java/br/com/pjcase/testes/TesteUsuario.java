package br.com.pjcase.testes;

import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Usuario;

public class TesteUsuario {
	
	public static void main(String[] args) {
		inserirUsuario();
		//updateUsuario();
		//deleteUsuario();
	}
	
	public static void inserirUsuario() {
		Usuario usr = new Usuario();
		usr.setCpf("050.157.350-06");
		usr.setNome("Rogério Teste");
		usr.setEmail("email@teste.com");
		usr.setRg("25.164.386-4");
		usr.setSenha("123456");
		
		DaoUsuario daoUsuario = new DaoUsuario(Usuario.class);
		
		daoUsuario.insert(usr);
	}
	
	public static void updateUsuario() {
		Usuario usr = new Usuario();
		usr.setCpf("050.157.350-06");
		usr.setNome("Rogério Teste");
		usr.setEmail("email@teste.com");
		usr.setRg("25.164.386-4");
		usr.setSenha("123");
		
		DaoUsuario daoUsuario = new DaoUsuario(Usuario.class);
		
		daoUsuario.update(usr);
	}
	
	public static void deleteUsuario() {
		Usuario usr = new Usuario();
		usr.setCpf("050.157.350-06");
		
		DaoUsuario daoUsuario = new DaoUsuario(Usuario.class);
		
		daoUsuario.delete(usr.getCpf());
	}
}
