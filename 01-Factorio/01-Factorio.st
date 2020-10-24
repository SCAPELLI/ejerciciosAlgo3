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

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:47:38'!
conectarADestino: unDestinoDeDescarga
	destinoDeDescarga := unDestinoDeDescarga! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 18:25:57'!
descargar
	"destinoDeDescarga cargarTodo: coleccionDeMinerales."
	coleccionDeMinerales do: [:unMineral | destinoDeDescarga cargar: unMineral].
	self vaciar! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:35:00'!
est·Vacio
	^coleccionDeMinerales isEmpty.! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:52:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	coleccionDeMinerales := ((OrderedCollection new)).
	destinoDeDescarga := CintaDeTransporteDeMineralesRoja.! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 18:25:05'!
vaciar

	coleccionDeMinerales removeAll.! !


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

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:47:38'!
conectarADestino: unDestinoDeDescarga
	destinoDeDescarga := unDestinoDeDescarga! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 18:21:33'!
descargar
	"destinoDeDescarga cargarTodo: coleccionDeMinerales."
	coleccionDeMinerales do: [:unMineral | destinoDeDescarga cargar: unMineral].
	self vaciar ! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:50:04'!
est·Vacio
	^coleccionDeMinerales isEmpty.! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:52:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	coleccionDeMinerales := ((OrderedCollection new)).
	destinoDeDescarga := Contenedor.! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 18:21:08'!
vaciar

	coleccionDeMinerales removeAll ! !


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

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:52:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #hierro; add: #carbon; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 18:08:29'!
vaciar
	contenido removeAll.! !


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

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:51:35'!
conectarADestino: unDestinoDeExtraccion.
	destinoDeExtraccion := unDestinoDeExtraccion.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 12:41:12'!
extraer
	destinoDeExtraccion cargar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:52:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destinoDeExtraccion := CintaDeTransporteDeMineralesAzul.! !


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

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:51:35'!
conectarADestino: unDestinoDeExtraccion.
	destinoDeExtraccion := unDestinoDeExtraccion.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 14:52:08'!
extraer
	destinoDeExtraccion cargar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 20:52:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destinoDeExtraccion := CintaDeTransporteDeMineralesRoja.! !


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

!FactorioTest class methodsFor: 'escenario 1' stamp: 'FL 10/24/2020 20:51:35'!
configurarCircuitoExtractorCaja.
	Contenedor vaciar.
	ExtractorDeCarbon conectarADestino: Contenedor.
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


!FactorioTest class methodsFor: 'escenario 2' stamp: 'FL 10/24/2020 20:51:35'!
configurarCircuitoExtractorCintaCaja
	"No se olviden de vaciar la cinta tambien!!"
	"Conectamos el extractor a la cinta, luego conectamos la cinta a la caja"

	Contenedor vaciar.
	CintaDeTransporteDeMineralesAzul vaciar.
	ExtractorDeCarbon conectarADestino: CintaDeTransporteDeMineralesAzul .
	CintaDeTransporteDeMineralesAzul conectarADestino: Contenedor.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'SC 10/23/2020 14:28:33'!
hacerAndarCircuitoExtractorCintaCaja
	"Hacemos andar el extractor, asi deja un carbon en la cinta.
	Luego hacemos andar la cinta (con algun mensaje) y deberia dejar el carbon en la caja.	"
	ExtractorDeCarbon extraer .
	CintaDeTransporteDeMineralesAzul descargar .! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'FL 10/24/2020 18:44:06'!
test02ExtractorCintaCaja
	"Tambien tenemos que chequear que en la cinta no haya nada. Cero carbon."
	
	self configurarCircuitoExtractorCintaCaja.
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	Assert isTrue: CintaDeTransporteDeMineralesAzul est·Vacio.! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'FL 10/24/2020 20:51:35'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	CintaDeTransporteDeMineralesAzul vaciar.
	CintaDeTransporteDeMineralesRoja vaciar.
	Contenedor vaciar.
	ExtractorDeCarbon conectarADestino: CintaDeTransporteDeMineralesAzul.
	ExtractorDeHierro conectarADestino: CintaDeTransporteDeMineralesRoja.
	CintaDeTransporteDeMineralesAzul conectarADestino: 	CintaDeTransporteDeMineralesRoja.
	CintaDeTransporteDeMineralesRoja conectarADestino: Contenedor.
	
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'FL 10/24/2020 18:36:03'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja

	"Hacemos andar el extractor, asi deja un carbon en la cinta."
	"Lo mismo con el otro extractor, asi deja una mena de hierro en la otra cinta.
	Hacemos andar la cinta con la mena de hierro, asi la deposita en la cinta que tiene el carbon.
	Ahora podemos hacer andar la ultima cinta, la que recibiÛ primero el carbon 
	y ahora tambien tiene el hierro y que deje todo en el Contenedor."
	
	ExtractorDeCarbon extraer.
	ExtractorDeHierro extraer.
	CintaDeTransporteDeMineralesAzul descargar.
	CintaDeTransporteDeMineralesRoja descargar.
	! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'FL 10/24/2020 18:39:28'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.

	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	Assert isTrue: CintaDeTransporteDeMineralesAzul est·Vacio.
	Assert isTrue: CintaDeTransporteDeMineralesRoja est·Vacio.! !

CintaDeTransporteDeMineralesAzul initializeAfterFileIn!
CintaDeTransporteDeMineralesRoja initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!