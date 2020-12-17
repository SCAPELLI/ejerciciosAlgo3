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


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:30:46'!
test01AnAccoutWithNoTransactionHasNoMovementsSummary

	| report account |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary for: account.
	
	self	assert: 'Balance = 0 pesos', self newLine 		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:31:05'!
test02AccountTransactionsShouldChangeAccountSummary

	| account report |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 20 * peso).
	report _ AccountSummary for: account.
	
	self deny: ('Balance = 0 pesos', self newLine 		= report printReport).! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:31:23'!
test03ValuesOfRecordedTransactionsAreDistinguished

	| account report expectedReportText |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 80 * peso).
	report _ AccountSummary for: account.
	expectedReportText _ 'Depósito por 80 pesos',self newLine, 'Balance = 80 pesos', self newLine	.
	
	self	assert: expectedReportText equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:31:30'!
test04MultipleTransactionsCanBeRegister

	| account report expectedReportText |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 20 * peso).
	account register: (Deposit for: 80 * peso).
	report _ AccountSummary for: account.
	expectedReportText _ 'Depósito por 20 pesos', self newLine, 
					    'Depósito por 80 pesos', self newLine,
				           'Balance = 100 pesos', self newLine.
	
	self	assert: expectedReportText 	equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:31:34'!
test05AccountSummaryReflectsAccountBalance

	| account report expectedReportText |
	
	account _ ReceptiveAccount new.
	
	account register: (Deposit for: 20 * peso).
	account register: (Withdraw for: 20 * peso).
	report _ AccountSummary for: account.
	expectedReportText	 _ 'Depósito por 20 pesos', self newLine,
					    'Extracción por 20 pesos', self newLine,
					    'Balance = 0 pesos', self newLine.
	
	self	assert: expectedReportText 		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:31:45'!
test06TransferencesAreContemplatedInTheAccountSummary

	| originAccount destinationAccount originReport destinationReport expectedReportTextInOrigin expectedReportTextInDestination |
	
	originAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	originReport _ AccountSummary for: originAccount .	
	destinationReport _ AccountSummary for: destinationAccount.

	originAccount register: (Deposit for: 20 * peso).
	Transference from: originAccount to: destinationAccount for: 10 * peso.
	expectedReportTextInOrigin _ 'Depósito por 20 pesos', self newLine, 'Salida por transferencia de 10 pesos', self newLine, 'Balance = 10 pesos', self newLine.
	expectedReportTextInDestination _ 'Entrada por transferencia de 10 pesos', self newLine, 'Balance = 10 pesos', self newLine.
	
	self	assert: expectedReportTextInOrigin 		equals: originReport printReport.
	self	assert: expectedReportTextInDestination equals: destinationReport printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:31:50'!
test07ASummaryCanBeBuildFromPortfolioTransactions

	| account  portfolio report expectedReportText |
	
	account _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	report _ AccountSummary for: portfolio.
	account register: (Deposit for: 20 * peso).
	expectedReportText _ 'Depósito por 20 pesos', self newLine, 'Balance = 20 pesos', self newLine.

	
	self	assert: 	expectedReportText 	equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:32:01'!
test08TransferenceNetShouldBeZeroIfAccountHasNoTransferences

	| account  report  |
	
	account _ ReceptiveAccount new.
	
	report _ TransferNet for: account.
	
	account register: (Deposit for: 900 * peso).
	
	self	assert: 'Transference Net = 0 pesos', self newLine		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:32:10'!
test09AccountTransferencesAffectTransferNetReport

	| originAccount destinationAccount  report  |
	
	originAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	report _ TransferNet for: originAccount.
	
	originAccount register: (Deposit for: 900 * peso).
	Transference from: originAccount to: destinationAccount for: 100* peso.
	
	self	assert: 'Transference Net = -100 pesos'	, self newLine 	equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:32:16'!
test10TransferNetShouldBeAPartialBalanceForTransferences
	| originAccount destinationAccount  report  |
	
	originAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	report _ TransferNet for: originAccount.
	
	originAccount register: (Deposit for: 900 * peso).
	Transference from: originAccount to: destinationAccount for: 450* peso.
	Transference from: destinationAccount to: originAccount for: 200* peso.
	
	self	assert: 'Transference Net = -250 pesos', self newLine		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:41:14'!
test11APortfolioWithAnAccountTreeShouldIdentOneTime
	| account portfolio report  expectedReportText |
	
	account _ ReceptiveAccount named: 'Cuenta de Santa Claus'.
	portfolio _ Portfolio named: 'Portfolio de Navidad' with: account.
	
	report _ PortfolioTreePrinter for: portfolio.
	
	expectedReportText _ 'Portfolio de Navidad', self newLine,
					    '    Cuenta de Santa Claus', self newLine.
	
	self	assert: expectedReportText 		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 02:42:35'!
test12APortfolioTreeCanHaveManyAccounts

	| santaAccount rudolphAccount christmasPortfolio report  expectedReportText |
	
	santaAccount _ ReceptiveAccount named: 'Cuenta de Santa Claus'.
	rudolphAccount _ ReceptiveAccount named: 'Cuenta de Rodolfo el reno'.
	christmasPortfolio _ Portfolio named: 'Portfolio de Navidad' with: santaAccount with: rudolphAccount .
	report _ PortfolioTreePrinter for: christmasPortfolio.
	
	expectedReportText _ 'Portfolio de Navidad', self newLine,
					    '    Cuenta de Santa Claus', self newLine, 
					    '    Cuenta de Rodolfo el reno', self newLine.
	
	self assert: expectedReportText equals: report printReport.
	! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 03:27:03'!
test13APortfolioTreeRecognizeMultipleLevelsIdentation

	| santaAccount rudolphAccount christmasPortfolio reindeerPortfolio report  expectedReportText |
	
	santaAccount _ ReceptiveAccount named: 'Cuenta de Santa Claus'.
	rudolphAccount _ ReceptiveAccount named: 'Cuenta de Rodolfo el reno'.
	reindeerPortfolio _ Portfolio named: 'Portfolio de renos' with: rudolphAccount.
	christmasPortfolio _ Portfolio named: 'Portfolio de Navidad' with: santaAccount with: reindeerPortfolio.
	report _ PortfolioTreePrinter for: christmasPortfolio.
	
	expectedReportText _ 'Portfolio de Navidad', self newLine,
					    '    Cuenta de Santa Claus', self newLine,
					    '    Portfolio de renos',self newLine, 
					    '        Cuenta de Rodolfo el reno', self newLine.
	
	self assert: expectedReportText equals: report printReport.
	! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/17/2020 03:17:18'!
test14PortfolioDetailedTreeReflextAccountTransactionsToo

	| santaAccount rudolphAccount christmasPortfolio reindeerPortfolio report  expectedReportText |
	
	santaAccount _ ReceptiveAccount named: 'Cuenta de Santa Claus'.
	rudolphAccount _ ReceptiveAccount named: 'Cuenta de Rodolfo el reno'.
	reindeerPortfolio _ Portfolio named: 'Portfolio de renos' with: rudolphAccount.
	christmasPortfolio _ Portfolio named: 'Portfolio de Navidad' with: santaAccount with: reindeerPortfolio.
	report _ PortfolioDetailedTreePrinter for: christmasPortfolio.
	santaAccount register: (Deposit for: 20 * peso).
	
	expectedReportText _ 'Portfolio de Navidad', self newLine,
					    '    Cuenta de Santa Claus', self newLine,
					    '        Depósito por 20 pesos', self newLine,
					    '        Balance = 20 pesos', self newLine,
					    '    Portfolio de renos',self newLine, 
					    '        Cuenta de Rodolfo el reno', self newLine,
					    '            Balance = 0 pesos', self newLine,
					    '        Balance = 0 pesos', self newLine,
					    '    Balance = 20 pesos', self newLine.
	
	self assert: expectedReportText equals: report printReport.
	! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/14/2020 20:38:53'!
test15PortfolioTreePrinterOnlyCanBeBuildFromAPortfolio

	| santaAccount report  |
	
	santaAccount _ ReceptiveAccount named: 'Cuenta de Santa Claus'.

	
	self should: [report _ PortfolioTreePrinter for: santaAccount] 
	
		raise: Error 
		
		withMessageText: 'Para generar el reporte, la cuenta debe ser un portfolio'.
	! !


!ReportTest methodsFor: 'print alignament' stamp: 'FL 12/13/2020 15:39:35'!
newLine

	^Character lf asString.! !


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


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'FL 12/13/2020 16:31:30'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'FL 12/13/2020 16:31:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'composition - private' stamp: 'FL 12/13/2020 16:32:10'!
addedTo: aPortfolio

	self subclassResponsibility ! !

!Account methodsFor: 'composition - private' stamp: 'FL 12/13/2020 16:31:11'!
isComposedBy: anAccount

	self subclassResponsibility.! !


!Account methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 00:29:30'!
howToTreatMeIn: aReport

	^self subclassResponsibility! !


!Account methodsFor: 'accessing' stamp: 'FL 12/13/2020 18:20:20'!
name

	^self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'FL 12/14/2020 20:10:21'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := 'aPortfolio'.! !

!Portfolio methodsFor: 'initialization' stamp: 'FL 12/13/2020 11:01:00'!
initializeNamedAs: anAccountName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := anAccountName.! !


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


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'main protocol' stamp: 'FL 12/8/2020 16:14:46'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'FL 12/13/2020 18:20:33'!
name

	^name! !


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


!Portfolio methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 01:54:17'!
howToTreatMeIn: aReport

	^aReport handleAccountAsPortfolio: self! !

!Portfolio methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 01:56:07'!
withAllMyAccountsDo: aBlock

	accounts do: [:anAccount | aBlock value: anAccount].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 11:01:00'!
named: anAccountName with: anAccount
	
	^(self new initializeNamedAs: anAccountName)
	add: anAccount;
	yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 11:01:16'!
named: anAccountName with: anAccount with: anotherAccount

	^(self new initializeNamedAs: anAccountName)
	add: anAccount;
	add: anotherAccount;
	yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 21:42:55'!
with: anAccount

	^self new
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 21:43:05'!
with: anAccount with: anotherAccount

	^self new
		add: anAccount;
		add: anotherAccount;
		yourself
		! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FL 12/14/2020 20:10:12'!
initialize

	transactions := OrderedCollection new.
	name := 'aReceptiveAccount'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FL 12/13/2020 21:47:02'!
initializeNamedAs: anAccountName

	transactions := OrderedCollection new.
	name := anAccountName.! !


!ReceptiveAccount methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 00:34:36'!
howToTreatMeIn: aReport

	^aReport handleAccountAsReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'private - reporting' stamp: 'FL 12/12/2020 12:55:31'!
withAllMyTransactionsDo: aBlock
 
	transactions do: [:aTransaction | aBlock value: aTransaction].! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FL 12/7/2020 02:51:20'!
balance

	^transactions sum: [ :aTransaction | aTransaction accountMovement ] ifEmpty: [ 0 * peso ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FL 12/13/2020 18:20:45'!
name

	^name! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 11:01:43'!
named: anAccountName

	^self new initializeNamedAs: anAccountName.! !


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


!AccountTransaction methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 00:29:43'!
howToTreatMeIn: aReport

	^self subclassResponsibility ! !


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


!Deposit methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 00:31:28'!
howToTreatMeIn: aReport

	^aReport handleTransactionAsDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 15:51:58'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #DestinationTransferPart category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #DestinationTransferPart
	instanceVariableNames: 'originTransference value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DestinationTransferPart methodsFor: 'accessing' stamp: 'FL 12/13/2020 16:01:32'!
accountMovement

	^originTransference value.! !

!DestinationTransferPart methodsFor: 'accessing' stamp: 'SC 12/9/2020 20:02:20'!
counterpart

	^originTransference originPart.! !

!DestinationTransferPart methodsFor: 'accessing' stamp: 'FL 12/13/2020 16:01:07'!
value

	^originTransference value! !


!DestinationTransferPart methodsFor: 'initialization' stamp: 'FL 12/13/2020 15:54:05'!
initializeFrom: aOriginTransference 

	originTransference := aOriginTransference.! !


!DestinationTransferPart methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 01:49:52'!
howToTreatMeIn: aReport

	^aReport handleTransactionAsDestinationTransferPart: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DestinationTransferPart class' category: 'ServiciosFinancieros-Ejercicio'!
DestinationTransferPart class
	instanceVariableNames: ''!

!DestinationTransferPart class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 15:57:19'!
from: aOriginTransference 

	^self new initializeFrom: aOriginTransference ! !


!classDefinition: #OriginTransferPart category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #OriginTransferPart
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


!OriginTransferPart methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 01:50:05'!
howToTreatMeIn: aReport

	^aReport handleTransactionAsOriginTransferPart: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OriginTransferPart class' category: 'ServiciosFinancieros-Ejercicio'!
OriginTransferPart class
	instanceVariableNames: ''!

!OriginTransferPart class methodsFor: 'instance creation' stamp: 'FL 12/8/2020 15:31:11'!
from: aOriginTransference 

	^self new initializeFrom: aOriginTransference ! !


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


!Withdraw methodsFor: 'private - reporting' stamp: 'FL 12/17/2020 00:31:47'!
howToTreatMeIn: aReport

	^aReport handleTransactionAsWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 15:52:03'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Report methodsFor: 'main primitives' stamp: 'FL 12/13/2020 15:27:12'!
printReport

	^self subclassResponsibility.! !


!Report methodsFor: 'private - account' stamp: 'FL 12/17/2020 03:23:25'!
handleAccountAsPortfolio: aPortfolio

	^self subclassResponsibility.! !

!Report methodsFor: 'private - account' stamp: 'FL 12/17/2020 03:23:33'!
handleAccountAsReceptiveAccount: aReceptiveAccount

	^self subclassResponsibility.! !


!Report methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:23:41'!
handleTransactionAsDeposit: aDeposit

	^self subclassResponsibility.! !

!Report methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:23:50'!
handleTransactionAsDestinationTransferPart: aDestinationTransferPart

	^self subclassResponsibility.! !

!Report methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:23:58'!
handleTransactionAsOriginTransferPart: aOriginTransferPart

	^self subclassResponsibility.! !

!Report methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:24:07'!
handleTransactionAsWithdraw: aWithdraw

	^self subclassResponsibility.! !


!Report methodsFor: 'private - alignament' stamp: 'FL 12/17/2020 02:11:12'!
indentationWithDepth: aDepthCardinal
	
	| indentation |
	
	indentation := ''.
	
	aDepthCardinal timesRepeat: [indentation := indentation,'    '.].
	
	^indentation.! !

!Report methodsFor: 'private - alignament' stamp: 'FL 12/13/2020 15:12:00'!
newLine

	^Character lf asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 15:28:00'!
for: anAccount

	^self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account reportText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummary methodsFor: 'initialization' stamp: 'FL 12/12/2020 13:16:36'!
initializeFor: anAccount

	account _ anAccount.! !


!AccountSummary methodsFor: 'printing' stamp: 'FL 12/17/2020 02:30:04'!
printReport

	reportText _ ''.
	
	account howToTreatMeIn: self.

	^reportText,'Balance = ', account balance asString, self newLine.! !


!AccountSummary methodsFor: 'private - trnasaction' stamp: 'FL 12/17/2020 01:49:11'!
handleTransactionAsDeposit: aDeposit

	^'Depósito por ', aDeposit value asString, self newLine.! !

!AccountSummary methodsFor: 'private - trnasaction' stamp: 'FL 12/17/2020 01:49:52'!
handleTransactionAsDestinationTransferPart: aDestinationTransferPart

	^'Entrada por transferencia de ', aDestinationTransferPart value asString, self newLine.! !

!AccountSummary methodsFor: 'private - trnasaction' stamp: 'FL 12/17/2020 01:50:05'!
handleTransactionAsOriginTransferPart: aTransaction

	^'Salida por transferencia de ', aTransaction value asString, self newLine.! !

!AccountSummary methodsFor: 'private - trnasaction' stamp: 'FL 12/17/2020 01:37:24'!
handleTransactionAsWithdraw: aTransaction

	^'Extracción por ', aTransaction value asString, self newLine.! !


!AccountSummary methodsFor: 'private - account' stamp: 'FL 12/17/2020 01:43:29'!
handleAccountAsPortfolio: aPortfolio

	 aPortfolio withAllMyAccountsDo: [:anAccount | anAccount howToTreatMeIn: self].! !

!AccountSummary methodsFor: 'private - account' stamp: 'FL 12/17/2020 01:51:02'!
handleAccountAsReceptiveAccount: aReceptiveAccount

	aReceptiveAccount withAllMyTransactionsDo: [:aTransaction | reportText _ reportText,(aTransaction howToTreatMeIn: self)].

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'FL 12/12/2020 12:40:09'!
for: anAccount 

	^self new initializeFor: anAccount ! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio reportText currentIndentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'FL 12/17/2020 02:40:03'!
initializeFor: aPortfolio

	portfolio _ aPortfolio.
	reportText _ ''.
	currentIndentationLevel _ 0.! !


!PortfolioTreePrinter methodsFor: 'main primitives' stamp: 'FL 12/17/2020 02:29:36'!
printReport

	reportText _ ''.
	
	portfolio howToTreatMeIn: self.
	
	^reportText! !

!PortfolioTreePrinter methodsFor: 'main primitives' stamp: 'FL 12/17/2020 00:17:49'!
printReportDetailed

	
	text _ ''.
	
	portfolio inPreOrderTraversalDo: [:anAccount :aLevelNumber | 	| identation | 	identation := ''.
		
		aLevelNumber -1 timesRepeat: [identation _ identation append: self ident,''].
		
		text = '' ifFalse: [text _ text,self newLine, identation , anAccount name] 		ifTrue: [text _ anAccount name].
		
		(anAccount isKindOf: ReceptiveAccount) ifTrue: [		|nextLeveldentation |			nextLeveldentation _ identation append: self ident.
			
			anAccount withAllMyTransactionsDo:
			
				[:aTransaction | text _ text, self newLine,nextLeveldentation, (aTransaction howToTreatMeIn: self), aTransaction value asString]
				 
		].
	
	].

	^text! !


!PortfolioTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 02:27:56'!
handleTransactionAsDeposit: aTrasaction! !

!PortfolioTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 02:28:03'!
handleTransactionAsDestinationTransferPart: aTransaction! !

!PortfolioTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 02:28:08'!
handleTransactionAsOriginTransferPart: aTransaction! !

!PortfolioTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 02:28:14'!
handleTransactionAsWithdraw: aTransaction! !


!PortfolioTreePrinter methodsFor: 'private - account' stamp: 'FL 12/17/2020 02:58:04'!
handleAccountAsPortfolio: aPortfolio

	self insertTextAligned: aPortfolio name.
	
	currentIndentationLevel _ currentIndentationLevel + 1.
	
	aPortfolio withAllMyAccountsDo: [:anAccount | 		anAccount howToTreatMeIn: self].
	
	currentIndentationLevel _ currentIndentationLevel - 1.! !

!PortfolioTreePrinter methodsFor: 'private - account' stamp: 'FL 12/17/2020 02:58:53'!
handleAccountAsReceptiveAccount: aReceptiveAccount

	self insertTextAligned: aReceptiveAccount name.! !


!PortfolioTreePrinter methodsFor: 'private - alignament' stamp: 'FL 12/17/2020 03:25:23'!
insertTextAligned: textToInsert

	reportText _ reportText, (self indentationWithDepth: currentIndentationLevel), textToInsert, self newLine.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Ejercicio'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'FL 12/14/2020 20:24:38'!
for: aPortfolio

	(aPortfolio isKindOf: Portfolio ) ifFalse: [self error: 'Para generar el reporte, la cuenta debe ser un portfolio'].
	
	^self new initializeFor: aPortfolio.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Ejercicio'!
PortfolioTreePrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioDetailedTreePrinter methodsFor: 'private - account' stamp: 'FL 12/17/2020 03:11:13'!
handleAccountAsPortfolio: aPortfolio

	self insertTextAligned: aPortfolio name.
	
	currentIndentationLevel _ currentIndentationLevel + 1.
	
	aPortfolio withAllMyAccountsDo: [:anAccount | 		anAccount howToTreatMeIn: self].
	
	self insertTextAligned: 'Balance = ', aPortfolio balance asString.
	
	currentIndentationLevel _ currentIndentationLevel - 1.
	! !

!PortfolioDetailedTreePrinter methodsFor: 'private - account' stamp: 'FL 12/17/2020 03:11:00'!
handleAccountAsReceptiveAccount: aReceptiveAccount

	self insertTextAligned: aReceptiveAccount name.
	
	currentIndentationLevel _ currentIndentationLevel + 1.
	
	aReceptiveAccount withAllMyTransactionsDo: [:anAccount | 		anAccount howToTreatMeIn: self].
	
	self insertTextAligned: 'Balance = ', aReceptiveAccount balance asString.
	
	currentIndentationLevel _ currentIndentationLevel - 1.
	! !


!PortfolioDetailedTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:05:09'!
handleTransactionAsDeposit: aDeposit

	self insertTextAligned: 'Depósito por ', aDeposit  value asString.! !

!PortfolioDetailedTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:07:43'!
handleTransactionAsDestinationTransferPart: aDestinationTransferPart

	self insertTextAligned: 'Entrada por transferencia de ', aDestinationTransferPart  value asString.! !

!PortfolioDetailedTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:07:57'!
handleTransactionAsOriginTransferPart: originTransferPart

	self insertTextAligned: 'Salida por transferencia de ',  originTransferPart value asString! !

!PortfolioDetailedTreePrinter methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:08:30'!
handleTransactionAsWithdraw: withdraw

	self insertTextAligned: 'Extracción por ',  withdraw value asString.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: 'account transferBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNet methodsFor: 'printing' stamp: 'FL 12/17/2020 02:30:15'!
printReport
	
	transferBalance _ 0 * peso.
	
	account howToTreatMeIn: self.
	
	^'Transference Net = ', transferBalance asString, self newLine.! !


!TransferNet methodsFor: 'initialization' stamp: 'FL 12/13/2020 15:29:48'!
initializeFor: anAccount

	account _ anAccount.! !


!TransferNet methodsFor: 'private - account' stamp: 'FL 12/17/2020 01:57:13'!
handleAccountAsPortfolio: aPortfolio

	 aPortfolio withAllMyAccountsDo: [:anAccount | anAccount howToTreatMeIn: self].! !

!TransferNet methodsFor: 'private - account' stamp: 'FL 12/17/2020 02:02:14'!
handleAccountAsReceptiveAccount: aReceptiveAccount

	aReceptiveAccount withAllMyTransactionsDo: [:aTransaction | transferBalance _ transferBalance + (aTransaction howToTreatMeIn: self)].
! !


!TransferNet methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:25:51'!
handleTransactionAsDeposit: aDeposit

	^0* peso.! !

!TransferNet methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:26:04'!
handleTransactionAsDestinationTransferPart: aDestinationTransferPart

	^aDestinationTransferPart accountMovement.! !

!TransferNet methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:26:18'!
handleTransactionAsOriginTransferPart: aOriginTransferPart

	^aOriginTransferPart accountMovement.! !

!TransferNet methodsFor: 'private - transaction' stamp: 'FL 12/17/2020 03:26:28'!
handleTransactionAsWithdraw: aWithdraw

	^0* peso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'FL 12/13/2020 15:29:15'!
for: anAccount 

	^self new initializeFor: anAccount ! !


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
