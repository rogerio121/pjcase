package br.com.pjcase.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class GenericDao <Entidade, IdEntidade>{

	protected EntityManager manager;
	
	private Class<Entidade> classeDaObjeto;

	/*A conexão é aberta ao instanciar a Dao. Assim depois de instanciar e usar é spo fechar a conexão*/
	public GenericDao(Class<Entidade> classeDaObjeto) {
		this.classeDaObjeto = classeDaObjeto;
		
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("banco");
		manager = factory.createEntityManager();
	}



	public void insert(Entidade entidade){
		try {
			manager.getTransaction().begin();
			manager.persist(entidade);
			manager.getTransaction().commit();

		}catch (Exception e) {
			System.out.println("Erro ao inserir objeto \nClasse GenericDao: " + e);
		}
	}

	public void update(Entidade entidade){
		try {
			manager.getTransaction().begin();
			manager.merge(entidade);
			manager.getTransaction().commit();

		} catch (Exception e) {
			System.out.println("Erro ao atualizar objeto \nClasse GenericDao: " + e);
		}
	}

	public void delete(IdEntidade id) {
		Entidade entidade = getObjectById(id);

		if(entidade != null) {
			try {
				manager.getTransaction().begin();
				manager.remove(entidade);
				manager.getTransaction().commit();

			} catch (Exception e) {
				System.out.println("Erro ao excluir objeto \nClasse GenericDao: " + e);
			}

		}
	}

	public Entidade getObjectById(IdEntidade id) {
		try {
			Entidade entidade = manager.find(classeDaObjeto, id);

			return entidade;

		}catch (Exception e) {
			System.out.println("Erro ao buscar objeto por id \nClasse GenericDao: " + e);

			return null;
		}
	} 
}
