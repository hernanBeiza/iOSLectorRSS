# iOSLectorRSS
## Resumen
**iOSLectorRSS** es un lector de RSS desarrollada para *moofwd*.

### Detalles

Está compuesta por:

* ViewController principal: muestra los feed cargados desde el XML. *UITableView. UITableViewCell*. Hay una clase personalizada que leer el RSS, lo parsea y se lo pasa a la vista principal.

* DetalleViewController: vista que muestra el detalle del feed. Utiliza la clase *SD Image Downloader* para facilitar el proceso de la carga