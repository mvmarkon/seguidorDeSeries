package domain

abstract class Estado {
	
	def String getComoVenimos()
	
	def boolean puedePasarAPendiente()
	
	def boolean puedePasarAMirando()
	
	def boolean puedePasarAVista()
	
	
}