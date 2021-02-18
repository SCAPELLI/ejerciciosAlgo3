!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:58'!
test01NewCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:38'!
test02CanAddABookToACart

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:25:18'!
test03CannotAddABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF456'.

	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.
	! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:12:27'!
test04CanAddTwoCopiesOfABook

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial quantity: 2.
	
	self assert: (cart quantityOf: self bookFromTheEditorial) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:27:25'!
test05CannotAddNonPositiveNumberOfCopiesOfABook

	| cart |
	cart := self createCart.

	self assert: cart isEmptyAfter: [ cart add: self bookFromTheEditorial quantity: -1 ] raisesErrorWithMessage: Cart invalidNumberOfCopiesErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:39:03'!
test06CartRemembersAddedBooks

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial quantity: 2.
	cart add: self bookFromTheEditorial quantity: 1.
	
	self assert: (cart includes: self bookFromTheEditorial).
	self assert: (cart quantityOf: self bookFromTheEditorial) equals: 3! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:26:35'!
test07CannotAddTwoCopiesOfABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF123'.
	
	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog quantity: 2 ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'FL 2/18/2021 14:39:31'!
test08CannotRegisterAnEmptyCart

	| cart|
	
	cart := self createCart.
	
	self should: [Cashier register: cart withPriceList: self priceList] raise: Error withMessageText: Cashier cannotRegisterAnEmptyCartErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'FL 2/18/2021 14:55:27'!
test09ACartWithOneBookCanBeRegisteredToGetPrice

	| cashier cart |
	
	cart := self createCart.
	
	cart add: self bookFromTheEditorial.
	
	cashier := Cashier register: cart withPriceList: self priceList.
	
	self assert: 20 * peso equals: cashier totalToPay.! !

!CartTest methodsFor: 'tests' stamp: 'FL 2/18/2021 14:55:09'!
test10ACartWithManyBooksCanBeRegisteredToGetPrice

	| cashier cart |
	
	cart := self createCart.
	
	cart add: self bookFromTheEditorial quantity: 2.
	
	cashier := Cashier register: cart withPriceList: self priceList.
	
	self assert: 40 * peso equals: cashier totalToPay.! !

!CartTest methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:33'!
test11ACashierCanTakePaymentFromTheCreditCard

	| cashier cart aValidDate |
	
	cart := self createCart.
	cart add: self bookFromTheEditorial.
	cashier := Cashier register: cart withPriceList: self priceList.
	
	aValidDate := Date today next.
	
	cashier charge: cashier totalToPay to: 'Juan Perez' fromCreditCard: '1234567890123456' withExpirationDate: aValidDate.
	
	self assert: (cashier lastChargeResultWas: MerchantProccesor successfulPaymentResult).
	! !

!CartTest methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:00'!
test12ACashierCantTakePaymentFromExpiredCreditCard

	| cashier cart anInvalidDate|
	
	cart := self createCart.
	cart add: self bookFromTheEditorial.
	cashier := Cashier register: cart withPriceList: self priceList.
	
	anInvalidDate := Date today previous.
	cashier charge: cashier totalToPay to: 'Juan Perez' fromCreditCard: '123456789123456' withExpirationDate: anInvalidDate.
	
	self assert: (cashier lastChargeResultWas: Cashier expiredCreditCardResult).
	! !

!CartTest methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:11'!
test13ACashierCantTakePaymentFromACardWithInvalidDigits

	| cashier cart anInvalidCreditCard aValidDate|
	
	cart := self createCart.
	cart add: self bookFromTheEditorial.
	cashier := Cashier register: cart withPriceList: self priceList.
	
	aValidDate := Date today next.
	anInvalidCreditCard := '222'.
	
	cashier charge: cashier totalToPay to: 'Juan Perez' fromCreditCard: anInvalidCreditCard withExpirationDate: aValidDate.
	
	self assert: (cashier lastChargeResultWas: Cashier invalidCreditCardResult).
	! !

!CartTest methodsFor: 'tests' stamp: 'SC 2/18/2021 17:52:40'!
test14CantMakePaymentWithInsufficientFunds

	| cashier cart aValidCreditCard aValidDate|
	
	cart := self createCart.
	cart add: self bookFromTheEditorial quantity: 20.
	cashier := Cashier register: cart withPriceList: self priceList.
	
	aValidDate := Date today next.
	aValidCreditCard := '1234567890123456'.
	
	cashier charge: cashier totalToPay to: 'Juan Perez' fromCreditCard: aValidCreditCard withExpirationDate: aValidDate.
	
	self assert: (cashier lastChargeResultWas: MerchantProccesor insufficientFundsResult).
	! !


!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 21:24:13'!
assert: cart isEmptyAfter: blockExpectedToFail raisesErrorWithMessage: errorMessage
	
	self should: blockExpectedToFail raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: errorMessage.
		self assert: cart isEmpty.
	]! !

!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 20:08:01'!
bookFromTheEditorial

	^ 'ABC123'! !

!CartTest methodsFor: 'private' stamp: 'FL 2/18/2021 14:48:58'!
createCart

	| aCatalog |
	aCatalog := Set with: self bookFromTheEditorial.
	^Cart withCatalog: aCatalog.! !

!CartTest methodsFor: 'private' stamp: 'FL 2/18/2021 14:49:16'!
priceList

	^Dictionary newFromPairs: {
		'ABC123' . 20* peso .
		'DEF321' . 25* peso .
		'ABC213' . 23* peso
	}
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LL 1/21/2021 20:26:42'!
initializeWithCatalog: aBookCatalog
	
	bookCatalog := aBookCatalog.
	books := Bag new! !


!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:24:07'!
add: aBook
	
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:23:42'!
add: aBook quantity: numberOfBooksToAdd

	self assertIsInCatalog: aBook.
	self assertValidNumberOfCopies: numberOfBooksToAdd.
	
	books add: aBook withOccurrences: numberOfBooksToAdd.! !


!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 22:11:43'!
contents
	^books copy! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !


!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 20:19:45'!
assertIsInCatalog: aBook

	^ (bookCatalog includes: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LL 1/20/2021 21:37:38'!
withCatalog: aBookCatalog
 
	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LL 1/20/2021 21:45:09'!
bookNotInCatalogErrorMessage

	^'Cannot add a book that is not from the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'LL 1/21/2021 21:27:21'!
invalidNumberOfCopiesErrorMessage

	^'Cannot add zero books'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart priceList lastChargeResult'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'FL 2/18/2021 13:55:57'!
inicializeWith: aCart usingPricesOf: aPriceList 
	
	cart := aCart.
	priceList := aPriceList.! !


!Cashier methodsFor: 'accessing' stamp: 'SC 2/18/2021 17:24:22'!
charge: import to: client fromCreditCard: creditCardNumber withExpirationDate: expirationDate

	| chargeSystem |
	
	(expirationDate < Date today) ifTrue: [lastChargeResult := self class expiredCreditCardResult. ^self].
	
	(creditCardNumber asString size = 16) ifFalse: [lastChargeResult := self class invalidCreditCardResult. ^self].
		
	chargeSystem := MerchantProccesor new.
	lastChargeResult := chargeSystem charge: import to: client fromCreditCard: creditCardNumber withExpirationDate: expirationDate.! !

!Cashier methodsFor: 'accessing' stamp: 'sc 2/18/2021 16:00:56'!
lastChargeResultWas: aChargeResult

	^lastChargeResult = aChargeResult. ! !

!Cashier methodsFor: 'accessing' stamp: 'FL 2/18/2021 15:16:16'!
registerANewCart: aCart

	self class assertCartIsNotEmpty: aCart.
	
	cart := aCart.! !

!Cashier methodsFor: 'accessing' stamp: 'FL 2/18/2021 14:44:20'!
totalToPay
	
	| total |
	
	total := 0.
	
	cart contents do: [
		:aBook | 
		total := total + 
			(priceList at: aBook			ifAbsent: [self class invalidBookInCartErrorMessage])
	] .
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FL 2/18/2021 11:51:07'!
cannotRegisterAnEmptyCartErrorMessage
	
	^'I Cant registrate an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'FL 2/18/2021 14:38:01'!
invalidBookInCartErrorMessage

	^'An item is not part of our products'! !


!Cashier class methodsFor: 'instance creation' stamp: 'FL 2/18/2021 15:15:06'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self cannotRegisterAnEmptyCartErrorMessage ]! !


!Cashier class methodsFor: 'payment messages' stamp: 'sc 2/18/2021 16:20:00'!
expiredCreditCardResult
	^'last payment was unsuccessful. The credit card is expired'! !

!Cashier class methodsFor: 'payment messages' stamp: 'SC 2/18/2021 17:21:21'!
insufficientFundsResult
	^'last payment was unsuccessful. The funds where not enought'! !

!Cashier class methodsFor: 'payment messages' stamp: 'sc 2/18/2021 16:40:07'!
invalidCreditCardResult
	^'last payment was unsuccessful. The credit card is invalid'! !

!Cashier class methodsFor: 'payment messages' stamp: 'FL 2/18/2021 15:15:06'!
register: aCart withPriceList: aPriceList

	self assertCartIsNotEmpty: aCart.
	
	^self new inicializeWith: aCart usingPricesOf: aPriceList.! !


!classDefinition: #MerchantProccesor category: 'TusLibros'!
Object subclass: #MerchantProccesor
	instanceVariableNames: 'creditCardFounds'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProccesor methodsFor: 'as yet unclassified' stamp: 'SC 2/18/2021 17:48:00'!
charge: import to: client fromCreditCard: creditCardNumber withExpirationDate: expirationDate

	(import > (creditCardFounds at: creditCardNumber)) ifTrue: [^self class insufficientFundsResult ].

	^self class successfulPaymentResult! !

!MerchantProccesor methodsFor: 'as yet unclassified' stamp: 'SC 2/18/2021 17:36:42'!
initialize
	creditCardFounds := Dictionary newFromPairs: {'1234567890123456'. 40*peso}
	"creditCardNames := Dictionary newFromPairs: {'1234567890123456'. }
	creditCardFounds := Dictionary newFromPairs: {'1234567890123456'. Date today next}"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProccesor class' category: 'TusLibros'!
MerchantProccesor class
	instanceVariableNames: ''!

!MerchantProccesor class methodsFor: 'payment message' stamp: 'SC 2/18/2021 17:43:57'!
insufficientFundsResult
	^'last payment was unsuccessful. The funds where not enought'! !

!MerchantProccesor class methodsFor: 'payment message' stamp: 'SC 2/18/2021 17:49:03'!
successfulPaymentResult
	^'last payment was successful'! !
