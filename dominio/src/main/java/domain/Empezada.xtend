package domain

class Empezada extends Estado{
	
	override getComoVenimos() {
		"Mirando"
	}
	
	override puedePasarAPendiente() {
		true
	}
	
	override puedePasarAMirando() {
		false
	}
	
	override puedePasarAVista() {
		true
	}
	
}