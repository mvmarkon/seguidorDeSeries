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

//  ESTO LO HABIA PLANTEADO PARA USAR EL SELECTOR 
//	def List<Integer> lista() {	
//		var lst = newArrayList()
//		for (i : 0 ..< (temporadas + 1)) {
//		    lst.add(i,i)
//		}
//		lst
//	}

	def porcentajeVisto() {
		(tempCompletadas * 100) / temporadas
	}

//	def void verificarTemporadas() {
//		if(tempCompletadas == temporadas && validarVista) vista
//		if(validarMirando && tempCompletadas != 0 && tempCompletadas <= temporadas) mirando 
//	}
}
