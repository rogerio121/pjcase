package br.com.pjcase.testes;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class TesteConexao {
	public static void main(String[] args) {
		try {
			EntityManagerFactory factory = Persistence.createEntityManagerFactory("banco");
			System.out.println("Acessou");	
		}catch (Exception e) {
			System.out.println("Erro :"+e);
		}
		
	}

}
