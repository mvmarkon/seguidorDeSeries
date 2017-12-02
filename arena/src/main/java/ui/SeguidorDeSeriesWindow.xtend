package ui

import appModels.ControllerSeguidorSeries
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import domain.Serie
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import domain.Estado

class SeguidorDeSeriesWindow extends SimpleWindow<ControllerSeguidorSeries>{
	
	new(WindowOwner parent) {
		super(parent, new ControllerSeguidorSeries)
	}
	
	def createSearchPanel (Panel parentPanel) {
		val searchPanel = new Panel(parentPanel).layout = new HorizontalLayout
		
		new TextBox(searchPanel) => [
			value <=> "nombreBusqueda"
			width = 290
		]
		new Button(searchPanel) => [
			caption = "Buscar"
			width = 70
			onClick(|this.realizarBusueda)
		]
	}
	
	def realizarBusueda() {
		modelObject.buscarSeries(modelObject.nombreBusqueda)
	}

	override protected addActions(Panel arg0) {
		//throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected createFormPanel(Panel pan) {
		title = "Seguidor De Series"

		createSearchPanel(pan)
		
		createSeriesGrid(pan)
	}
	
	def createSeriesGrid(Panel grilla) {
		val grid = new Table<Serie>(grilla, typeof(Serie)) => [
			items <=> "series"
			value <=> "serieSeleccionada"
			numberVisibleRows = 5
		]
		
		showSeriesGrid(grid)
	}
	
	def showSeriesGrid(Table<Serie> table) {
		new Column<Serie>(table) => [
			title = "Nombre"
			fixedSize = 200
			bindContentsToProperty("nombre")
		]
		new Column<Serie>(table) => [
			title = "Temporadas"
			fixedSize = 90
			bindContentsToProperty("temporadas")
		]
		new Column<Serie>(table) => [
			title = "Estado"
			fixedSize = 100
			bindContentsToProperty("estado").transformer = [Estado es | es.comoVenimos]
		]

		
	}
	
}