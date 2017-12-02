package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Serie {
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
