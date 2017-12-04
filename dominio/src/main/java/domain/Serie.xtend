package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@TransactionalAndObservable
class Serie extends Entity{
	String nombre
	int temporadas
	Estado estado
	
	new(){}
	
	new (String nombre, int temporadas) {
		this.nombre =  nombre
		this.temporadas = temporadas
		this.estado = new Pendiente
	}
	
	def mirando() {
		estado = new Empezada
	}
	
	def vista() {
		estado = new Terminada
	}
	
	def alFinalNoArranque() {
		estado = new Pendiente
	}

	@Dependencies("estado")
	def String getEstadoSerie() {
		estado.comoVenimos
	}
	
	def validarPendiente() {
		estado.puedePasarAPendiente
	}

	def validarMirando() {
		estado.puedePasarAMirando
	}

	def validarVista() {
		estado.puedePasarAVista
	}
	
}
