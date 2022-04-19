/* TODO:
 * 1 [x] Definir remiseras 
 * 2 [x] Definir clientes
 * 3 [x] Añadir remisera Lucía
 * 4 [x] Añadir cadeta Melina
 * 5 [x] Añadir oficina
 */

object oficina 
{
	var primeraRemisera
	var segundaRemisera
		
	// establece las remiseras de primera y de segunda opción.
	method asignarRemiseras(remisera1, remisera2)
	{
		primeraRemisera = remisera1
		segundaRemisera = remisera2
	} 
	
	// cambia la remisera de primera opción por el que se indica.
	method cambiarPrimerRemiserarPor(remisera) { primeraRemisera = remisera } 
	
	// cambia la remisera de segunda opción por el que se indica.
	method cambiarSegundoRemiseraPor(remisera) { segundaRemisera = remisera }
	
	
	// intercambia las remiseras de primera y segunda opción. O sea, la que era primera pasa a segunda, y viceversa.
	method intercambiarRemiseras()
	{
		// 1. Guardar remiseras anteriores
		const primeraRemiseraAnterior = primeraRemisera
		const segundaRemiseraAnterior = segundaRemisera
		
		// 2. Reemplazar nuevas remiseras por las guardadas anteriormente invirtiendo el orden
		primeraRemisera = segundaRemiseraAnterior
		segundaRemisera = primeraRemiseraAnterior
	} 
	
	/* Devuelve la remisera que corresponde asignar a un viaje, dados el cliente y la cantidad de kilómetros. 
	 * El criterio es el siguiente: si para ese viaje, el precio de la segunda remisera es menor al de la primera con una 
	 * diferencia de más de 30 pesos, entonces se elige la segunda remisera; si no, se elige la primera. 
 	 */
	method remiseraElegidaParaViaje(cliente, kms)
	{
		return if(primeraRemisera.precioDeViaje(cliente, kms) > (segundaRemisera.precioDeViaje(cliente, kms) + 30)) segundaRemisera else primeraRemisera
	}
	
}

/* #################
 * # ↓ Remiseras ↓ #
 * #################
 */

//Roxana le cobra a cada cliente el precio por kilómetro que pactó con la cooperativa sin variaciones.
object roxana
{
	method precioDeViaje(persona, distancia)
	{
		return persona.pesoPorKilometro() * distancia
	}
}

//Gabriela le aumenta un 20%, porque su auto de alta gama.
object gabriela
{
	method precioDeViaje(persona, distancia)
	{
		return (persona.pesoPorKilometro() * distancia) * 1.2
	}
}

//Mariela no aplica recargo, pero establece un mínimo de 50 pesos el viaje.
object mariela
{
	method precioDeViaje(persona, distancia)
	{
		return (persona.pesoPorKilometro() * distancia).max(50)
	}
}

//Juana por su parte, cobra 100 pesos hasta 8 kilómetros, y 200 pesos si son más de 8 kilómetros. A Juana no le importa lo que pactó la agencia, le cobra lo mismo a todos.
object juana {
	method precioDeViaje(persona, distancia)
	{
		return if(distancia < 8) 100 else 200 
	}
}

/* Lucía es una remisera que hace reemplazos.
 * O sea, cubre los turnos que las otras remiseras se tienen que tomar por alguna razón. 
 * Hay que informar a quién está reeemplazando Lucía. 
 * Lucía cobra lo mismo que la remisera a la que está reemplazando.
 */
 object lucia
 {
 	var reemplazoDe
 	method reemplazoDe() { return reemplazoDe }
 	method reemplazarA(remisera) { reemplazoDe = remisera }
 	
 	method precioDeViaje(persona, distancia) { return self.reemplazoDe().precioDeViaje(persona, distancia) }
 }


/* ################
 * # ↓ Clientes ↓ #
 * ################
 */

//Ludmila: 18 pesos el kilómetro, valor fijo e inamovible.
object ludmila
{
	method pesoPorKilometro() { return 18 }
}

//Ana María: 30 pesos el kilómetro si está económicamente estable, 25 pesos el kilómetro en caso contrario. Se sabe en cada momento si Ana María está o no económicamente estable.
object anaMaria 
{
	var economicamenteEstable = true
	method pesoPorKilometro() { return if(economicamenteEstable) 30 else 25 }
}

//Teresa: arranca en 22 pesos el kilómetro, puede cambiar a cualquier otro valor.
object teresa 
{
	var pesoPorKilometro = 22
	method pesoPorKilometro() { return pesoPorKilometro }
	method setPesoPorKilometro(nuevoValor) { pesoPorKilometro = nuevoValor }
}

/* Melina es una cadeta que trabaja para las otras clientas de la remisería. 
 * En cada momento trabaja para una clienta, se debe informar para quién. 
 * El precio por kilómetro pactado con Melina es 3 pesos menos que el precio de la clienta para quien esté trabajando en cada momento. 
 */
object melina 
{
	var trabajandoPara

	method trabajarPara(persona) { trabajandoPara = persona }
	
	method trabajandoPara() { return trabajandoPara }
	method pesoPorKilometro(){ return self.trabajandoPara().pesoPorKilometro() - 3 }
}