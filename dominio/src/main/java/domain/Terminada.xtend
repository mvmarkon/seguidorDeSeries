package domain

class Terminada extends Estado{
	
	override getComoVenimos() {
		"Vista"
	}

	override puedePasarAPendiente() {
		true
	}
	
	override puedePasarAMirando() {
		true
	}
	
	override puedePasarAVista() {
		false
	}
	
}