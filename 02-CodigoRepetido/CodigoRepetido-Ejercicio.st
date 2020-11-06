!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'SC 11/4/2020 22:56:23'!
addAndSuspendPaulToACustomerBook
	|customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	^customerBook
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/5/2020 18:14:33'!
doACustomerBookFailAction: anAction withTypeOfError: errorType andCheckStatus: blockForCheckStatus

	| customerBook |
			
	customerBook := CustomerBook new.

	[ anAction value: customerBook]
		on: errorType 
		do: [ :anError | blockForCheckStatus value: anError value: customerBook ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/5/2020 18:48:57'!
makeAnInvalidSuspendAction: anAction withACustomer: aCustomer

	|customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	
	[	anAction value: customerBook.
		
		self fail
	]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: aCustomer) ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/4/2020 20:57:46'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook  |
	
	customerBook := CustomerBook new.
	
	self testIfAnAction: [		customerBook addCustomerNamed: 'John Lennon'	]
	
		takesLessThanThisMilliseconds: 50
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/4/2020 20:57:35'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self testIfAnAction: [		customerBook removeCustomerNamed: 'Paul McCartney'	]
		
		takesLessThanThisMilliseconds: 100! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/5/2020 22:08:34'!
test03CanNotAddACustomerWithEmptyName 


	self doACustomerBookFailAction: [
		:customerBook |
		
		customerBook addCustomerNamed: ''.
		
		] withTypeOfError: Error andCheckStatus: [

			:anError :customerBook | 
		
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		
			self assert: customerBook isEmpty
	].! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/5/2020 18:21:03'!
test04CanNotRemoveAnInvalidCustomer
	
	self doACustomerBookFailAction: [:customerBook |
		
		customerBook addCustomerNamed: 'John Lennon'.
		
		customerBook removeCustomerNamed: 'Paul McCartney'.
		
		self fail 
	] withTypeOfError: NotFound andCheckStatus: [
	
		:anError :customerBook | 
		
		self assert: customerBook numberOfCustomers = 1.
		
		self assert: (customerBook includesCustomerNamed: 'John Lennon')
	] 	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SC 11/4/2020 23:00:11'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	
	customerBook := self addAndSuspendPaulToACustomerBook.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/4/2020 23:09:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := 	customerBook := self addAndSuspendPaulToACustomerBook.

	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/5/2020 20:16:13'!
test07CanNotSuspendAnInvalidCustomer
	
	
	self whenJohnLennonIsTheOnlyCustomerDoAnInvalidAction:  [
		
		:customerBook | 
		
		customerBook suspendCustomerNamed: 'Ringo Starr'.
				
	]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/5/2020 20:16:05'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	|johnLennon |
	
	johnLennon := 'John Lennon'.
	
	self whenJohnLennonIsTheOnlyCustomerDoAnInvalidAction:  [
		
		:customerBook |
		
		2 timesRepeat: [customerBook suspendCustomerNamed: johnLennon].
				
	 ] 	
	
	
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/4/2020 20:56:58'!
testIfAnAction: anAction takesLessThanThisMilliseconds: maximumMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
		
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anAction value	.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (maximumMilliseconds * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/5/2020 20:15:40'!
whenJohnLennonIsTheOnlyCustomerDoAnInvalidAction: anAction
	|customerBook johnLennon|
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[	anAction value: customerBook.
		
		self fail
	]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
