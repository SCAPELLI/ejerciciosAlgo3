!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'FL 12/12/2020 13:09:56'!
test01AnAccoutWithNoTransactionHasNoMovementsSummary

	| report account |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary for: account.
	
	self	assert: 'Balance = 0 pesos'		equals: report printReport.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FL 12/12/2020 13:11:51'!
test02AnAccountTransactionShouldChangeSummary

	| account report |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 20 * peso).
	report _ AccountSummary for: account.
	
	self deny: ('Balance = 0 pesos'		= report printReport).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FL 12/12/2020 13:12:32'!
test03test03ValuesOfRecordedTransactionsAreDistinguished

	| account report |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 80 * peso).
	report _ AccountSummary for: account.
	
	self	assert: 'Depósito por 80 pesos Balance = 80 pesos'		equals: report printReport.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FL 12/12/2020 13:12:57'!
test04MultipleTransactionsCanBeRegister

	| account report |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 20 * peso).
	account register: (Deposit for: 80 * peso).
	report _ AccountSummary for: account.
	
	self	assert: 'Depósito por 20 pesos Depósito por 80 pesos Balance = 100 pesos'		equals: report printReport.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FL 12/12/2020 13:13:15'!
test05WithdrawsReduceBalance

	| account report |
	
	account _ ReceptiveAccount new.
	
	account register: (Deposit for: 20 * peso).
	account register: (Withdraw for: 20 * peso).
	report _ AccountSummary for: account.
		
	self	assert: 'Depósito por 20 pesos Extracción por 20 pesos Balance = 0 pesos'		equals: report printReport.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FL 12/12/2020 13:06:52'!
test06

	| originAccount destinationAccount originReport destinationReport |
	
	originAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	originReport _ AccountSummary for: originAccount .	
	destinationReport _ AccountSummary for: destinationAccount.

	originAccount register: (Deposit for: 20 * peso).
	Transference from: originAccount to: destinationAccount for: 10 * peso.
	
	self	assert: 'Depósito por 20 pesos Salida por transferencia de 10 pesos Balance = 10 pesos'		equals: originReport printReport.
	self	assert: 'Entrada por transferencia de 10 pesos Balance = 10 pesos'		equals: destinationReport printReport.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'FL 12/12/2020 13:13:40'!
test07AReportCanBeBuildFromPortfolioTransactions

	| account  portfolio report  |
	
	account _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	report _ AccountSummary for: portfolio.

	account register: (Deposit for: 20 * peso).
	
	self	assert: 'Depósito por 20 pesos Balance = 20 pesos'		equals: report printReport.! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:32'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:38'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio hasAccount: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:45'!
test03PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:51'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:57'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:03'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/8/2020 16:20:20'!
test07PortfolioBalanceIsZeroWhenAllComposedAccountHasBalanceZero

	|   portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/8/2020 16:34:08'!
test08PortfolioHasBalanceAsSumOfEachComposedAccount

	|   portfolio anAccount otherAccount|
	
	anAccount := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: anAccount with: otherAccount.
	
	anAccount register: (Deposit for: 50 * peso).
	otherAccount register: (Deposit for: 100 * peso).
	
	self assert: portfolio balance equals: 150 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'SC 12/9/2020 20:27:42'!
test09ThePorfolioHasRegisteredAdepositRegisteredInAnAccountThatComposesIt

	|   portfolio anAccount deposit|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio with: anAccount.
	deposit := Deposit for: 50 * peso.
	anAccount register: deposit.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'SC 12/9/2020 20:19:27'!
test10AnyOfTheComposedAccountOfPortfolioHasRegisteredASpecificTransaction

	|   portfolio anAccount deposit|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio with: anAccount.
	deposit := Deposit for: 50 * peso.

	self deny: (portfolio hasRegistered: deposit).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:33'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:48'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:54'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:01'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'emitter receiver transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'tests' stamp: 'SC 12/9/2020 20:53:04'!
test01CanNotTransferWithZeroAsAmount

	emitter := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
		
	self should:  [ Transference from: emitter to: receiver for: 0 * peso.] 
	
	raise: Error 
	
	withMessageText: Transference invalidTransferenceAmountErrorMessage.
! !

!TransferenceTest methodsFor: 'tests' stamp: 'SC 12/9/2020 20:53:04'!
test02CanNotTransferAUncoveredAmount

	emitter := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
		
	self should: [Transference from: emitter to: receiver for: 50 * peso.] 
	
	raise: Error 
	
	withMessageText: Transference insufficientFundsFromTheEmitter.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'SC 12/9/2020 20:56:34'!
test03PartsOfTheTransferenceHasRegisteredATransaction

	emitter := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	emitter register: (Deposit for: 200 * peso).
	
	transference := Transference from: emitter to: receiver for: 50 * peso.
	
	self assert: (emitter hasRegistered: transference originPart).
	self assert: emitter balance equals: 150 * peso.
	self assert: (receiver hasRegistered: transference destinationPart).
	self assert: receiver balance equals: 50 * peso.! !

!TransferenceTest methodsFor: 'tests' stamp: 'SC 12/9/2020 20:53:16'!
test04TransferencePartsKnowEachOther
	| originTransferPart destinationTransferPart |
	
	emitter := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	emitter register: (Deposit for: 200 * peso).
	
	transference := Transference from: emitter to: receiver for: 50 * peso.
	
	originTransferPart := transference originPart.
	destinationTransferPart := transference destinationPart.
	
	self assert: originTransferPart counterpart equals: destinationTransferPart.
	self assert: destinationTransferPart counterpart equals: originTransferPart.
	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'SC 12/9/2020 20:53:16'!
test05TransferenceHasValueAsignated

	emitter := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	emitter register: (Deposit for: 200 * peso).
	
	transference := Transference from: emitter to: receiver for: 50 * peso.
	
	self assert: transference value equals: 50 * peso.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummary methodsFor: 'initialization' stamp: 'FL 12/12/2020 13:16:36'!
initializeFor: anAccount

	account _ anAccount.! !


!AccountSummary methodsFor: 'printing' stamp: 'FL 12/12/2020 13:16:05'!
printReport

	| text |
	
	text _ ''.
	
	account withAllMyTransactionsDo:
	
		[:aTransaction | text _ text append: (self headerFor: aTransaction), aTransaction value asString, ' '].
		
	^text append: 'Balance = ', account balance asString.! !


!AccountSummary methodsFor: 'private' stamp: 'FL 12/12/2020 12:57:22'!
headerFor: aTransaction

	{
		Deposit -> 'Depósito por '.
		Withdraw -> 'Extracción por '.
		OriginTransferPart -> 'Salida por transferencia de '.
		DestinationTransferPart -> 'Entrada por transferencia de '
		
	} detect: [:aHeader | aTransaction class = aHeader key] ifFound: [:aHeader | ^aHeader value] 
	
	ifNone: [self error: 'There is no header for the class ',aTransaction class asString].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'FL 12/12/2020 12:40:09'!
for: anAccount 

	^self new initializeFor: anAccount ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'FL 12/7/2020 02:51:42'!
accountMovement 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'FL 12/7/2020 02:50:49'!
accountMovement

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'FL 12/7/2020 02:51:06'!
accountMovement

	^ -1 * value! !

!Withdraw methodsFor: 'value' stamp: 'FL 12/7/2020 02:47:01'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #OriginTransferPart category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #OriginTransferPart
	instanceVariableNames: 'originTransference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OriginTransferPart methodsFor: 'initialization' stamp: 'FL 12/8/2020 15:29:50'!
initializeFrom: aOriginTransference 

	originTransference := aOriginTransference.! !


!OriginTransferPart methodsFor: 'accessing' stamp: 'FL 12/8/2020 15:28:32'!
accountMovement

	^-1 * originTransference value.! !

!OriginTransferPart methodsFor: 'accessing' stamp: 'SC 12/9/2020 20:02:46'!
counterpart

	^originTransference destinationPart.! !

!OriginTransferPart methodsFor: 'accessing' stamp: 'FL 12/8/2020 15:32:00'!
value

	^originTransference value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OriginTransferPart class' category: 'ServiciosFinancieros-Ejercicio'!
OriginTransferPart class
	instanceVariableNames: ''!

!OriginTransferPart class methodsFor: 'instance creation' stamp: 'FL 12/8/2020 15:31:11'!
from: aOriginTransference 

	^self new initializeFrom: aOriginTransference ! !


!classDefinition: #DestinationTransferPart category: 'ServiciosFinancieros-Ejercicio'!
OriginTransferPart subclass: #DestinationTransferPart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DestinationTransferPart methodsFor: 'accessing' stamp: 'FL 12/8/2020 15:32:52'!
accountMovement

	^self value.! !

!DestinationTransferPart methodsFor: 'accessing' stamp: 'SC 12/9/2020 20:02:20'!
counterpart

	^originTransference originPart.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'testing' stamp: 'FL 12/8/2020 16:42:53'!
hasRegistered: aTransaction 
	
	^accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accessing' stamp: 'FL 12/8/2020 16:14:46'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ].! !

!Portfolio methodsFor: 'accessing' stamp: 'FL 12/12/2020 13:06:02'!
withAllMyTransactionsDo: aBlock
 
	accounts do: [:anAccount | anAccount withAllMyTransactionsDo: aBlock].! !


!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FL 12/7/2020 02:51:20'!
balance

	^transactions sum: [ :aTransaction | aTransaction accountMovement ] ifEmpty: [ 0 * peso ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'FL 12/12/2020 12:55:31'!
withAllMyTransactionsDo: aBlock
 
	transactions do: [:aTransaction | aBlock value: aTransaction].! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value withdrawPart depositPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'SC 12/9/2020 19:57:11'!
initializeFrom: aEmitterAccount to: aReceiverAccount for: transferenceAmount 

	value := transferenceAmount.
	
	withdrawPart := OriginTransferPart from: self.
	depositPart := DestinationTransferPart from: self.	
	
	aEmitterAccount register: withdrawPart.
	aReceiverAccount register: depositPart.! !


!Transference methodsFor: 'accessing' stamp: 'SC 12/9/2020 20:02:46'!
destinationPart
	
	^depositPart.! !

!Transference methodsFor: 'accessing' stamp: 'SC 12/9/2020 20:02:20'!
originPart
	
	^withdrawPart.! !

!Transference methodsFor: 'accessing' stamp: 'FL 12/8/2020 15:12:11'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'FL 12/7/2020 23:10:16'!
from: aEmitterAccount to: aReceiverAccount for: transferenceAmount
	
	self validateEmitterFunds: transferenceAmount for: aEmitterAccount.
	
	^self new initializeFrom: aEmitterAccount to: aReceiverAccount for: transferenceAmount.! !


!Transference class methodsFor: 'error messages' stamp: 'FL 12/8/2020 12:28:01'!
insufficientFundsFromTheEmitter

	^'The emitter has insuficient funds for this transference'! !

!Transference class methodsFor: 'error messages' stamp: 'FL 12/7/2020 14:51:32'!
invalidTransferenceAmountErrorMessage

	^ 'invalid transference amount'! !


!Transference class methodsFor: 'private' stamp: 'FL 12/7/2020 23:10:16'!
validateEmitterFunds: transferenceAmount for: aEmitterAccount

	(transferenceAmount > 0) ifFalse: [self error: self invalidTransferenceAmountErrorMessage].
	(aEmitterAccount balance >= transferenceAmount ) ifFalse: [self error: self insufficientFundsFromTheEmitter]! !
