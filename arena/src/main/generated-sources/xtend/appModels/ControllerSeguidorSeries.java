package appModels;

import domain.Serie;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.model.annotations.Observable;

@Accessors
@Observable
@SuppressWarnings("all")
public class ControllerSeguidorSeries {
  private List<Serie> series = CollectionLiterals.<Serie>newArrayList();
  
  private Serie serieSeleccionada = null;
  
  @Pure
  public List<Serie> getSeries() {
    return this.series;
  }
  
  public void setSeries(final List<Serie> series) {
    this.series = series;
  }
  
  @Pure
  public Serie getSerieSeleccionada() {
    return this.serieSeleccionada;
  }
  
  public void setSerieSeleccionada(final Serie serieSeleccionada) {
    this.serieSeleccionada = serieSeleccionada;
  }
}
