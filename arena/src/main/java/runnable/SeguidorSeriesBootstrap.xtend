package runnable

import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import repo.RepoSeries
import domain.Serie

class SeguidorSeriesBootstrap extends CollectionBasedBootstrap{
	
	override run() {
		val series = RepoSeries.instance
		
		val got = new Serie("Gameof Thrones", 7)
		val the100 = new Serie("The 100", 4)
		val vikings = new Serie("Vikings", 5)
		val lost = new  Serie("Lost", 6)
		val strangerthings = new Serie("Stranger things", 2)
		val oa = new Serie("The OA", 1)
		val outlander = new Serie("Outlander", 4)
		val amhorrstory = new Serie("American Horror Story", 9)
		val pb = new Serie("Prison Break", 5)
		val tbbt = new Serie("The Big Bang Theory", 11)	
		val simpsons = new Serie("The Simpsons", 29)
		val twd = new Serie("The Walking Dead", 8)
		val house = new Serie("Dr House", 8)
		val houseofcards = new Serie("House Of Cards", 5)
		
		//Cambio algunos estados
		got.vista
		house.vista
		simpsons.mirando
		twd.mirando
		strangerthings.mirando
		
		//Cambio  cantidad de temporadas vistas
		got.tempCompletadas = 7
		house.tempCompletadas = 8
		simpsons.tempCompletadas = 17
		twd.tempCompletadas = 3
		strangerthings.tempCompletadas = 1
		
		//CAargo las series en el repo
		series => [
			create(got)
			create(the100)
			create(vikings)
			create(lost)
			create(strangerthings)
			create(oa)
			create(outlander)
			create(amhorrstory)
			create(pb)
			create(tbbt)
			create(simpsons)
			create(twd)
			create(house)
			create(houseofcards)
		]
	}
	
}