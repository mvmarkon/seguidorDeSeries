package appModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import domain.Serie
import repo.RepoSeries
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@Observable
class ControllerSeguidorSeries {

	static RepoSeries repoInstance = RepoSeries.instance
	
	List<Serie> series = buscarSeries("")
	Serie serieSeleccionada
	String nombreBusqueda = ""


	def buscarSeries(String nombre) {
		series = repoInstance.search(nombre);
		if(series.length > 0) {
			serieSeleccionada = series.head
		} else {
			val String temp = nombreBusqueda
			nombreBusqueda = ""
			throw new UserException("Busqueda sin resultados para " + temp + ", vuelva a intentar")
		}
		series
	}
	
	def reloadSeries() {
		series = repoInstance.search(nombreBusqueda);
	}
	
	def actualizarSerie() {		
		repoInstance.update(serieSeleccionada)
		reloadSeries
	}

	def pasarAPendiente() {
		if(serieSeleccionada.validarPendiente){			
			serieSeleccionada.alFinalNoArranque
			actualizarSerie
		} else {
			manejarErrorEstado()
		}
	}

	def pasarAMirando() {
		if(serieSeleccionada.validarMirando){
			serieSeleccionada.mirando
			actualizarSerie
		} else {
			manejarErrorEstado()
		}
	}

	def pasarAVista() {
		if(serieSeleccionada.validarVista){			
			serieSeleccionada.vista
			actualizarSerie
		} else {
			manejarErrorEstado()
		}
	}
	
	def manejarErrorEstado() {
		throw new UserException("La serie ya se encuentra en estado: "+ serieSeleccionada.estadoSerie)
	}
	
}