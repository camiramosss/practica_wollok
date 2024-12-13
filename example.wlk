object pepita {
  var energy = 100

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
  }
}

//////////////////////////////////////////////////////PRÁCTICA PARCIAL OBJETOS: WOLLOK//////////////////////////////////////////////////////
/*
////////////////////////////////////////////////PRACTICA "Plataforma de pago" (del pela)//////////////////////////////////////

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
  override method puedeAlquilarse() = true
}

class Imagen inherits Contenido{
  const tags = []
  override method esPopular() = tagsDeModa.all{tag => tags.contains(tag)}  //cada tag de la lista tags, esta contenido en la lista tagsDeModa
  override method recaudacionMaximaParaPublicidades() = 4000
  override method puedeAlquilarse() = false
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
/*
//PUNTO 3
method publicar(contenido) = contenidos.add(contenido)

//para el PUNTO 4
method eliminarContenido(contenido) = if(contenido.puedeAlquilarse()) contenidos.remove(contenido)
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

//PUNTO 4
class Alquiler inherits Descarga{
  override method precio() = 1.max(super()) //como minimo 1, como maximo el valor que queda con el super (el comportamiento que hereda)
  override method puedeAplicarseA(contenido) = super(contenido) && contenido.puedeAlquilarse()
  method eliminarContenido(contenido) = 
}
*/


//////////////////////////////////////////////////////PRACTICA COMPUTADORAS//////////////////////////////////////////////////////
/*
//SUPERCOMPUTADORAS
class Supercomputadora {
  const equipos = []
  method estaActivo() = true
  
  //PUNTO 1 a)
  method equiposActivados() = equipos.filter{equipo => equipo.estaActivo()}
  
  // PUNTO 1 b)
  method capacidadDeComputoYConsumo() = equipos.sum{equipo => equipo.consumo()} + equipos.sum{equipo => equipo.unidadesDeComputo()}

  //PUNTO 1 c)
  method equipoConMayorConsumo() = equipos.max{equipo => equipo.consumo()}
  method equipoConMayorUnidadDeComputo() = equipos.max{equipo => equipo.unidadesDeComputo()}  
  method malConfigurada() = self.equipoConMayorConsumo() != self.equipoConMayorUnidadDeComputo()

  //PUNTO 2
  method complejidadProblema() = self.equiposActivados().size()
  method resolverProblema(problema) {
    self.equiposActivados().forEach{
      equipo => equipo.resolverProblema(new Problema (complejidad = problema.complejidad() / self.complejidadProblema()))}
  } //dividimos el problema en n equipos como tengamos, y le asignamos a cada uno, un problema con complejidad menor

}

//EQUIPOS
class Equipo{
  var property modo = standard
  var property uso = [10-1000].anyOne()
  var property estaQuemado = false
  
  method unidadesDeComputo () = modo.unidadesDeComputo()
  method consumo() = modo.consumo()

  method estaActivo() = !estaQuemado && self.unidadesDeComputo() > 0

  method consumoBase()
  method unidadesDeComputoBase()
  method extraPorOverclock()

  method resolverProblema(problema) {
    if(self.unidadesDeComputo()< problema.complejidad()) throw new DomainException(message = "unidades de computo insuficientes") modo.resolveProblema(self)
  }
  
}

class A105 inherits Equipo{
  override method consumoBase() = 300
  override method unidadesDeComputoBase() = 600

  override method extraPorOverclock() = 1.30

  override method resolverProblema(problema){
    if(problema.complejidad() <5) throw new DomainException(message = "el A105 no puede resolver problema con complejidad menor a 5")//validamos antes de actuar
    modo.resolveProblema(self)
    super(problema) // luego de validad lo extra para el A105, validamos lo general para todos los equipos
  }
}

class B2 inherits Equipo{
  var property microchipsInstalados
  override method consumoBase() = 50 * microchipsInstalados + 10
  override method unidadesDeComputoBase() = 100 * microchipsInstalados.min(800)
  
  override method extraPorOverclock() = 20 * microchipsInstalados

}

//MODOS 
object standard{
  method consumo(equipo) = equipo.consumoBase()
  method unidadesDeComputo(equipo) = equipo.unidadesDeComputoBase()
  method resolveProblema(equipo) {}
}

class Overclock{
  var usosRestantes

  method consumo(equipo) = equipo.consumoBase() * 2
  method unidadesDeComputo(equipo) = equipo.unidadesDeComputoBase() * equipo.extraPorOverclock()
  method usar(equipo) = equipo.uso(equipo.uso() -1)
  
  method estaQuemado(equipo) = equipo.uso(equipo.uso() -1) <= 0
  
  method resolveProblema(equipo){
    if(equipo.estaQuemado()) throw new DomainException(message="el equipo esta quemado")
    usosRestantes -= 1
  }
}

class AhorroDeEnergia{
  var problemasResueltos = 0

  method consumo(equipo) = 200
  method unidadesDeComputo(equipo) = equipo.unidadesDeComputo() / equipo.consumo()

  method resolveProblema(equipo) {
    problemasResueltos += 1
    if(problemasResueltos % 17 == 0) throw new DomainException(message="no se puede realizar")
  }
}

//PUNTO 2
class Problema{
  var property complejidad
}

//PUNTO 3
class APruebaDeFallos inherits AhorroDeEnergia{
  override method unidadesDeComputo(equipo) = super(equipo) / 2
  override method resolveProblema(equipo){
    if(problemasResueltos == 100) throw new DomainException (message = "falla de monitoreo")
  }
}
*/


//////////////////////////////////////////////////////PRACTICA SUPERHEROES//////////////////////////////////////////////////////
/*
// Punto 1
object ernesto {
  var energia = 50

  method comerAlfajor() {
    energia += energia * 0.1
  }
  method energia() = energia
  method puedeVolar() = false
}

// Punto 2
object uma {
  var property transporte = helicoptero
 
  method energia() = 500

  method puedeVolar() = transporte.puedeDespegar()
}

object helicoptero {
  var combustible = 100

  method combustible(cantidad) {
    combustible = cantidad
  }

  method puedeDespegar() = combustible > 10
}

object colectivo160 {
  method puedeDespegar() = false
}

// Punto 3
object misionEvitarChoque {
  method puedeCumplir(heroe) = heroe.energia() > 100
}

object misionSalvarAvion {
  method puedeCumplir(heroe) = heroe.puedeVolar()
}

// Punto 4
object aurora {
  var cirugiasDelDia = 0
  
  method energia() = 200 - (cirugiasDelDia * 5)
  
  method puedeVolar() = cirugiasDelDia > 2
  
  method hacerCirugia() {
    cirugiasDelDia += 1
  }

  method pasarDia() { cirugiasDelDia = 0 }
}
*/


//////////////////////////////////////////////////////PRACTICA ENTRADAS DE CINE//////////////////////////////////////////////////////
/*
object salaNoNumerada {
  var property asientos = 2
  var property sistemaDeSonido = dolbySuperSarraun
  var property entradaBase = 9000

method cambiarAsientos(n){
  asientos = n
}

method cambiarSistemaDeSonido(sistema){
  sistemaDeSonido = sistema
}

method valorEntrada () = (entradaBase + sistemaDeSonido.adicionalSegunSistema(self) - asientos).min(10000)
}

object salaNumerada {
  const property asientos = 240
  var property sistemaDeSonido = estandar
  var property entradaBase = 8000

method cambiarSistemaDeSonido(sistema){
  sistemaDeSonido = sistema
}

method valorEntrada () = entradaBase + sistemaDeSonido.adicionalSegunSistema(self)
}

//sistemas de sonido y adicionales segun sistema
object dolbySuperSarraun {
  method adicionalSegunSistema(sala) =
  if(sala.asientos() < 150) 1000
  else 2000
}

object qwert360XWF {
  method adicionalSegunSistema(sala) = sala.asientos() * 13
}

object estandar {
  method adicionalSegunSistema(sala) = 0
}
*/


//////////////////////////////////////////////////////PRACTICA TIERRA MEDIA//////////////////////////////////////////////////////
/////////////PRIMERA PARTE
/*
object gandalf{
  var property vida = 100
  const armas = [baculo, espadaGlamdring]

method cambiarVida(n) {
  vida = n.min(100)
}

method poder() = vida + armas.sum({arma => arma.poder()})

}

//armas
object baculo{
 var property poder = 400
}

object espadaGlamdring{
var property origen = elfico
method poder() = 10 * self.origen().valor()

}

//origenes
object elfico{
  var property valor = 25
}

object enano{
  var property valor = 25
}

object humano{
  var property valor = 15
}
*/


///////////////////////////////////////////////////EJEMPLO INTEGRADOR COLECCIONES////////////////////////////////////////////////////////
/*
class Heroe {
  const nombre
  const misiones = []
  method agregarMision(mision) {misiones.add(mision)}
  method cantidadDeMisiones() = misiones.size()
  method misionesDificiles() = misiones.filter({mision => mision.esDificil()})
  method solicitantes() = misiones.map({mision => mision.asignador()})
  method puntosTotales() = misiones.sum({mision => mision.puntosDeRecompensa()})
}

//Heroes
const shrek = new Heroe(nombre = "Shrek")
const yoshi = new Heroe(nombre = "Yoshi")

//Misiones
object liberarAFiona{
 var property trolls = 5
 method asignador() = "Lord Farquaad"
 method esDificil() = trolls.between(4,6)
 method puntosDeRecompensa() = trolls * 2
}

object buscarLaPiedraFilosofal{
  var property kms = 2
  method asignador() = "Dumbledore"
  method esDificil() = kms >=10
  method puntosDeRecompensa() = if(kms >50) 10 else 5
}
*/


/////////////////////////////////////////////////////PRACTICA WOLLOK GAME WORLDS////////////////////////////////////////
/*
//Jugadores
object caps{
  const antiguedad = 9
  var property cansancio = 0
  var property habilidad = antiguedad * 2 - cansancio  
  method puedeJugar () = antiguedad >3 && !(cansancio >= 100)
  method tomarEnergizante() {cansancio = (cansancio - 10).max(0)}

  method jugar(){cansancio = cansancio + 20}
}

object faker {
  var property habilidad = if(!estaTilteado) 100 else 0
  var property estaTilteado = true
  method tomarTecito() {estaTilteado = false}
  method puedeJugar() = !estaTilteado

  method jugar(){habilidad = habilidad + 30}
}

object josedeodo {
  const antiguedad = 7
  var property cansancio = 0
  var property habilidad = antiguedad * 2 - cansancio
  method tomarEnergizante() {cansancio = cansancio -10}
  method puedeJugar () = antiguedad >3 && (cansancio >= 100)

  method jugar(){cansancio = cansancio + 20}
}

//Equipos
class Equipo {
  const jugadores = []
  method quienesJuegan() = jugadores.filter({jugador => jugador.puedeJugar()})
  method habilidad() = jugadores.sum({jugador => jugador.habilidad()})
}

const equipo1 = new Equipo(jugadores = [faker,josedeodo])
const equipo2 = new Equipo(jugadores = [josedeodo, caps])

//Partidas
class Partida {
  const property jugadores = []
  method comenzarPartida(){
  jugadores.forEach({jugador => jugador.jugar()})
  }
  method ganador() = jugadores.max({jugador => jugador.habilidad()})
}

const partida1 = new Partida(jugadores = [faker,josedeodo])
const partida2 = new Partida(jugadores = [equipo1, equipo2])
*/


/////////////////////////////////////////////////////PRACTICA LA POROTA///////////////////////////////////////////////
/*
object laPorota {
  var property stock = 1
  var property precioPorGramo = 10

  method vender(cantidad, cliente){
    stock = stock - cantidad
    cliente.medioDePago().pagar(cantidad * precioPorGramo)
  }
}

//Clientes
class Cliente {
  var property medioDePago
}

const cami = new Cliente(medioDePago = tarjetaDeDebito)
const milito = new Cliente(medioDePago = tarjetaDeCredito)

//Medios de pago
object tarjetaDeCredito {
  var property deuda = 0
  method pagar(monto){
    deuda = deuda + monto}
}

object tarjetaDeDebito {
  var property dineroDisponible = 10000
  method pagar(monto){
    if(dineroDisponible < monto) throw new DomainException(message = "Saldo insuficiente")
    else dineroDisponible = dineroDisponible - monto}
}

object cupon{
  var property seUso = false
  const property montoMaximo = 1000
  method pagar(monto) {
    if(monto>montoMaximo) throw new DomainException(message = "Monto del cupon insuficiente")
    seUso = true
  }
}
*/


////////////////////////////////////////////////////////PRACTICA STREAM WARS///////////////////////////////////////////////////
/*
//Streams
class Stream {
  const invitados = []
  
  method viewers()
  method laEstaPegando() = self.nivelDeHype() > 60
  method nivelDeHype() = invitados.sum({invitado => invitado.popularidad()}).min(100)
  
  method costoDeProduccion()
  method gananciaBase() = self.viewers() * self.nivelDeHype()
  method ganancias() = self.gananciaBase() - self.costoDeProduccion()
}

class Sqv inherits Stream {
  var property canciones
  override method viewers() = 10000 * canciones
  override method costoDeProduccion() = 100
}

class Haa inherits Stream {
  var property sucesos
  method haceAnalisisSesudo() = self.realidadInteresante()
  method realidadInteresante() = sucesos > 10
  override method viewers() = if(self.haceAnalisisSesudo()) 2000 else 1000
  override method nivelDeHype() = 100
  override method costoDeProduccion() = 1000
}

class SesionIndependiente inherits Stream {
  var property suscriptores
  override method viewers() = suscriptores * (1..3).anyOne()
  override method costoDeProduccion() = self.gananciaBase() - self.gananciaBase() * 1.1
}


//Invitados
class Invitado {
  var property seguidores
  method popularidad () = seguidores / 2
  method juegaConMascotas(){
    seguidores = seguidores * 2
  }
}

//coscu(????)
class SesionDeCoscu inherits SesionIndependiente{
  var property momentoDelDia
  override method viewers() = super() + momentoDelDia.genteConectada()
}

//Momentos del dia
object maniana {
  method genteConectada() = 1000
}
object tarde{
  method genteConectada() = 5000
}
object noche{
  method genteConectada() = 10000
}

//object heredado
object streamX inherits SesionIndependiente (invitados = [], suscriptores = 100){}
*/


///////////////////////////////////////////////////////////////PRACTICA EL NUEVO MIGUELITO///////////////////////////////////////////////////
/*
//Platos
class Plato{
  method esAptoCeliacos()
  method valoracion()
  method esEspecial() = self.peso() > 250
  method precio() = self.valoracion()
  method peso()
}

class Provoleta inherits Plato{
  var property empanado
  override method esAptoCeliacos() = empanado
  override method esEspecial() = super() && empanado
  override method valoracion() = if(self.esEspecial()) 120 else 80
}

class Hamburguesa inherits Plato{
  var property pesoMedallon
  var property tipoDePan
  override method peso() = pesoMedallon + tipoDePan.pesoTipoDePan()
  override method esAptoCeliacos() = tipoDePan.panAptoCeliacos()
  override method valoracion() = self.peso() / 10
}

class HamburguesaDoble inherits Hamburguesa{
  override method peso() = super() * 2
  override method esEspecial() = self.peso() > 500
}

class CorteDeCarne inherits Plato{
  var property peso
  var property tipoCorte
  var property estaAPunto
  override method esEspecial() = super() && estaAPunto
  override method esAptoCeliacos() = true
  override method valoracion() = 100
}

class Parrillada inherits Plato{
  const property platos = []
  override method peso() = platos.sum({plato => plato.peso()})
  override method esEspecial() = super() && platos.size() >= 3
  override method esAptoCeliacos() = platos.all({plato => plato.esAptoCeliacos()})
  override method valoracion() = platos.max({plato => plato.valoracion()}).valoracion()   //la valoracion del plato con mayor valoracion, si no agregamos .valoracion() al final, nos devuelve el plato, no el numero
}

//Tipos de panes (para las hamburguesas)
object industrial{
  method panAptoCeliacos() = false
  method pesoTipoDePan() = 60
}
object casero{
  method panAptoCeliacos() = false
  method pesoTipoDePan() = 100
}
object maiz{
  method panAptoCeliacos() = true
  method pesoTipoDePan() = 30
}

//Parrilla El Miguelito
object elMiguelito{
  const menu = []
  const comensales = []
  method agregarPlatoAMenu(plato){menu.add(plato)}
  method platosAccesiblesCon(dinero) = menu.filter({plato => plato.precio() <= dinero})
  method hacerPromocion(dinero){
    comensales.forEach({comensal => comensal.recibirDinero(dinero)})  
  }
}

//Comensales
class Comensal{
  var property tipoComensal
  const property platosComprados = []
  var property dineroDisponible
 
  method seQuiereDarUnGusto() {
    if(self.platosQuePuedeComprar().isEmpty()){
       throw new DomainException(message = "no alcanza para ningun plato")}
    self.comprarPlato(self.platoElegido())
  }
 
  method platosQuePuedeComprar() = elMiguelito.platosAccesiblesCon(dineroDisponible).filter({plato => tipoComensal.leAgradaLaComida(plato)})
  method platoElegido() = self.platosQuePuedeComprar().max({plato => plato.valoracion()})
  
  method comprarPlato(plato){
    platosComprados.add(plato)
    dineroDisponible = dineroDisponible - plato.precio()
  }

  method recibirDinero(dinero){
    if(!platosComprados.isEmpty()){dineroDisponible = dineroDisponible + dinero}
  }

  method problemasGastricos(){
    self.cambiarTipoDelComensal(personaCeliaca)
  }
  method cambiarTipoDelComensal(nuevoTipo){
    tipoComensal = nuevoTipo
  }

  method volverseTodoTerreno(){
    self.cambiarTipoDelComensal(personaTodoTerreno)
  }

  method volversePaladarfino(){
    self.cambiarTipoDelComensal(personaDePaladarFino)
  }
}

object personaCeliaca{
  method leAgradaLaComida(comida) = comida.esAptoCeliacos()
}

object personaDePaladarFino{
  method leAgradaLaComida(comida) = comida.esEspecial() || comida.valoracion() > 100
}

object personaTodoTerreno{
  method leAgradaLaComida(comida) = true
}
*/

///////////////////////////////////////////////////////////////PARCIAL BRAWL/////////////////////////////////////////////////////////////
//Personajes
class Personaje{
  var property copas
  method destreza()
  method estrategia() = true

  method recibirCopas(n) {
    copas = copas + n
  }

  method restarCopas(n){
    copas = copas - n
  }
}

class Arquero inherits Personaje{
  var property agilidad
  var property rango 
  override method destreza() = agilidad * rango
  override method estrategia() = rango > 100
}

class Guerrero inherits Personaje{
  var property fuerza 
  override method destreza() = fuerza * 1.5
}

class Ballestero inherits Arquero{
  override method destreza() = super() * 2
}

//Misiones
class Mision{
  var property tipoMision
  method copasEnJuego()
  method repartirCopas()
  method puedeSerSuperada()
}

class MisionIndividual inherits Mision{
  var property personaje
  var property dificultad
  override method copasEnJuego() = dificultad * 2
  override method puedeSerSuperada() =  personaje.estrategia() || personaje.destreza() > dificultad
  
  override method repartirCopas(){
    if(personaje.copas() < 10) throw new DomainException (message = "La mision no puede comenzar")
    if (self.puedeSerSuperada()){
      personaje.recibirCopas(tipoMision.copasSegunMision(self))
    } else {
      personaje.restarCopas(tipoMision.copasSegunMision(self))
    }
  }

  method sumarCopaPorCadaParticipante() = self.copasEnJuego() + 1
}

class MisionPorEquipo inherits Mision{
  const property jugadores
  override method copasEnJuego() = 50 / jugadores.size()
  override method puedeSerSuperada() = self.masDeLaMitadTieneEstrategia() || self.cadaUnoTieneDestrezaMayorA(400)
  method masDeLaMitadTieneEstrategia() = jugadores.count({jugador => jugador.estrategia()}) >= jugadores.size() / 2
  method cadaUnoTieneDestrezaMayorA(numero) = jugadores.all({jugador => jugador.destreza() > numero})
  
  method copasMenorA60() = jugadores.sum({jugador => jugador.copas()}) < 60
  override method repartirCopas(){
    if(self.copasMenorA60()) throw new DomainException(message = "La mision no puede comenzar")
    if(self.puedeSerSuperada()){
      jugadores.forEach({jugador => jugador.recibirCopas(tipoMision.copasSegunMision(self))})
    } else {
      jugadores.forEach({jugador => jugador.restarCopas(tipoMision.copasSegunMision(self))})
    }
  }
  method sumarCopaPorCadaParticipante() = self.copasEnJuego() + jugadores.size()
}

//tipo misiones
object misionBoost{
  var property multiplicador = 1
  method copasSegunMision(mision) = mision.copasEnJuego() * multiplicador
}

object misionBonus{
  method copasSegunMision(mision) = mision.sumarCopaPorCadaParticipante()
}

object normal{
  method copasSegunMision(mision) = mision.copasEnJuego()
}