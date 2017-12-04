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
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.bindings.NotNullObservable

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
	}
	
	override protected createFormPanel(Panel pan) {
		title = "Seguidor De Series"
		
		createTwoBlocks(pan)		
	}
	
	def createTwoBlocks(Panel panel) {
		val hor = new Panel(panel).layout = new HorizontalLayout
		primero(hor)
		segundo(hor)
	}
	
	def primero(Panel hor) {
		val ver = new Panel(hor).layout = new VerticalLayout
		createSearchPanel(ver)
		
		createSeriesGrid(ver)
	}
	
	def segundo(Panel hor) {
		val ver = new Panel(hor).layout = new VerticalLayout
		
		createSerieStatus(ver)
		
	}
	
	def createSerieStatus(Panel panel) {
		val elementSelected = new NotNullObservable("serieSeleccionada") 
		new Label(panel) => [ 
				value <=> "serieSeleccionada.nombre" 
				fontSize = 18
				alignCenter
				bindVisible(elementSelected)
		]
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(it) => [ 
				text = "Temporadas:  " 
				fontSize = 13
				bindVisible(elementSelected)
			]
			new Label(it) => [ 
				value <=> "serieSeleccionada.temporadas" 
				fontSize = 13
				bindVisible(elementSelected)
			]	
		]
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(it) => [ 
				text = "Estado:  " 
				fontSize = 13
				bindVisible(elementSelected)
			]
			new Label(it) => [ 
				value <=> "serieSeleccionada.estadoSerie" 
				fontSize = 13
				bindVisible(elementSelected)
			]	
		]
		createBotoneraEstados(panel, elementSelected)
	}
	
	def createBotoneraEstados(Panel panel, NotNullObservable sel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Button(it) => [
				caption = "Vista"
				width = 100
				onClick([|modelObject.pasarAVista])
				bindEnabled(sel)
			]
			new Button(it) => [
				caption = "Mirando"
				width = 100
				onClick([|modelObject.pasarAMirando])
				bindEnabled(sel)
			]
			new Button(it) => [
				caption = "Pendiente"
				width = 100
				onClick([|modelObject.pasarAPendiente])
				bindEnabled(sel)
			]
		]
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
			bindContentsToProperty("estadoSerie")
		]

		
	}
	
}