!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'objectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
setUp

	objectsFactory := PublisherTestObjectsFactory new! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:58'!
test01NewCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test02CanAddABookToACart

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:25:18'!
test03CannotAddABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF456'.

	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.
	! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test04CanAddTwoCopiesOfABook

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test05CannotAddNonPositiveNumberOfCopiesOfABook

	| cart |
	cart := self createCart.

	self assert: cart isEmptyAfter: [ cart add: objectsFactory bookFromTheEditorial quantity: -1 ] raisesErrorWithMessage: Cart invalidNumberOfCopiesErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test06CartRemembersAddedBooks

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	cart add: objectsFactory bookFromTheEditorial quantity: 1.
	
	self assert: (cart includes: objectsFactory bookFromTheEditorial).
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 3! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:26:35'!
test07CannotAddTwoCopiesOfABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF123'.
	
	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog quantity: 2 ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.! !


!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 21:24:13'!
assert: cart isEmptyAfter: blockExpectedToFail raisesErrorWithMessage: errorMessage
	
	self should: blockExpectedToFail raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: errorMessage.
		self assert: cart isEmpty.
	]! !

!CartTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:24'!
createCart

	^ objectsFactory anEmptyCart! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'objectsFactory merchantProcessorBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:04'!
setUp

	objectsFactory := PublisherTestObjectsFactory new.
	merchantProcessorBehaviour := [ :anAmountToDebit :aCreditCard |  ]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:40'!
test01CannotCheckoutAnEmptyCart

	| cart salesBook cashier |
	cart := objectsFactory anEmptyCart.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutAnEmptyCart.
			self assert: salesBook isEmpty
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:05'!
test02TotalIsCalculatedCorrectlyAfterCheckout

	| cart ticket cashier |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: objectsFactory bookFromTheEditorialPrice equals: ticket value.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:50'!
test03CannotCheckoutIfCardIsExpired

	| cart cashier merchantProcessorWasContacted salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	merchantProcessorWasContacted := false.
	self merchantProcessorBehaviour: [ :amountToDebit :aCreditCard |  merchantProcessorWasContacted := true ].
	
	self should: [ self cashier: cashier checkout: cart debitingOn: objectsFactory anExpiredCreditCard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutUsingAnExpiredCard.
			self deny: merchantProcessorWasContacted.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 23:04:34'!
test04CheckoutDebitsCreditCardUsingMerchantProcessor

	| cart ticket cashier debitedAmountFromCreditCard debitedCreditCard creditCard |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	creditCard := objectsFactory aValidCreditCard.
		
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | 
		debitedAmountFromCreditCard := anAmountToDebit.
		debitedCreditCard := aCreditCard.
	].
	
	ticket := self cashier: cashier checkout: cart debitingOn: creditCard.
	
	self assert: debitedAmountFromCreditCard equals: ticket value.
	self assert: debitedCreditCard equals: creditCard.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:58'!
test05CheckoutFailsIfMerchantProcessorCantProcessPayment

	| cart cashier salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | Error new signal ].
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: Cashier couldNotProcessPaymentErrorMessage.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:52:03'!
test06CheckingOutACartRegistersASale

	| cart cashier ticket salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.	
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: ticket.! !


!CashierTest methodsFor: 'merchat processor protocol' stamp: 'LL 1/24/2021 18:26:00'!
debit: anAmountToDebit from: aCreditCard

	^merchantProcessorBehaviour value: anAmountToDebit value: aCreditCard! !


!CashierTest methodsFor: 'change mp behaviour' stamp: 'LL 1/24/2021 18:26:00'!
merchantProcessorBehaviour: newBehaviour

	merchantProcessorBehaviour := newBehaviour! !


!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:05'!
cashier: cashier checkout: cart

	^self cashier: cashier checkout: cart debitingOn: objectsFactory aValidCreditCard! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:04'!
cashier: cashier checkout: cart debitingOn: aCreditCard

	^cashier checkout: cart payingWith: aCreditCard through: self merchantProcessorForTest on: objectsFactory now.! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 18:29:57'!
merchantProcessorForTest
	
	^self! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LL 1/24/2021 18:15:23'!
test01CreditCardOwnerNameCannotBeBlank

	^self should: [ CreditCard of: '' number: 11111111 expiringOn: (FixedGregorianDate today) monthOfYear ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: CreditCard nameCannotBeBlankErrorMessage.
		]! !


!classDefinition: #PurchasingAdvisorTest category: 'TusLibros'!
TestCase subclass: #PurchasingAdvisorTest
	instanceVariableNames: 'objectsFactory merchantProcessorBehaviour logonSystem logonBehaviour merchantProcessor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchasingAdvisorTest methodsFor: 'private' stamp: 'FL 2/25/2021 10:06:09'!
invalidAutenticationBehaviour

	logonBehaviour := [:user :password | false]! !


!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:04:51'!
setUp

	objectsFactory := PublisherTestObjectsFactory new.
	logonSystem := self.
	logonBehaviour := [:user :password | true].
	merchantProcessor := self.
	clock := objectsFactory aClock.
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test01CanNotCreateCartWithInvalidCredentials

	| purchasingAdvisor cartId | 
	cartId := #invalidCartId.
	self invalidAutenticationBehaviour.
	
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	self should: [cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'testPassword']
		raise: Error 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: PurchasingAdvisor invalidCredentialErrorMessage.
			self assert: #invalidCartId equals: cartId.
		].
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test02CanCreateCartWithValidCredentials

	| purchasingAdvisor cartId |
	cartId := #invalidCartId. 
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'testUserPassword'.
	
	self assert: (cartId isNotEqualTo: #invalidCartid).
	
	
	
	
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test03CanNotListItemsInCartWithAnInvalidCartId

	| purchasingAdvisor |
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	self should: [purchasingAdvisor listCartWithId: 1]  raise: Error withMessageText: PurchasingAdvisor invalidCartIdErrorMessage.
	
	
	
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test04CanAskForCartProvidingAValidCartId

	| purchasingAdvisor cartId |
	cartId := #invalidCartId. 
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'testPassword'.
	
	
	self assert: (purchasingAdvisor listCartWithId: cartId) isEmpty.! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test05CanListItemsInCartWithAValidCartId

	| purchasingAdvisor cartId |
	cartId := #invalidCartId. 
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'testPassword'.
	purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.
	
	self assert: (purchasingAdvisor listCartWithId: cartId) includes: objectsFactory bookFromTheEditorial.
! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test06CanNotCheckOutWithAnInvalidCartId

	| purchasingAdvisor cartId aCreditCard |
	cartId := 1. 
	aCreditCard := objectsFactory aValidCreditCard.
	
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
		
	self should: [purchasingAdvisor checkOut: cartId payingWith: aCreditCard through: merchantProcessor ] 
	
	raise: Error 
	
	withMessageText: PurchasingAdvisor invalidCartIdErrorMessage.
	
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:13'!
test07CanNotListPurchasesForAnInexistentClientId
	| purchasingAdvisor clientId |
	self invalidAutenticationBehaviour.
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	
	self should: [purchasingAdvisor listPurchasesFor: 'testUser' and: 'testpassword'] raise: Error withMessageText: PurchasingAdvisor invalidCredentialErrorMessage.
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test08CanAskForPurchasesOfAExistentClientId
	| purchasingAdvisor |
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	
	self assert: (purchasingAdvisor listPurchasesFor: 'testUserId' and: 'testPassword') isEmpty.
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test09CanListPurchasesWithValidCredentials

	| purchasingAdvisor cartId aCreditCard |
	cartId := #invalidCartId.
	aCreditCard := objectsFactory aValidCreditCard.
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'testPassword'.
	purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.
	purchasingAdvisor checkOut: cartId payingWith: aCreditCard through: merchantProcessor.
	
	self assert: (purchasingAdvisor listPurchasesFor: 'testUserId' and: 'testUserId') includes: objectsFactory bookFromTheEditorial.
! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test10DifferentUsersHasDifferentPurchases

	| purchasingAdvisor client1Id client2Id clientPassword cartId anotherCartId aCreditCard client1Purchases client2Purchases |
	cartId := #invalidCartId. 
	client1Id := '1'.
	client2Id := '2'.
	clientPassword := 'abc123'.
	aCreditCard := objectsFactory aValidCreditCard.
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: client1Id withPassword: clientPassword.
	anotherCartId := purchasingAdvisor createCartFor: client2Id withPassword: clientPassword.
	
	purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.
	purchasingAdvisor checkOut: cartId payingWith: aCreditCard through: merchantProcessor.
	
	purchasingAdvisor add: 20 copiesOf: objectsFactory bookFromTheEditorial toCart: anotherCartId .
	purchasingAdvisor checkOut: anotherCartId payingWith: aCreditCard through: merchantProcessor .
	
	client1Purchases := (purchasingAdvisor listPurchasesFor: client1Id and: clientPassword).
	client2Purchases := (purchasingAdvisor listPurchasesFor: client2Id and: clientPassword).	
	
	self assert: client1Purchases includes: objectsFactory bookFromTheEditorial.
	self assert: 1  equals: (client1Purchases occurrencesOf: objectsFactory bookFromTheEditorial).
	
	self assert: client2Purchases includes: objectsFactory bookFromTheEditorial.
	self assert: 20  equals: (client2Purchases occurrencesOf: objectsFactory bookFromTheEditorial).
	
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:01:12'!
test11IsNotPossibleToAddItemsToACartSold

	| purchasingAdvisor cartId aCreditCard |

	aCreditCard := objectsFactory aValidCreditCard.
	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'userPassword'.
	
	purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.
	purchasingAdvisor checkOut: cartId payingWith: aCreditCard through: merchantProcessor.
	
	self should: [purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.] 
		raise: Error 
		withMessageText: PurchasingAdvisor isNotPossibleToAddItemsToACartSoldErrorMessage .
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:54:20'!
test12CannotAddItemsToAnExpiredCart

	| purchasingAdvisor cartId |

	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'userPassword'.
	
	clock alterate: 30 * minute.
	
	self should: [purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.] 
		raise: Error 
		withMessageText: PurchasingAdvisor isNotPossibleToModifyAnExpiredCartErrorMessage .
	! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:54:46'!
test13AnOperationOverACartUpdateTheExpirationTime

	| purchasingAdvisor cartId |

	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'userPassword'.
	clock alterate: 29 * minute.
	purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.
	clock alterate: 10 * minute.
	purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.
	
	self assert: 2 equals: ((purchasingAdvisor listCartWithId: cartId) occurrencesOf: objectsFactory bookFromTheEditorial).! !

!PurchasingAdvisorTest methodsFor: 'tests' stamp: 'sc 2/25/2021 18:55:28'!
test14AnExpiredCartCannotBeCheckouted

	| purchasingAdvisor cartId |

	purchasingAdvisor := PurchasingAdvisor validateClientsWith: logonSystem toAdviseOverProductsOn: objectsFactory aCatalog withClock: clock.
	
	cartId := purchasingAdvisor createCartFor: 'testUserId' withPassword: 'userPassword'.
	purchasingAdvisor add: 1 copiesOf: objectsFactory bookFromTheEditorial toCart: cartId.
	
	clock alterate: 30 * minute.
	
	self should: [purchasingAdvisor checkOut: cartId payingWith: objectsFactory aValidCreditCard through: merchantProcessor.] 
		raise: Error 
		withExceptionDo: [:anException |
			self assert: PurchasingAdvisor isNotPossibleToModifyAnExpiredCartErrorMessage equals: anException messageText.
			self assert: (purchasingAdvisor listPurchasesFor: 'testUserId' and: 'userPassword') isEmpty].
	! !


!PurchasingAdvisorTest methodsFor: 'simulated messages' stamp: 'FL 2/25/2021 11:07:11'!
debit: anAmountToDebit from: aCreditCard! !

!PurchasingAdvisorTest methodsFor: 'simulated messages' stamp: 'FL 2/25/2021 10:00:06'!
user: anUserId password: aPassword

	^logonBehaviour value: anUserId value: aPassword.
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LL 1/25/2021 18:50:24'!
initializeWithCatalog: aBookCatalog
	
	bookCatalog := aBookCatalog.
	books := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:24:07'!
add: aBook
	
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:23:42'!
add: aBook quantity: numberOfBooksToAdd

	self assertIsInCatalog: aBook.
	self assertValidNumberOfCopies: numberOfBooksToAdd.
	
	books add: aBook withOccurrences: numberOfBooksToAdd.! !


!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/24/2021 17:42:15'!
total
	
	^books sum: [ :aBook | bookCatalog at: aBook ].! !


!Cart methodsFor: 'testing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/24/2021 15:49:03'!
assertIsInCatalog: aBook

	^ (bookCatalog includesKey: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LL 1/25/2021 18:29:34'!
acceptingItemsOf: aBookCatalog
 
	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LL 1/20/2021 21:45:09'!
bookNotInCatalogErrorMessage

	^'Cannot add a book that is not from the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'LL 1/21/2021 21:27:21'!
invalidNumberOfCopiesErrorMessage

	^'Cannot add zero books'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'LL 1/25/2021 18:49:19'!
initializeWithSalesBook: aSalesBook

	salesBook := aSalesBook! !


!Cashier methodsFor: 'checkout' stamp: 'LL 1/25/2021 23:10:38'!
checkout: aCart payingWith: aCreditCard through: aMerchantProcessor on: aCheckoutDateTime  

	| ticket |
	self assertCanCheckout: aCart using: aCreditCard on: aCheckoutDateTime.
	
	ticket := aCart total.
	
	self debit: ticket value from: aCreditCard using: aMerchantProcessor.
	
	self registerSale: ticket.
	
	^ticket! !


!Cashier methodsFor: 'assertions' stamp: 'LL 1/25/2021 23:10:22'!
assertCanCheckout: aCart using: aCreditCard on: aDateTime 

	self assertContainsBooks: aCart.
	self assertIsNotExpired: aCreditCard on: aDateTime! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/24/2021 17:45:42'!
assertContainsBooks: aCart

	^ aCart isEmpty ifTrue: [	 self error: Cashier cannotCheckoutAnEmptyCart ]! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/25/2021 23:11:12'!
assertIsNotExpired: aCreditCard on: aDateTime 

	^ (aCreditCard isExpiredOn: aDateTime) ifTrue: [ self error: Cashier cannotCheckoutUsingAnExpiredCard ]! !


!Cashier methodsFor: 'private' stamp: 'LL 1/24/2021 18:23:28'!
debit: anAmount from: aCreditCard using: aMerchantProcessor

	^ [ aMerchantProcessor debit: anAmount from: aCreditCard ]
		on: Error - MessageNotUnderstood 
		do: [ :exceptionRaised |
			self error: self class couldNotProcessPaymentErrorMessage.
		]! !

!Cashier methodsFor: 'private' stamp: 'LL 1/25/2021 19:50:24'!
registerSale: ticket

	^ salesBook add: ticket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/21/2021 21:50:07'!
cannotCheckoutAnEmptyCart
	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 16:44:06'!
cannotCheckoutUsingAnExpiredCard

	^'Cannot checkout using an expired card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:13:36'!
couldNotProcessPaymentErrorMessage

	^'Cart was rejected'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/25/2021 18:48:59'!
registeringSalesOn: aSalesBook

	^ self new initializeWithSalesBook: aSalesBook.! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'gregorianDateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'sc 2/25/2021 18:09:11'!
alterate: aTime
	gregorianDateTime := gregorianDateTime next: aTime! !

!Clock methodsFor: 'as yet unclassified' stamp: 'sc 2/25/2021 18:08:07'!
initializeSync: aDateTime
	gregorianDateTime := aDateTime.! !

!Clock methodsFor: 'as yet unclassified' stamp: 'sc 2/25/2021 18:08:44'!
now
	^gregorianDateTime copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'as yet unclassified' stamp: 'sc 2/25/2021 18:07:43'!
sync: aDateTime
	^Clock new initializeSync: aDateTime! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber owner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'LL 2/16/2021 18:05:42'!
initializeOf: aPerson number: aCreditCardNumber expiringOn: aMonthOfYear 

	owner := aPerson.
	creditCardNumber := aCreditCardNumber.
	expirationDate := aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'LL 2/16/2021 18:05:42'!
isExpiredOn: aDateTime

	^ aDateTime > (expirationDate lastDate)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LL 1/24/2021 18:15:40'!
of: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear

	nameOfTheOwner isEmpty ifTrue: [ self error: self nameCannotBeBlankErrorMessage ].
	
	^self new initializeOf: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear ! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:01:14'!
nameCannotBeBlankErrorMessage

	^'Name cannot be blank'! !


!classDefinition: #PublisherTestObjectsFactory category: 'TusLibros'!
Object subclass: #PublisherTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:41:18'!
aCashier

	| salesBook |
	salesBook := OrderedCollection new.
	^ Cashier registeringSalesOn: salesBook.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 21:07:25'!
aCatalog

	^ Dictionary newFromPairs: {self bookFromTheEditorial. self bookFromTheEditorialPrice}! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'sc 2/25/2021 18:06:39'!
aClock

	^Clock sync: GregorianDateTime now.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 20:08:24'!
aPurchasingAdvisor
	
	| purchasingAdvisor |
	purchasingAdvisor := PurchasingAdvisor new.
	! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:45:08'!
aValidCreditCard

	| nextMonth |
	nextMonth := (FixedGregorianDate today next: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: nextMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 21:07:25'!
anEmptyCart

	| aCatalog |
	aCatalog := self aCatalog.
	^Cart acceptingItemsOf: aCatalog.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:51:21'!
anEmptySalesBook

	^OrderedCollection new.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:43:38'!
anExpiredCreditCard
	
	| lastMonth |
	lastMonth := (FixedGregorianDate today previous: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: lastMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 15:59:26'!
bookFromTheEditorial

	^ 'ABC123'! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 17:11:28'!
bookFromTheEditorialPrice

	^ 1000 * peso! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:46:27'!
cartWithABook

	| cart |
	cart := self anEmptyCart.
	cart add: self bookFromTheEditorial.
	^cart! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:48:31'!
now 

	^GregorianDateTime now! !


!classDefinition: #PurchasingAdvisor category: 'TusLibros'!
Object subclass: #PurchasingAdvisor
	instanceVariableNames: 'logginSystem catalog allDeliveredCarts purchasesMadeByClientId clientIdFromCartId inProcessCarts clock salesBook timeFromCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchasingAdvisor methodsFor: 'assertions' stamp: 'sc 2/25/2021 18:42:11'!
asserCartIsNotExpired: aCartId
	
	(((timeFromCartId at: aCartId) <= clock now) and: [ clock now < ((timeFromCartId at: aCartId) next: 30 * minute) ] ) 
	
		ifFalse: [self error: self class isNotPossibleToModifyAnExpiredCartErrorMessage].! !

!PurchasingAdvisor methodsFor: 'assertions' stamp: 'FL 2/25/2021 14:43:57'!
assertCartIsInProcess: cartIdToFind 
	
	inProcessCarts detect: [:aCartId | cartIdToFind = aCartId] ifNone: [self error: self class isNotPossibleToAddItemsToACartSoldErrorMessage]! !

!PurchasingAdvisor methodsFor: 'assertions' stamp: 'FL 2/25/2021 12:22:41'!
assertIsValidCartId: aCartId

	(allDeliveredCarts size < aCartId or: [0 > aCartId ]) ifTrue: [self error: self class invalidCartIdErrorMessage]
! !

!PurchasingAdvisor methodsFor: 'assertions' stamp: 'FL 2/25/2021 09:07:41'!
assertIsValidCredentialsFor: aClientId and: aClientPassword

	(logginSystem user: aClientId password: aClientPassword ) ifFalse: [self error: self class invalidCredentialErrorMessage]
! !


!PurchasingAdvisor methodsFor: 'initialization' stamp: 'sc 2/25/2021 18:17:25'!
initializeValidateClientsWith: userLogginSystem toAdviseOverProductsOn: aCatalog withClock: aClock
	
	logginSystem := userLogginSystem.
	catalog := aCatalog.
	allDeliveredCarts := OrderedCollection new.
	inProcessCarts := Set new.
	purchasesMadeByClientId := Dictionary new.
	clientIdFromCartId := Dictionary new.
	clock := aClock.
	salesBook := OrderedCollection new.
	timeFromCartId := Dictionary new.! !


!PurchasingAdvisor methodsFor: 'system primitives' stamp: 'sc 2/25/2021 18:46:11'!
add: numberOfBooksToAdd copiesOf: aBook toCart: aCartId

	self assertIsValidCartId: aCartId.
	
	self assertCartIsInProcess: aCartId.
	
	self asserCartIsNotExpired: aCartId.
	
	timeFromCartId at: aCartId put: clock now.
	(allDeliveredCarts at: aCartId) add: aBook quantity: numberOfBooksToAdd.
	
	
! !

!PurchasingAdvisor methodsFor: 'system primitives' stamp: 'sc 2/25/2021 18:51:42'!
checkOut: aCartId payingWith: aCreditCard through: aMerchantProcessor 
	
	| clientId |
	self assertIsValidCartId: aCartId.	
	self asserCartIsNotExpired: aCartId.
	
	timeFromCartId at: aCartId put: clock now.
	
	(Cashier registeringSalesOn: salesBook) 
		checkout: (allDeliveredCarts at: aCartId ) 
		payingWith: aCreditCard 
		through: aMerchantProcessor 
		on: GregorianDateTime now.
	
	inProcessCarts remove: aCartId.
	
	clientId := clientIdFromCartId at: aCartId.
	purchasesMadeByClientId at: clientId 
	ifPresent: [:clientPurchases | clientPurchases addAll: (self listCartWithId: aCartId )]
	ifAbsent: [purchasesMadeByClientId at: clientId put: (self listCartWithId: aCartId)].
	! !

!PurchasingAdvisor methodsFor: 'system primitives' stamp: 'sc 2/25/2021 18:20:48'!
createCartFor: aClientId withPassword: aClientPassword
	
	| cart cartId |
	
	self assertIsValidCredentialsFor: aClientId and: aClientPassword.
	
	cart := Cart acceptingItemsOf: catalog.
	allDeliveredCarts add: cart.
	cartId := allDeliveredCarts size.	
	inProcessCarts add: cartId.
	clientIdFromCartId at: cartId put: aClientId.
	timeFromCartId at: cartId put: clock now.
	
	^cartId.! !

!PurchasingAdvisor methodsFor: 'system primitives' stamp: 'sc 2/25/2021 18:53:01'!
listCartWithId: aCartId

	| cart itemsInCart |	
	
	self assertIsValidCartId: aCartId.
	
	timeFromCartId at: aCartId put: clock now.
	itemsInCart := Bag new.
	cart := allDeliveredCarts at: aCartId.
	catalog keys select: [:anItem | cart includes: anItem] thenDo: [:anItem | itemsInCart add: anItem withOccurrences: (cart quantityOf: anItem)].
	^itemsInCart
	
	! !

!PurchasingAdvisor methodsFor: 'system primitives' stamp: 'FL 2/25/2021 13:52:44'!
listPurchasesFor: clientId and: clientPassword
	
	self assertIsValidCredentialsFor: clientId and: clientPassword.
	
	^purchasesMadeByClientId at: clientId ifAbsent:[^Bag new].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchasingAdvisor class' category: 'TusLibros'!
PurchasingAdvisor class
	instanceVariableNames: ''!

!PurchasingAdvisor class methodsFor: 'instance creation' stamp: 'sc 2/25/2021 18:01:28'!
validateClientsWith: userLogonSystem toAdviseOverProductsOn: catalog withClock: clock   
	
	^self new initializeValidateClientsWith: userLogonSystem toAdviseOverProductsOn: catalog withClock: clock.! !


!PurchasingAdvisor class methodsFor: 'error messages' stamp: 'FL 2/24/2021 22:24:27'!
invalidCartIdErrorMessage

	^'The provided cart id is invalid'! !

!PurchasingAdvisor class methodsFor: 'error messages' stamp: 'FL 2/24/2021 21:03:03'!
invalidCredentialErrorMessage
	
	^'Invalid credentials. ClientId or password does not match'.! !

!PurchasingAdvisor class methodsFor: 'error messages' stamp: 'FL 2/25/2021 14:14:31'!
isNotPossibleToAddItemsToACartSoldErrorMessage
	
	^'Is not possible to add items to a cart sold'.! !

!PurchasingAdvisor class methodsFor: 'error messages' stamp: 'sc 2/25/2021 18:10:31'!
isNotPossibleToModifyAnExpiredCartErrorMessage
	
	^'Is not possible to modify an cart expired'.! !
