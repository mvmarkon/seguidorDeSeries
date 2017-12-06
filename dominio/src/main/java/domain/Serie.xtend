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
	int tempCompletadas
	
	new(){}
	
	new (String nombre, int temporadas) {
		this.nombre =  nombre
		this.temporadas = temporadas
		this.estado = new Pendiente
		this.tempCompletadas = 0
	}

	def void  setTempCompletadas(int n) {
		if(cantTempValida(n)) {
			tempCompletadas = n
		} else {
			throw new SerieException( n + " no es un nro valido de temporadas vistas");
		}
	}

	def cantTempValida(int i) {
		i > -1 && i <= temporadas 
	}

	def mirando() {
		if(validarMirando){
			estado = new Empezada
		} else {
			errorEstado
		}
	}
	
	def vista() {
		if(validarVista) {
			estado = new Terminada
		} else {
			errorEstado
		}
	}
	
	def alFinalNoArranque() {
		if(validarPendiente) {
			estado = new Pendiente
		} else {
			errorEstado
		}
	}

	def errorEstado() {
		throw new SerieException("La serie ya se encuentra en estado: "+ estadoSerie)
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

	def porcentajeVisto() {
		(tempCompletadas * 100) / temporadas
	}

}
