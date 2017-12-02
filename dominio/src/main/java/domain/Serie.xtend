package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.Entity

@Accessors
@TransactionalAndObservable
class Serie extends Entity{
	String nombre
	int temporadas
	Estado estado = new Pendiente
	
	def mirando() {
		estado = new Empezada
	}
	
	def vista() {
		estado = new Terminada
	}
	
	def alFinalNoArranque() {
		estado = new Pendiente
	}
	
	def String getEstadoSerie() {
		estado.comoVenimos
	}
}
