package repo

import org.uqbar.commons.model.CollectionBasedRepo
import domain.Serie
import org.uqbar.commons.model.exceptions.UserException

class RepoSeries extends CollectionBasedRepo<Serie> {
	
	//Lo hice y despuess me di cuenta que no lo necesito :P
	override validateCreate(Serie serie) {
		if (allInstances.filter [serieDB | serie.equals(serieDB)].toList.length > 0) {
			throw new UserException("La serie " + serie.nombre + " ya existe.");
		}
	}
	
	def search(String name) {
    	allInstances.filter [serie | (serie.nombre).contains(name) ].toList
	}
	
	override protected getCriterio(Serie arg0) {
		null
	}
	
	override createExample() {
		new Serie
	}
	
	override getEntityType() {
		typeof(Serie)
	}
	
	//Defino el singleton del repo
	static RepoSeries instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoSeries()
		}
		instance
	}
	
}