object pepita {
  var energy = 100

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
  }
}

//////////////////////////////////////////////////////PRACTICA PARCIAL OBJETOS: WOLLOK//////////////////////////////////////////////////////

/////practica "Plataforma de pago" (del pela)

//PUNTO 1
class Contenido {
  const property titulo
  var property visitas // ya tiene el method visitas() = visitas
  var property esOfensivo = false
  var property monetizacion

  //cada contenido tiene una recaudacion de dinero, la cual depende de la recaudacion del tipo de monetizacion
  method recaudacion() = monetizacion.recaudacionDe(self)
  //cada contenido va a tener una instancia distinta pra esPopular(), pero ambos la poseen
  method esPopular ()
  //recaudaciones maximas segun tipo de monetizacion:
  method recaudacionMaximaParaPublicidades()
  
  //para el PUNTO 3
  method puedeVenderse() = self.esPopular() //depende de si es una imagen o video
  method monetizacion(nuevaMonetizacion){
    if(!monetizacion.puedeAplicarseA(self)) //si la monetizacion no puede aplicarse al contenido ... (debemos implementar puedeAplicarseA(contenido) dentro de monetizacion)
     throw new DomainException(message = "el contenido no acepta la forma de monetizacion")
     monetizacion = nuevaMonetizacion
  }

}

class Video inherits Contenido {
  override method esPopular() = visitas > 1000
  override method recaudacionMaximaParaPublicidades() = 10000
}

class Imagen inherits Contenido{
  const tags = []
  override method esPopular() = tagsDeModa.all{tag => tags.contains(tag)}  //cada tag de la lista tags, esta contenido en la lista tagsDeModa
  override method recaudacionMaximaParaPublicidades() = 4000
}

const tagsDeModa = ["fachero","aesthetic"]

//INSTANCIAS DE IMAGEN Y VIDEO:
const imagen1 = new Imagen (titulo = "imagen", visitas= 100, esOfensivo= false, monetizacion = publicidad, tags = ["aesthetic"])


//MONETIZACIONES:
//composicion con tipos de monetizacion
//usamos polimorfismo (cada uno entiende recaudacionDe() pero lo implementa de una manera distinta) --> una monetizacion es cada object que conoce recaudacionDe()

//necesitan entender recaudacionDe() ya que lo usamos en recaudacion() dentro de contenido
//dice cual es la recaudacion dependiendo del tipo de contenido --> se lo pasamos como parametro
  
object publicidad {
  method recaudacionDe(contenido) = 
  ((0.05 * contenido.visitas()) + if(contenido.esPopular()) 2000 else 0).min(contenido.recaudacionMaximaParaPublicidades())
  //minimo entre las visitas por 0.05 y el valor maximo para las publicidades (1000/4000)
  method puedeAplicarseA(contenido) = !contenido.esOfensivo()
}
class Donacion{
  var property donaciones = 0

  method recaudacionDe(contenido) = donaciones
  method puedeAplicarseA(contenido) = true
}

class Descarga{
  const property precio

  method recaudacionDe(contenido) = contenido.visitas() + precio
  method puedeAplicarseA(contenido) = contenido.puedeVenderse()  //se lo encargamos a la clase contenido, ya que depende de él si es un video/imagen
}

//PUNTO 2
class Usuario {
  const property nombre
  const property email
  var property estaVerificado = false

  const contenidos = []
  var property formaDeMonetizacion

  method dineroTotal() = contenidos.sum{contenido => contenido.recaudacion()}

// sirven para aplicar cantidadSuperUsuarios() en el object usuarios
  method contenidosPopularesUsuario() = contenidos.filter{contenido => contenido.esPopular()}
  method esSuperUsuario() = contenidos.contenidosPopularesUsuario().size() > 10

//PUNTO 3
/*method publicar(contenido, monetizacion) {
  //primero evaluamos la condicion
  if(!monetizacion.puedeAplicarseA(contenido)) //si la monetizacion no puede aplicarse al contenido ... (debemos implementar puedeAplicarseA(contenido) dentro de monetizacion)
     throw new DomainException(message = "el contenido no acepta la forma de monetizacion")
  //hacemos lo que debamos (si no tira error), sucede...
  else
  contenidos.add(contenido)
  contenido.monetizacion(monetizacion) //asociamos la monetizacion al contenido, pero no todas las monetizaciones se pueden aplicar a cualquier contenido --> si no se puede aplicar, tiramos una excepcion
}
/*////////// este metodo no sirve, ya que le pasamos por parametro la monetizacion, la cual es un atributo del contenido --> debemos pasarle el contenido, y que este se fije si puede aplicarse a la monetizacion

//PUNTO 3
method publicar(contenido) = contenidos.add(contenido)

}

//const usuarios = [] -> si declaramos la lista directamente, la consulta en la terminal luego se pierde --> nos conviene hacer un object
//ademas, si hacemos un objeto que contenga a todos los usuarios, podemos *mandarle mensajes*
object usuarios{
  //adentro va a contener la lista con usuarios, pero aca le podemos mandar mensajes
  const todosLosUsuarios = []

  method mailDeTodosLosUsuarios() = todosLosUsuarios.map{usuario => usuario.email()}

  method mailDeLosUsuariosMillonarios() = todosLosUsuarios.mailDeTodosLosUsuarios()
  .sortedBy{uno,otro => uno.dineroTotal() > otro.dineroTotal()}
  .take(100)

  method cantidadSuperUsuarios() = todosLosUsuarios.filter{usuario => usuario.esSuperUsuario()}.size()
}





