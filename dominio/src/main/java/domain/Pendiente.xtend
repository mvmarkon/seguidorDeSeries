package domain

class Pendiente extends Estado {
	
	override getComoVenimos() {
		"Pendiente"
	}
	
	override puedePasarAPendiente() {
		false
	}
	
	override puedePasarAMirando() {
		true
	}
	
	override puedePasarAVista() {
		true
	}
}