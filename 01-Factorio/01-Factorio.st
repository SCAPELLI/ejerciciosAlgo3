!classDefinition: #CintaDeTransporteDeMineralesAzul category: 'FactorioTP1'!
DenotativeObject subclass: #CintaDeTransporteDeMineralesAzul
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioTP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaDeTransporteDeMineralesAzul class' category: 'FactorioTP1'!
CintaDeTransporteDeMineralesAzul class
	instanceVariableNames: 'coleccionDeMinerales destinoDeDescarga'!

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 12:42:44'!
cargar: unMineral
	coleccionDeMinerales add: unMineral.! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:42:30'!
descargar
	"destinoDeDescarga cargarTodo: coleccionDeMinerales."
	coleccionDeMinerales do: [:unMineral | destinoDeDescarga cargar: unMineral].
	coleccionDeMinerales := OrderedCollection new.! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:34:36'!
descargarEn: unDestinoDeDescarga
	destinoDeDescarga := unDestinoDeDescarga! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:35:00'!
est·Vacio
	^coleccionDeMinerales isEmpty.! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:53:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	coleccionDeMinerales := ((OrderedCollection new)).
	destinoDeDescarga := Contenedor.! !


!classDefinition: #CintaDeTransporteDeMineralesRoja category: 'FactorioTP1'!
DenotativeObject subclass: #CintaDeTransporteDeMineralesRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioTP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaDeTransporteDeMineralesRoja class' category: 'FactorioTP1'!
CintaDeTransporteDeMineralesRoja class
	instanceVariableNames: 'coleccionDeMinerales destinoDeDescarga'!

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:50:04'!
cargar: unMineral
	coleccionDeMinerales add: unMineral.! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:50:04'!
descargar
	"destinoDeDescarga cargarTodo: coleccionDeMinerales."
	coleccionDeMinerales do: [:unMineral | destinoDeDescarga cargar: unMineral].
	coleccionDeMinerales := OrderedCollection new.! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:50:04'!
descargarEn: unDestinoDeDescarga
	destinoDeDescarga := unDestinoDeDescarga! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:50:04'!
est·Vacio
	^coleccionDeMinerales isEmpty.! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:53:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	coleccionDeMinerales := ((OrderedCollection new) add: #carbon; yourself).
	destinoDeDescarga := Contenedor.! !


!classDefinition: #Contenedor category: 'FactorioTP1'!
DenotativeObject subclass: #Contenedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioTP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Contenedor class' category: 'FactorioTP1'!
Contenedor class
	instanceVariableNames: 'contenido'!

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:20:42'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:21:08'!
cantidadDeMenas
	^contenido size.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 12:47:43'!
cargar: unMineral
	contenido add: unMineral.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 12:47:51'!
est·Vacio
	^contenido isEmpty.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:53:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #carbon; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 12:46:57'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'FactorioTP1'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioTP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'FactorioTP1'!
ExtractorDeCarbon class
	instanceVariableNames: 'destinoDeExtraccion'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:23:21'!
conectarA: unDestinoDeExtraccion.
	destinoDeExtraccion := unDestinoDeExtraccion.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 12:41:12'!
extraer
	destinoDeExtraccion cargar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:53:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destinoDeExtraccion := Contenedor.! !


!classDefinition: #ExtractorDeHierro category: 'FactorioTP1'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioTP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'FactorioTP1'!
ExtractorDeHierro class
	instanceVariableNames: 'destinoDeExtraccion'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:50:17'!
conectarA: unDestinoDeExtraccion.
	destinoDeExtraccion := unDestinoDeExtraccion.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:52:08'!
extraer
	destinoDeExtraccion cargar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:53:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destinoDeExtraccion := CintaDeTransporteDeMineralesAzul.! !


!classDefinition: #FactorioTest category: 'FactorioTP1'!
DenotativeObject subclass: #FactorioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioTP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FactorioTest class' category: 'FactorioTP1'!
FactorioTest class
	instanceVariableNames: ''!

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SC 10/23/2020 14:23:00'!
configurarCircuitoExtractorCaja.
	Contenedor vaciar.
	ExtractorDeCarbon conectarA: Contenedor.
! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SC 10/23/2020 14:24:18'!
hacerAndarCircuitoExtractorCaja

	ExtractorDeCarbon extraer.
	! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SC 10/23/2020 14:22:31'!
test01ExtractorCaja
	self configurarCircuitoExtractorCaja.
	self hacerAndarCircuitoExtractorCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.! !


!FactorioTest class methodsFor: 'escenario 2' stamp: 'SC 10/23/2020 14:27:08'!
configurarCircuitoExtractorCintaCaja
	"No se olviden de vaciar la cinta tambien!!"
	"Conectamos el extractor a la cinta, luego conectamos la cinta a la caja"

	Contenedor vaciar.
	ExtractorDeCarbon conectarA: CintaDeTransporteDeMineralesAzul .
	CintaDeTransporteDeMineralesAzul descargarEn: Contenedor.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'SC 10/23/2020 14:28:33'!
hacerAndarCircuitoExtractorCintaCaja
	"Hacemos andar el extractor, asi deja un carbon en la cinta.
	Luego hacemos andar la cinta (con algun mensaje) y deberia dejar el carbon en la caja.	"
	ExtractorDeCarbon extraer .
	CintaDeTransporteDeMineralesAzul descargar .! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'SC 10/23/2020 14:44:42'!
test02ExtractorCintaCaja
	"Tambien tenemos que chequear que en la cinta no haya nada. Cero carbon."
	
	self configurarCircuitoExtractorCintaCaja.
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	Assert that: CintaDeTransporteDeMineralesAzul est·Vacio isEqualTo: true.! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'SC 10/23/2020 14:37:01'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	Contenedor vaciar.
	"Adem·s de vaciar el Contenedor (arriba) tambiÈn vaciamos las dos cintas"
	"Conectamos el extractor de carbon a una de las cintas"
	"Conectamos el extractor de hierro a la otra cinta"
	"Ahora conectamos la primer cinta al Contenedor"
	"Y conectamos la segunda cinta a la primer cinta"
	
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'SC 10/23/2020 14:36:43'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja

	"Hacemos andar el extractor, asi deja un carbon en la cinta."
	
	"Lo mismo con el otro extractor, asi deja una mena de hierro en la otra cinta.
	
	Hacemos andar la cinta con la mena de hierro, asi la deposita en la cinta que tiene el carbon.
	
	Ahora podemos hacer andar la ultima cinta, la que recibiÛ primero el carbon 
	
	y ahora tambien tiene el hierro y que deje todo en el Contenedor."! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'SC 10/23/2020 14:51:12'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.

	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	Assert that: CintaDeTransporteDeMineralesAzul est·Vacio isEqualTo: true.
	Assert that: CintaDeTransporteDeMineralesRoja est·Vacio isEqualTo: true.! !

CintaDeTransporteDeMineralesAzul initializeAfterFileIn!
CintaDeTransporteDeMineralesRoja initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!