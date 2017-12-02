package appModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import domain.Serie
import repo.RepoSeries

@Accessors
@Observable
class ControllerSeguidorSeries {

	List<Serie> series = buscarSeries("")
	Serie serieSeleccionada = null
	String nombreBusqueda = ""
	
	def buscarSeries(String nombre) {
		series = RepoSeries.instance.search(nombre);
	}
}