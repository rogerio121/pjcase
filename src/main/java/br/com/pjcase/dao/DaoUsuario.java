package br.com.pjcase.dao;

import br.com.pjcase.model.Usuario;

public class DaoUsuario extends GenericDao<Usuario, String> {

	public DaoUsuario(Class<Usuario> classeDaObjeto) {
		super(classeDaObjeto);
	}
	
}
