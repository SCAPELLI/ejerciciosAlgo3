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

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 20:15:39'!
obtainACustomerBookWithPaulBeingSuspended

	|customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	^customerBook
	

	
! !

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

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 20:30:21'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
		
	"Consideramos que no hay codigo repetido para remover, respecto a otros metodos, ni el mismo."! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 20:30:55'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]

	"Consideramos nuevamente que no hay codigo repetido para remover, respecto a otros metodos, ni el mismo."! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 20:16:29'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := self obtainACustomerBookWithPaulBeingSuspended.
	
	self thereIsNotActiveCustomerIn: customerBook 
	
	andQuantityOfSuspendedCustomersIs: 1 andTotalCustomersIs: 1 andPaulisInclude: true.

	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 20:16:34'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self obtainACustomerBookWithPaulBeingSuspended.

	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self thereIsNotActiveCustomerIn: customerBook 
	
	andQuantityOfSuspendedCustomersIs: 0 andTotalCustomersIs: 0 andPaulisInclude: false.


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 19:48:36'!
test07CanNotSuspendAnInvalidCustomer
	
	
	self whenJohnLennonIsTheOnlyCustomerTheNextActionIsInvalid:  [
		
		:customerBook | 
		
		customerBook suspendCustomerNamed: 'Ringo Starr'.
				
	]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 19:48:36'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	|johnLennon |
	
	johnLennon := 'John Lennon'.
	
	self whenJohnLennonIsTheOnlyCustomerTheNextActionIsInvalid:  [
		
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

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 19:42:46'!
thereIsNotActiveCustomerIn: customerBook andQuantityOfSuspendedCustomersIs: suspendedCustomers 
andTotalCustomersIs: totalCustomers andPaulisInclude: aBoolean
	

	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.
	self assert: aBoolean = (customerBook includesCustomerNamed: 'Paul McCartney').! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/7/2020 19:48:36'!
whenJohnLennonIsTheOnlyCustomerTheNextActionIsInvalid: anAction
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


!CustomerBook methodsFor: 'customer management' stamp: 'FL 11/7/2020 20:24:17'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FL 11/7/2020 20:01:25'!
remove: aName from: aNamesCollection

1 to: aNamesCollection size do: 
	[ :index |
		aName = (aNamesCollection at: index)
			ifTrue: [
				aNamesCollection removeAt: index.
				^ aName 
			] 
	].

^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'FL 11/7/2020 20:05:13'!
removeCustomerNamed: aName 
 
	[
		self remove: aName from: active.
		
	] on: NotFound do: 	[
	
		self remove: aName from: suspended.
		
	] on: NotFound do: [^NotFound signal.]
	
	
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

!CustomerBook methodsFor: 'accessing' stamp: 'FL 11/7/2020 20:26:58'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

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
