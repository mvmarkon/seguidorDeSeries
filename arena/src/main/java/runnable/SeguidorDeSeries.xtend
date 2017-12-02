package runnable

import org.uqbar.arena.Application
import ui.SeguidorDeSeriesWindow

class SeguidorDeSeries extends Application {
	
	new() {
		super(new SeguidorSeriesBootstrap)
	}
	
	static def void main(String[] args) {
		new SeguidorDeSeries().start()
	}
	
	override protected createMainWindow() {
		new SeguidorDeSeriesWindow(this)
	}
	
}