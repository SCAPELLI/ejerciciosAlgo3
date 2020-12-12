!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:01:40'!
peso).
	account forAllMyTransactionsDo: [ :arg3 |
		report registerTransaction: arg3 ].
	self
		assert: 'Depósito por 20 pesos 	Balance = 20 pesos'		equals: report printReport.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:01:55'!
o por 20 pesos 	Balance = 20 pesos'		equals: report printReport.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:02:25'!
'Balance = 0 pesos'
		equals: report printReport.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:03:26'!
ctionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 80 pesos 	Balance = 80'		equals: report printReport.! !

!PortfolioTest methodsFor: 'tests'!
stamp: 'FL 12/11/2020 21:03:36' prior: 50870012! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:05:38'!
E! !

!PortfolioTest methodsFor: 'tests'!
rtTest #test02 stamp: 'FL 12/11/2020 21:06:21'! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:07:19'!
test02
	| account report |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary new.
	
	account register: (Deposit for: 20 * peso).
	
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self assert: 'Depósito por 20 pesos Balance = 20 pesos'		equals: report printReport.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:07:24'!
eport _ AccountSummary new.
	
	account register: (Deposit for: 80 * peso).
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 80 pesos Balance = 80'		equals: report printReport.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:07:31'!
isKindOf: Deposit) ifTrue: [
		balance _ balance + arg1 accountMovement.
		text _ 'Depósito por ' , arg1 accountMovement asString, ' '].! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:08:43'!
esos'		equals: report printReport.! !

!ReceptiveAccountTest methodsFor: 'tests'!
12/11/2020 21:08:45'! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:08:59'!
account register: (Deposit for: 80 * peso).
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 80 pesos Balance = 80 pesos'		equals: report printReport.! !

!ReceptiveAccountTest methodsFor: 'tests'!
errides: 16896425! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:14:16'!
.
		text _ 'Depósito por ' , aTransaction accountMovement asString, ' '].! !

!ReceptiveAccountTest methodsFor: 'tests'!
val: ReceptiveAccount #getTransactions stamp: 'FL 12/11/2020 21:14:50'! !


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReportTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:02:38'!
test01
	| report |
	
	report _ AccountSummary new.
	
	self	assert: 'Balance = 0 pesos'		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:07:19'!
test02
	| account report |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary new.
	
	account register: (Deposit for: 20 * peso).
	
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self assert: 'Depósito por 20 pesos Balance = 20 pesos'		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:08:59'!
test03

	| account report |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary new.
	
	account register: (Deposit for: 80 * peso).
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 80 pesos Balance = 80 pesos'		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:19:02'!
test04

	| account report |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary new.
	
	account register: (Deposit for: 20 * peso).
	account register: (Deposit for: 80 * peso).
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 20 pesos Depósito por 80 pesos Balance = 100 pesos'		equals: report printReport.! !

!ReportTest methodsFor: 'tests' stamp: 'FL 12/11/2020 22:06:28'!
test05

	| account report |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary new.
	
	account register: (Deposit for: 20 * peso).
	account register: (Withdraw for: 20 * peso).
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 20 pesos Extracción por 20 pesos Balance = 0 pesos'		equals: report printReport.! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'emitter receiver transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'tests'!
unt methodsFor: 'accessing' stamp: 'FL 12/11/2020 21:15:23' prior: 50871254! !

!TransferenceTest methodsFor: 'tests' stamp: 'FL 12/11/2020 21:15:32'!
|
		aBlock value: aTransaction copy ].! !

!TransferenceTest methodsFor: 'tests'!
amp: 'FL 12/11/2020 21:15:44'! !

!TransferenceTest methodsFor: 'tests'!
nyOfTheComposedAccountOfPortfolioToAdd stamp: 'FL 12/11/2020 21:15:44'! !

!TransferenceTest methodsFor: 'tests'!
countTest #test01ReceptiveAccountHaveZeroAsBalanceWhenCreated stamp: 'FL 12/11/2020 21:15:44'! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: 'text balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummary methodsFor: 'printing' stamp: 'FL 12/11/2020 21:13:44'!
initialize

	text _ ''.
	balance _ 0 * peso.! !

!AccountSummary methodsFor: 'printing' stamp: 'FL 12/11/2020 21:05:42'!
printReport
	
	^text, 'Balance = ', balance asString.
	! !


!AccountSummary methodsFor: 'processing' stamp: 'FL 12/11/2020 22:06:38'!
registerTransaction: aTransaction

	balance _ balance + aTransaction accountMovement.
	
	(aTransaction isKindOf: Deposit) 		ifTrue: [	text _ text append: 'Depósito por ' , aTransaction value asString, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extracción por ' , aTransaction value asString, ' '].! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'FL 12/11/2020 21:19:02'!
ansaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 20 pesos Depósito por 80 pesos Balance = 100 pesos'		equals: report printReport.! !

!AccountTransaction methodsFor: 'value' stamp: 'FL 12/11/2020 21:19:02'!
Report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation'!
'FL 12/11/2020 21:20:00'! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization'!
stamp: 'FL 12/11/2020 21:20:50'! !


!Deposit methodsFor: 'value' stamp: 'FL 12/11/2020 21:22:20'!
test05

	| account report |
	
	account _ ReceptiveAccount new.
	report _ AccountSummary new.
	
	account register: (Deposit for: 20 * peso).
	account register: (Withdraw for: 20 * peso).
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 20 pesos Extraxción por 20 pesos Balance = 0 pesos'		equals: report printReport.! !

!Deposit methodsFor: 'value' stamp: 'FL 12/11/2020 21:22:20'!
20 * peso).
	account register: (Withdraw for: 20 * peso).
	account forAllMyTransactionsDo: [ :aTransaction |		report registerTransaction: aTransaction ].
	
	self	assert: 'Depósito por 20 pesos Extraxción por 20 pesos Balance = 0 pesos'		equals: report printReport.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation'!
amp: 'FL 12/11/2020 21:23:47' prior: 50870362! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'FL 12/11/2020 21:24:01'!
tion accountMovement.
	
	(aTransaction isKindOf: Deposit) 		ifTrue: [	text _ text append: 'Depósito por ' , aTransaction accountMovement asString, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extraxción por ' , aTransaction accountMovement asString, ' '].! !


!Withdraw methodsFor: 'value' stamp: 'FL 12/11/2020 21:24:01'!
Movement asString, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extraxción por ' , aTransaction accountMovement asString, ' '].! !

!Withdraw methodsFor: 'value' stamp: 'FL 12/11/2020 21:24:01'!
countMovement asString, ' '].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'FL 12/11/2020 21:24:39'!
ito por ' , aTransaction value, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extraxción por ' , aTransaction value, ' '].! !


!classDefinition: #OriginTransferPart category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #OriginTransferPart
	instanceVariableNames: 'originTransference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OriginTransferPart methodsFor: 'initialization'!
: 'processing' stamp: 'FL 12/11/2020 21:25:06' prior: 50870432! !


!OriginTransferPart methodsFor: 'accessing' stamp: 'FL 12/11/2020 21:25:06'!
ue: [	text _ text append: 'Depósito por ' , aTransaction value asString, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extraxción por ' , aTransaction value asString, ' '].! !

!OriginTransferPart methodsFor: 'accessing' stamp: 'FL 12/11/2020 21:25:06'!
or ' , aTransaction value asString, ' '].! !

!OriginTransferPart methodsFor: 'accessing'!
2/11/2020 21:25:07'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OriginTransferPart class' category: 'ServiciosFinancieros-Ejercicio'!
OriginTransferPart class
	instanceVariableNames: ''!

!OriginTransferPart class methodsFor: 'instance creation'!
r: 50870458! !


!classDefinition: #DestinationTransferPart category: 'ServiciosFinancieros-Ejercicio'!
OriginTransferPart subclass: #DestinationTransferPart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DestinationTransferPart methodsFor: 'accessing'!
est #test05 stamp: 'FL 12/11/2020 22:05:08'! !

!DestinationTransferPart methodsFor: 'accessing'!
05:08'! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization'!
fPortfolioToAdd stamp: 'FL 12/11/2020 22:05:08'! !


!Portfolio methodsFor: 'accounts management'!
testRun: #PortfolioTest #test08PortfolioHasBalanceAsSumOfEachComposedAccount stamp: 'FL 12/11/2020 22:05:08'! !


!Portfolio methodsFor: 'testing'!
dInAnAccountThatComposesIt stamp: 'FL 12/11/2020 22:05:08'! !

!Portfolio methodsFor: 'testing'!
rtfolioHasRegisteredASpecificTransaction stamp: 'FL 12/11/2020 22:05:08'! !

!Portfolio methodsFor: 'testing'!
iveAccountHaveZeroAsBalanceWhenCreated stamp: 'FL 12/11/2020 22:05:08'! !


!Portfolio methodsFor: 'accessing'!
'! !

!Portfolio methodsFor: 'accessing' stamp: 'FL 12/11/2020 22:05:08'!
ASSED! !


!Portfolio methodsFor: 'composition - private'!
actions stamp: 'FL 12/11/2020 22:05:08'! !

!Portfolio methodsFor: 'composition - private'!
estRun: #ReportTest #test02 stamp: 'FL 12/11/2020 22:05:08'! !

!Portfolio methodsFor: 'composition - private'!
est #test04 stamp: 'FL 12/11/2020 22:05:08'! !

!Portfolio methodsFor: 'composition - private'!
PASSED! !

!Portfolio methodsFor: 'composition - private'!
2:05:08'! !

!Portfolio methodsFor: 'composition - private'!
11/2020 22:05:13' prior: 50870486! !

!Portfolio methodsFor: 'composition - private' stamp: 'FL 12/11/2020 22:05:13'!
ito por ' , aTransaction value, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extraxción por ' , aTransaction value asString, ' '].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FL 12/11/2020 22:05:15'!
! !

!Portfolio class methodsFor: 'as yet unclassified'!
FL 12/11/2020 22:05:29' prior: 50870603! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FL 12/11/2020 22:05:29'!
action isKindOf: Deposit) 		ifTrue: [	text _ text append: 'Depósito por ' , aTransaction value asString, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extraxción por ' , aTransaction value asString, ' '].! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FL 12/11/2020 22:06:28'!
= 0 pesos'		equals: report printReport.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FL 12/11/2020 22:06:38'!
registerTransaction: aTransaction

	balance _ balance + aTransaction accountMovement.
	
	(aTransaction isKindOf: Deposit) 		ifTrue: [	text _ text append: 'Depósito por ' , aTransaction value asString, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extracción por ' , aTransaction value asString, ' '].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FL 12/11/2020 22:06:38'!
sString, ' '].
	
	(aTransaction isKindOf: Withdraw)		ifTrue: [	text _ text append: 'Extracción por ' , aTransaction value asString, ' '].! !

!ReceptiveAccount methodsFor: 'main protocol'!
est #test01 stamp: 'FL 12/11/2020 22:06:40'! !


!ReceptiveAccount methodsFor: 'composition - private'!
p: 'FL 12/11/2020 22:06:40'! !

!ReceptiveAccount methodsFor: 'composition - private'!
est #test05 stamp: 'FL 12/11/2020 22:06:40'! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'FL 12/11/2020 21:15:42'!
forAllMyTransactionsDo: aBlock

	transactions do: [ :aTransaction | 		aBlock value: aTransaction copy ].! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value withdrawPart depositPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization'!
! !


!Transference methodsFor: 'accessing'!
! !

!Transference methodsFor: 'accessing'!
! !

!Transference methodsFor: 'accessing'!
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation'!
! !


!Transference class methodsFor: 'error messages'!
! !

!Transference class methodsFor: 'error messages'!
! !


!Transference class methodsFor: 'private'!
! !
