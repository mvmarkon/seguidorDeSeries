package appModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import domain.Serie
import repo.RepoSeries
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils

@Accessors
@Observable
class ControllerSeguidorSeries {

	static RepoSeries repoInstance = RepoSeries.instance
	
	List<Serie> series = buscarSeries("")
	Serie serieSeleccionada
	String nombreBusqueda = ""

	def void setSerieSeleccionada(Serie serie) {
		serieSeleccionada = serie
		ObservableUtils.firePropertyChanged(this, "porcentaje")
	}

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
	
	def plusVisto() {
		changeVistasBy(1)
	}

	def lessVisto() {
		changeVistasBy(-1)
	}
	
	def changeVistasBy(int n) {
		val nuevo = temporadasCompletas + n
		if(cantTempValida(nuevo)) {		
			serieSeleccionada.tempCompletadas = nuevo
			actualizarSerie
			ObservableUtils.firePropertyChanged(serieSeleccionada, "tempCompletadas")
			ObservableUtils.firePropertyChanged(serieSeleccionada, "porcentajeVisto")
			ObservableUtils.firePropertyChanged(this, "porcentaje")
		} else {
			handleViewedError(nuevo)
		}
	}
	
	def getPorcentaje() {
		if(serieSeleccionada !== null) serieSeleccionada.porcentajeVisto.toString + " %"
	}
	
	def temporadasCompletas() {
		serieSeleccionada.tempCompletadas
	}

	def cantTempValida(int i) {
		i > -1 && i <= serieSeleccionada.temporadas 
	}
	
	def handleViewedError(int n) {
		throw new UserException( n + " no es una cantidad validad de temporadas vistas")
	}	
}