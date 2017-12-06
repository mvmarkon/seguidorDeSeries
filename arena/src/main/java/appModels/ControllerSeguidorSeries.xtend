package appModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import domain.Serie
import repo.RepoSeries
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils
import domain.SerieException

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
		series = repoInstance.search(nombreBusqueda)
		ObservableUtils.firePropertyChanged(serieSeleccionada, "tempCompletadas")
		ObservableUtils.firePropertyChanged(serieSeleccionada, "porcentajeVisto")
		ObservableUtils.firePropertyChanged(this, "porcentaje")
	}

	def actualizarSerie() {
		repoInstance.update(serieSeleccionada)
		reloadSeries
	}

	def pasarAPendiente() {
		try {
			serieSeleccionada.alFinalNoArranque
			checkTempsOnPendiente()
			actualizarSerie
		} catch (SerieException err) {
			manejarErrorEstado(err)
		}
	}

	def pasarAMirando() {
		try {
			serieSeleccionada.mirando
			checkTempsOnMirando()
			actualizarSerie
		} catch (Exception err) {
			manejarErrorEstado(err)
		}
	}

	def pasarAVista() {
		try {
			serieSeleccionada.vista
			checkTempsOnVista()
			actualizarSerie
		} catch (SerieException err) {
			manejarErrorEstado(err)			
		}
	}

	def manejarErrorEstado(Exception err) {
		throw new UserException(err.message)
	}
	
	def plusVisto() {
		changeVistasBy(1)
		checkEstadoOnPlus
	}

	def lessVisto() {
		changeVistasBy(-1)
		checkEstadoOnLess
	}
	
	def changeVistasBy(int n) {
		val nuevo = serieSeleccionada.tempCompletadas + n
		try {
			serieSeleccionada.tempCompletadas = nuevo
			actualizarSerie
			ObservableUtils.firePropertyChanged(serieSeleccionada, "tempCompletadas")
			ObservableUtils.firePropertyChanged(serieSeleccionada, "porcentajeVisto")
			ObservableUtils.firePropertyChanged(this, "porcentaje")
		} catch (SerieException err) {
			handleViewedError(err)			
		}
	}
	
	//Pseudo transformer para poder mostrar como porcentaje el nro entero que 
	//se calcula en el dominio (no me dejaba usar el .transformer en el binding del label)
	def getPorcentaje() {
		if(serieSeleccionada !== null) serieSeleccionada.porcentajeVisto.toString + " %"
	}
	
	def temporadasCompletas() {
		serieSeleccionada.tempCompletadas
	}

	def handleViewedError(Exception err) {
		throw new UserException(err.message)
	}
	
	
	
	/*
	 * Es unPLus pero quizas habria que pensarlo en el dominio(era mas rapido aca) tomarlo como un POC 
	 * 
	 */
	def void checkEstadoOnPlus() {
		if(serieSeleccionada.porcentajeVisto == 100 && serieSeleccionada.validarVista) {
			serieSeleccionada.vista
		} else {
			if(serieSeleccionada.porcentajeVisto > 0 && serieSeleccionada.porcentajeVisto < 100 && serieSeleccionada.validarMirando) serieSeleccionada.mirando
		}
	}

	def void checkEstadoOnLess() {
		if(serieSeleccionada.porcentajeVisto == 0 && serieSeleccionada.validarPendiente) {
			serieSeleccionada.alFinalNoArranque
		} else {
			if(serieSeleccionada.porcentajeVisto < 100 && serieSeleccionada.validarMirando) serieSeleccionada.mirando			
		}
	}

	def void checkTempsOnPendiente() {
		if(serieSeleccionada.porcentajeVisto > 0) serieSeleccionada.tempCompletadas = 0
	}

	def void checkTempsOnMirando() {
		if(serieSeleccionada.porcentajeVisto == 100) serieSeleccionada.tempCompletadas = serieSeleccionada.temporadas - 1
	}

	def void checkTempsOnVista() {
		if(serieSeleccionada.porcentajeVisto < 100) serieSeleccionada.tempCompletadas = serieSeleccionada.temporadas
	}
}