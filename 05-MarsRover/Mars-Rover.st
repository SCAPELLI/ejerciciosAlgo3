!classDefinition: #MarsRoverTest category: 'Mars-Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'North South East West marsRover startPoint north1Step north2Steps east1Step east2Steps'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test01TheRoverKnowsItsPosition

	marsRover := MarsRover startMissionAt: startPoint pointingTo: North.
	
	self assert: ( marsRover isFoundAt: startPoint ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test02TheRoverKnowsItsHeading

	marsRover := MarsRover startMissionAt: startPoint pointingTo: South.
	
	self assert: ( marsRover isPointingTo: South ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test03TheRoverRemainsStillWhenAnEmptyRequestIsExecuted

	marsRover := MarsRover startMissionAt: startPoint pointingTo: South.
	
	marsRover execute: ''.
	
	self assert: (marsRover isFoundAt: startPoint).
	self assert: (marsRover isPointingTo: South).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test04MoveForwareChangeTheRoverPosition

	marsRover := MarsRover startMissionAt: startPoint pointingTo: North.
	
	marsRover execute: 'f'.
	
	self assert: (marsRover isFoundAt: startPoint + north1Step).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test05DisplacementIsRelativeToTheRoverHeading

	marsRover := MarsRover startMissionAt: startPoint pointingTo: East.
	
	marsRover execute: 'f'.
	
	self assert: (marsRover isFoundAt: startPoint + east1Step).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test06TheRoverCanExecuteSeveralCommandsAtTheSameTime

	marsRover := MarsRover startMissionAt: startPoint pointingTo: East .
	
	marsRover execute: 'ff'.
	
	self assert: (marsRover isFoundAt: east2Steps + startPoint ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test07MoveBackwardIsTheOppositeOfMoveForward

	marsRover := MarsRover startMissionAt: startPoint pointingTo: North.
	
	marsRover execute: 'fb'.
	
	self assert: (marsRover isFoundAt: startPoint).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test08RotationShouldChangeTheRoverHeading

	marsRover := MarsRover startMissionAt: startPoint pointingTo: North.
	
	marsRover execute: 'r'.
	
	self assert: (marsRover isPointingTo: East).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test09RotationIsRelativeToTheRoverHeading

	marsRover := MarsRover startMissionAt: startPoint pointingTo: North.
	
	marsRover execute: 'rr'.
	
	self assert: (marsRover isPointingTo: South).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test10LeftRotationIsOppositeOfRightRotation

	marsRover := MarsRover startMissionAt: startPoint pointingTo: North.
	
	marsRover execute: 'rl'.
	
	self assert: (marsRover isPointingTo: North).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 12:15:37'!
test11TheRoverStopsCommandExecutionAfterAnInvalidRequest

	marsRover := MarsRover startMissionAt: startPoint pointingTo: North.
	
	marsRover execute: 'ffwbb'.
	
	self assert: (marsRover isFoundAt: north2Steps + startPoint).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 21:24:00'!
test12TheRoverCanNotBePointedAtAnInvalidCardinalPoint
	
	self should: [ marsRover := MarsRover startMissionAt: startPoint pointingTo: #U.] 
	
	raise: Error 
	
	withExceptionDo: [ :error | 		self assert: error messageText = MarsRoverNavigateSystem invalidCardinalPointErrorMessage. 
					self assert: marsRover isNil		].
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/6/2020 21:24:13'!
test13TheMissionShouldStartAtAValidPosition
	
	self should: [ marsRover := MarsRover startMissionAt: 0 pointingTo: North.] 
	
	raise: Error
	
	withExceptionDo: [ :error | 		self assert: error messageText = MarsRoverNavigateSystem invalidStartingPointMessageError. 
					self assert: marsRover isNil		].

	
	
	
	! !


!MarsRoverTest methodsFor: 'setup' stamp: 'FL 12/6/2020 17:15:25'!
setUp
	
	North := #N.
	South := #S.
	East := #E.
	West := #O.
	startPoint := -1@20.
	north1Step := 1@0.
	north2Steps := 2@0.
	east1Step := 0@1.
	east2Steps := 0@2.! !


!classDefinition: #MarsRover category: 'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'navigateSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'FL 12/6/2020 17:20:53'!
initializeWith: aNavigateSystem
		
	navigateSystem := aNavigateSystem.! !


!MarsRover methodsFor: 'testing' stamp: 'FL 12/6/2020 17:20:39'!
isFoundAt: aWayPoint
 
	^navigateSystem isThePosition: aWayPoint.! !

!MarsRover methodsFor: 'testing' stamp: 'FL 12/6/2020 17:20:39'!
isPointingTo: aCardinalPoint

	^navigateSystem isTheDirection: aCardinalPoint.! !


!MarsRover methodsFor: 'private' stamp: 'FL 12/6/2020 17:37:03'!
wasTheCommandExecuted: aCommandKey
	
	{
		#f -> [self moveForward].
		#b -> [self moveBackward].
		#r -> [self turnRight].
		#l -> [self turnLeft].
		
	} detect: [:actualCommand | (actualCommand key ) = (aCommandKey asSymbol )] 
		
	ifFound: [:actualCommand  | (actualCommand value) value. ^true] 
	
	ifNone: [^false].! !


!MarsRover methodsFor: 'commands' stamp: 'FL 12/6/2020 17:41:06'!
execute: aCommandSequency
	
	| executedCommands theCommandIsValid |
	
	executedCommands := 1.
	theCommandIsValid := true.
	
	[executedCommands <= aCommandSequency size and: [theCommandIsValid]] whileTrue: [
		
		theCommandIsValid := self wasTheCommandExecuted: (aCommandSequency at: executedCommands).
		
		executedCommands := executedCommands + 1.
		
	].! !

!MarsRover methodsFor: 'commands' stamp: 'FL 12/6/2020 17:20:39'!
moveBackward

	navigateSystem registerBackwardMoving ! !

!MarsRover methodsFor: 'commands' stamp: 'FL 12/6/2020 17:20:39'!
moveForward

	navigateSystem registerForwardMoving ! !

!MarsRover methodsFor: 'commands' stamp: 'FL 12/6/2020 17:20:39'!
turnLeft

	navigateSystem regirsterLeftRotation ! !

!MarsRover methodsFor: 'commands' stamp: 'FL 12/6/2020 17:20:39'!
turnRight

	navigateSystem registerRightRotation ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FL 12/6/2020 16:36:08'!
startMissionAt: aWayPoint pointingTo: aCardinalPoint

	^self new initializeWith: (MarsRoverNavigateSystem at: aWayPoint pointingTo: aCardinalPoint ).! !


!classDefinition: #MarsRoverNavigateSystem category: 'Mars-Rover'!
Object subclass: #MarsRoverNavigateSystem
	instanceVariableNames: 'wayPoint directorPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverNavigateSystem methodsFor: 'initialization' stamp: 'FL 12/6/2020 10:16:33'!
initializeAt: aWayPoint pointingTo: aDirectorPoint

	wayPoint := aWayPoint.
	
	directorPoint := aDirectorPoint.! !


!MarsRoverNavigateSystem methodsFor: 'moving registration' stamp: 'FL 12/6/2020 16:08:12'!
regirsterLeftRotation

	directorPoint := (directorPoint y)@(-1 * directorPoint x).! !

!MarsRoverNavigateSystem methodsFor: 'moving registration' stamp: 'FL 12/6/2020 16:07:53'!
registerBackwardMoving

	wayPoint := wayPoint - directorPoint.! !

!MarsRoverNavigateSystem methodsFor: 'moving registration' stamp: 'FL 12/6/2020 16:08:42'!
registerForwardMoving

	wayPoint := wayPoint + directorPoint.! !

!MarsRoverNavigateSystem methodsFor: 'moving registration' stamp: 'FL 12/6/2020 16:08:26'!
registerRightRotation

	directorPoint := (-1 * directorPoint y)@(directorPoint x).! !


!MarsRoverNavigateSystem methodsFor: 'testing' stamp: 'FL 12/6/2020 16:20:38'!
isTheDirection: aCardinalPoint

	^(self class cardinalPointToDirectorPoint: aCardinalPoint) = directorPoint! !

!MarsRoverNavigateSystem methodsFor: 'testing' stamp: 'FL 12/6/2020 10:32:44'!
isThePosition: aWayPoint

	^aWayPoint = wayPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverNavigateSystem class' category: 'Mars-Rover'!
MarsRoverNavigateSystem class
	instanceVariableNames: ''!

!MarsRoverNavigateSystem class methodsFor: 'instance creation' stamp: 'FL 12/6/2020 17:27:42'!
at: aWayPoint pointingTo: aCardinalPoint
	
	(aWayPoint isKindOf: Point) ifFalse: [self error: self invalidStartingPointMessageError].
		
	^self new initializeAt: aWayPoint pointingTo: (self cardinalPointToDirectorPoint: aCardinalPoint).! !


!MarsRoverNavigateSystem class methodsFor: 'accessing' stamp: 'FL 12/6/2020 17:27:24'!
cardinalPointToDirectorPoint: aCardinalPoint

	{#N->(1@0). #S->(-1@0). #E->(0@1). #O->(0@-1)} 	detect: [:aDirectionMap | aDirectionMap key = aCardinalPoint ] 
	
	ifFound: [:aDirectionMap | ^aDirectionMap value] 
	
	ifNone: [self error: self invalidCardinalPointErrorMessage].! !


!MarsRoverNavigateSystem class methodsFor: 'error messages' stamp: 'FL 12/6/2020 16:12:26'!
invalidCardinalPointErrorMessage

	^ 'Invalid cardinal point'! !

!MarsRoverNavigateSystem class methodsFor: 'error messages' stamp: 'FL 12/6/2020 16:25:06'!
invalidStartingPointMessageError

	^'You traing to use an invalid start mission point'! !
