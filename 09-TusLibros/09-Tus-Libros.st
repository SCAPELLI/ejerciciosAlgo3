!classDefinition: #TestCart category: '09-Tus-Libros'!
TestCase subclass: #TestCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '09-Tus-Libros'!

!TestCart methodsFor: 'tests' stamp: 'FL 2/9/2021 18:46:45'!
test01_aNewCartIsEmpty

	|aCart|
	
	aCart := Cart new.
	
	self assert: aCart isEmpty
! !

!TestCart methodsFor: 'tests' stamp: 'FL 2/9/2021 18:39:22'!
test02_aValidItemCanBeAddedToCart

	|aCart bookISBN validationBlock |
		
	aCart := Cart new.
	bookISBN := 9788498388886.
	validationBlock := [:aISBN | (aISBN asString size = 13) and: [(aISBN asString copyFrom: 6 to: 9) = '9838' ]].
	
	aCart add: bookISBN ifValidate: validationBlock.
	
	self deny: aCart isEmpty.! !

!TestCart methodsFor: 'tests' stamp: 'FL 2/9/2021 19:09:32'!
test03_CanAddManyItems


	|aCart bookISBN validationBlock |
		
	aCart := Cart new.
	bookISBN := 9788498388886.
	validationBlock := [:aISBN | (aISBN asString size = 13) and: [(aISBN asString copyFrom: 6 to: 9) = '9838' ]].
	
	aCart add: bookISBN ifValidate: validationBlock.
	aCart add: bookISBN ifValidate: validationBlock.
	
	self deny: aCart isEmpty.
	self assert: aCart totalItems equals: 2.! !

!TestCart methodsFor: 'tests' stamp: 'FL 2/9/2021 19:25:56'!
test04_CanAddManyItemsAtOneTime


	|aCart bookISBN validationBlock |
		
	aCart := Cart new.
	bookISBN := 9788498388886.
	validationBlock := [:aISBN | (aISBN asString size = 13) and: [(aISBN asString copyFrom: 6 to: 9) = '9838' ]].
	
	aCart add: 10 itemsOf: bookISBN ifValidate: validationBlock.
	
	self deny: aCart isEmpty.
	self assert: aCart totalItems equals: 10.! !

!TestCart methodsFor: 'tests' stamp: 'FL 2/9/2021 19:38:36'!
test05_

! !


!classDefinition: #Cart category: '09-Tus-Libros'!
Object subclass: #Cart
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: '09-Tus-Libros'!

!Cart methodsFor: 'accessing' stamp: 'FL 2/9/2021 19:22:56'!
add: anItem ifValidate: aValidationBlock

	(aValidationBlock value: anItem) 
		ifTrue: [
			items at: anItem 
				ifPresent: [:units | items at: anItem put: units + 1] 
				ifAbsent:[items at: anItem put: 1]]
		ifFalse: ['The item is invalid and cant be added to cart'].! !

!Cart methodsFor: 'accessing' stamp: 'FL 2/9/2021 19:30:37'!
add: amount itemsOf: anSpecificItem ifValidate: validationBlock
	
	self add: anSpecificItem ifValidate: validationBlock.
	items at: anSpecificItem ifPresent: [:totalUnits | items at: anSpecificItem put: (totalUnits + amount -1)].! !

!Cart methodsFor: 'accessing' stamp: 'FL 2/9/2021 19:00:47'!
isEmpty
	
	^items isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'FL 2/9/2021 18:59:29'!
initialize
	
	items := Dictionary new.! !


!Cart methodsFor: 'evaluating' stamp: 'FL 2/9/2021 19:31:24'!
totalItems

	| allItemUnits |
	
	allItemUnits := 0.
	
	items collect: [:anItem | allItemUnits := allItemUnits + anItem].
	
	^allItemUnits.! !
