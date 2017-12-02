package appModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import domain.Serie

@Accessors
@Observable
class ControllerSeguidorSeries {

	List<Serie> series = newArrayList()
	Serie serieSeleccionada = null
	
}