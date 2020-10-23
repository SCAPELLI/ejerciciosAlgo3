!classDefinition: #Carbon category: 'tp1'!
DenotativeObject subclass: #Carbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tp1'!


!classDefinition: #CintaDeTransporteDeMineralesAzul category: 'tp1'!
DenotativeObject subclass: #CintaDeTransporteDeMineralesAzul
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tp1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaDeTransporteDeMineralesAzul class' category: 'tp1'!
CintaDeTransporteDeMineralesAzul class
	instanceVariableNames: 'coleccionDeMinerales destinoDeDescarga'!

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:34:35'!
cargar: unaColeccionDeMinerales
	coleccionDeMinerales addAll: unaColeccionDeMinerales.! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:34:35'!
descargar
	destinoDeDescarga cargar: coleccionDeMinerales .
	coleccionDeMinerales removeAll.! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:34:36'!
descargarEn: unDestinoDeDescarga
	destinoDeDescarga := unDestinoDeDescarga! !

!CintaDeTransporteDeMineralesAzul class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:52:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	coleccionDeMinerales := ((OrderedCollection new)).
	destinoDeDescarga := ContenedorDeMinerales.! !


!classDefinition: #CintaDeTransporteDeMineralesRoja category: 'tp1'!
DenotativeObject subclass: #CintaDeTransporteDeMineralesRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tp1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaDeTransporteDeMineralesRoja class' category: 'tp1'!
CintaDeTransporteDeMineralesRoja class
	instanceVariableNames: 'coleccionDeMinerales destinoDeDescarga'!

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:26:36'!
cargar: unaColeccionDeMinerales
	coleccionDeMinerales addAll: unaColeccionDeMinerales.! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:26:36'!
descargar
	destinoDeDescarga cargar: coleccionDeMinerales .
	coleccionDeMinerales removeAll.! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:26:36'!
descargarEn: unDestinoDeDescarga
	destinoDeDescarga := unDestinoDeDescarga! !

!CintaDeTransporteDeMineralesRoja class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:52:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	coleccionDeMinerales := ((OrderedCollection new) add: #Carbon; yourself).
	destinoDeDescarga := CintaDeTransporteDeMineralesAzul.! !


!classDefinition: #ContenedorDeMinerales category: 'tp1'!
DenotativeObject subclass: #ContenedorDeMinerales
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tp1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ContenedorDeMinerales class' category: 'tp1'!
ContenedorDeMinerales class
	instanceVariableNames: 'coleccionDeMinerales'!

!ContenedorDeMinerales class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 01:59:03'!
cargar: unaColeccionDeMinerales
	coleccionDeMinerales addAll: unaColeccionDeMinerales.! !

!ContenedorDeMinerales class methodsFor: 'as yet unclassified' stamp: 'SC 10/22/2020 23:18:09'!
est·Vacio
	^coleccionDeMinerales isEmpty.! !

!ContenedorDeMinerales class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:52:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	coleccionDeMinerales := ((OrderedCollection new) add: #Hierro; yourself).! !

!ContenedorDeMinerales class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:12:26'!
obtenerMineralesAcumulados
	^coleccionDeMinerales.! !

!ContenedorDeMinerales class methodsFor: 'as yet unclassified' stamp: 'SC 10/22/2020 23:19:57'!
vaciar
	coleccionDeMinerales removeAll.! !


!classDefinition: #ExtractorDeCarbon category: 'tp1'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tp1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'tp1'!
ExtractorDeCarbon class
	instanceVariableNames: 'destinoDeExtraccion'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:19:39'!
extraer
	destinoDeExtraccion cargar: #(Carbon).! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 01:42:38'!
extraerEn: unDestinoDeExtraccion.
	destinoDeExtraccion := unDestinoDeExtraccion.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:52:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destinoDeExtraccion := CintaDeTransporteDeMineralesRoja.! !


!classDefinition: #ExtractorDeHierro category: 'tp1'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tp1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'tp1'!
ExtractorDeHierro class
	instanceVariableNames: 'destinoDeExtraccion'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:19:56'!
extraer
	destinoDeExtraccion cargar: #(Hierro).! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:13:55'!
extraerEn: unDestinoDeExtraccion.
	destinoDeExtraccion := unDestinoDeExtraccion.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'SC 10/23/2020 02:52:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destinoDeExtraccion := CintaDeTransporteDeMineralesAzul.! !


!classDefinition: #Hierro category: 'tp1'!
DenotativeObject subclass: #Hierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tp1'!

CintaDeTransporteDeMineralesAzul initializeAfterFileIn!
CintaDeTransporteDeMineralesRoja initializeAfterFileIn!
ContenedorDeMinerales initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!