!classDefinition: #TestCart category: 'Sistema'!
TestCase subclass: #TestCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!TestCart methodsFor: 'as yet unclassified' stamp: 'sc 2/8/2021 21:42:06'!
ACartWithABookIsNotEmpty

	|aCart|
	
	aCart := Cart new.
	
	aCart addTheBookWithTheISBN: 123.
	
	self deny: aCart isEmpty.! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'sc 2/8/2021 21:21:08'!
ANewCartIsEmpty
	|aCart|
	aCart := Cart new.
	
	self assert: aCart isEmpty
! !


!classDefinition: #Cart category: 'Sistema'!
Object subclass: #Cart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sistema'!

!Cart methodsFor: 'as yet unclassified' stamp: 'sc 2/8/2021 21:22:11'!
isEmtpy
	^true.! !
