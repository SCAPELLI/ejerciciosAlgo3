!classDefinition: #MarsRoverTest category: 'Mars-Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/2/2020 05:51:12'!
test01NotMakingMovementsDoesNotMoveTheRover

	| aRober |
	
	aRober := MarsRover positionedAt: 0@0 lookingAt: 'N'.
	
	aRober doThisMovements: ''.
	
	self assert: (aRober isLocatedAt: 0@0 lookingAt: North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/2/2020 05:50:09'!
test02AfterMovingForwardPositionWillBeChanged

	| aRober |
	
	aRober := MarsRover positionedAt: 0@0 lookingAt: 'N'.
	
	aRober doThisMovements: 'f'.
	
	self deny: (aRober isLocatedAt: 0@0 lookingAt: North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/2/2020 05:50:09'!
test03TurnRightWillChangeDirection

	| aRober |
	
	aRober := MarsRover positionedAt: 0@0 lookingAt: 'N'.
	
	aRober doThisMovements: 'r'.
	
	self deny: (aRober isLocatedAt: 0@0 lookingAt: North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/2/2020 05:50:09'!
test04StepBackWillChangePosition

	| aRober |
	
	aRober := MarsRover positionedAt: 0@0 lookingAt: 'N'.
	
	aRober doThisMovements: 'b'.
	
	self deny: (aRober isLocatedAt: 0@0 lookingAt: North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/2/2020 16:16:18'!
test05TheRoverCanReciveManyCommands

	| aRober |
	
	aRober := MarsRover positionedAt: 0@0 lookingAt: 'N'.
	
	aRober doThisMovements: 'bbfr'.
	
	self assert: (aRober isLocatedAt: -1@0 lookingAt: East).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/2/2020 19:12:03'!
test06ExecutionStopsWhenInvalidComandIsReached

	| aRober |
	
	aRober := MarsRover positionedAt: 0@0 lookingAt: 'N'.
	
	aRober doThisMovements: 'bbfrjfl'.
	
	self assert: (aRober isLocatedAt: -1@0 lookingAt: East).! !


!classDefinition: #CardinalPoint category: 'Mars-Rover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!CardinalPoint methodsFor: 'private' stamp: 'FL 12/2/2020 07:07:13'!
moveBackward

	^self subclassResponsibility ! !

!CardinalPoint methodsFor: 'private' stamp: 'FL 12/2/2020 07:07:07'!
moveForward

	^self subclassResponsibility ! !

!CardinalPoint methodsFor: 'private' stamp: 'FL 12/2/2020 07:07:23'!
turnLeft

	^self subclassResponsibility ! !

!CardinalPoint methodsFor: 'private' stamp: 'FL 12/2/2020 07:07:19'!
turnRight

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: 'Mars-Rover'!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'instance creation' stamp: 'FL 12/2/2020 05:36:31'!
with: aLetter
	
	| aCardinalPointSubclass |
	
	aCardinalPointSubclass  := self subclasses detect:  [:subclass | subclass mustBeCreatedFrom: aLetter] 
		
		ifNone: [^self error: 'Invalid letter for a cardinal point'].
	
	^aCardinalPointSubclass new.! !


!CardinalPoint class methodsFor: 'testing' stamp: 'FL 12/2/2020 05:27:35'!
mustBeCreatedFrom: aLetter

	^self subclassResponsibility.! !


!classDefinition: #East category: 'Mars-Rover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!East methodsFor: 'private' stamp: 'FL 12/2/2020 07:08:19'!
moveBackward

	^0@-1! !

!East methodsFor: 'private' stamp: 'FL 12/2/2020 07:08:09'!
moveForward

	^0@1! !

!East methodsFor: 'private' stamp: 'FL 12/2/2020 07:09:14'!
turnLeft

	^North new! !

!East methodsFor: 'private' stamp: 'FL 12/2/2020 07:08:58'!
turnRight

	^South new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'Mars-Rover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'testing' stamp: 'FL 12/2/2020 05:29:00'!
mustBeCreatedFrom: aLetter

	^(aLetter = 'E').! !


!classDefinition: #North category: 'Mars-Rover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!North methodsFor: 'private' stamp: 'FL 12/2/2020 07:04:06'!
moveBackward

	^-1@0! !

!North methodsFor: 'private' stamp: 'FL 12/2/2020 06:41:03'!
moveForward
	
	^1@0.! !

!North methodsFor: 'private' stamp: 'FL 12/2/2020 07:05:59'!
turnLeft
	
	^West new! !

!North methodsFor: 'private' stamp: 'FL 12/2/2020 06:59:49'!
turnRight
	
	^East new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'Mars-Rover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'testing' stamp: 'FL 12/2/2020 05:30:01'!
mustBeCreatedFrom: aLetter

	^(aLetter = 'N').! !


!classDefinition: #South category: 'Mars-Rover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!South methodsFor: 'private' stamp: 'FL 12/2/2020 07:10:23'!
moveBackward

	^1@0! !

!South methodsFor: 'private' stamp: 'FL 12/2/2020 07:10:10'!
moveForward

	^-1@0! !

!South methodsFor: 'private' stamp: 'FL 12/2/2020 07:10:53'!
turnLeft

	^East new! !

!South methodsFor: 'private' stamp: 'FL 12/2/2020 07:10:41'!
turnRight

	^West new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'Mars-Rover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'testing' stamp: 'FL 12/2/2020 05:30:17'!
mustBeCreatedFrom: aLetter

	^(aLetter = 'S').! !


!classDefinition: #West category: 'Mars-Rover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!West methodsFor: 'private' stamp: 'FL 12/2/2020 07:11:54'!
moveBackward

	^0@1! !

!West methodsFor: 'private' stamp: 'FL 12/2/2020 07:12:05'!
moveForward

	^0@-1! !

!West methodsFor: 'private' stamp: 'FL 12/2/2020 07:13:32'!
turnLeft

	^South new! !

!West methodsFor: 'private' stamp: 'FL 12/2/2020 07:12:49'!
turnRight

	^North new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'Mars-Rover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'testing' stamp: 'FL 12/2/2020 05:30:43'!
mustBeCreatedFrom: aLetter

	^(aLetter = 'W').! !


!classDefinition: #MarsRover category: 'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction orientatedPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'FL 12/2/2020 06:31:01'!
initializePositionedAt: aCoordinate lookingAt: aCardinalPoint 
	
	orientatedPosition := OrientatedPosition locatedAt: aCoordinate andLookingAt: (CardinalPoint with: aCardinalPoint) .! !


!MarsRover methodsFor: 'actioning' stamp: 'FL 12/2/2020 17:08:12'!
doThisMovements: sequencyOfCommands 

	| aMovement currentLetter |
	currentLetter := 1.
	[aMovement class ~= NoMove and: (currentLetter <= sequencyOfCommands size)] whileTrue: [
		
		aMovement := Movement for: (sequencyOfCommands at: currentLetter).
		
		currentLetter := currentLetter + 1.
		
		orientatedPosition := aMovement moveFrom: orientatedPosition.	
	
	].
	! !


!MarsRover methodsFor: 'accessing' stamp: 'FL 12/2/2020 06:12:35'!
isLocatedAt: aCoordinate lookingAt: aCardinalPoint 
	
	^orientatedPosition isLocatedAt: aCoordinate lookingAt: aCardinalPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FL 12/2/2020 05:32:04'!
positionedAt: aCoordinate lookingAt: aCardinalPoint 
	
	
	^self new initializePositionedAt: aCoordinate lookingAt: aCardinalPoint ! !


!classDefinition: #Movement category: 'Mars-Rover'!
Object subclass: #Movement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Movement class' category: 'Mars-Rover'!
Movement class
	instanceVariableNames: ''!

!Movement class methodsFor: 'testing' stamp: 'FL 12/2/2020 05:55:51'!
mustBeCreatedFrom: typeOfMovement

	^self subclassResponsibility.! !


!Movement class methodsFor: 'instance creation' stamp: 'FL 12/2/2020 06:55:19'!
for: typeOfMovement
	| aSubclassToCreate |
	
	aSubclassToCreate := self subclasses detect:  [:subclass | subclass mustBeCreatedFrom: typeOfMovement] 
	
	ifNone: [NoMove].
	
	^aSubclassToCreate new.! !


!Movement class methodsFor: 'actioning' stamp: 'FL 12/2/2020 06:23:02'!
moveFrom: anOrientatedPosition 
	
	self subclassResponsibility.! !


!classDefinition: #MoveBackward category: 'Mars-Rover'!
Movement subclass: #MoveBackward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MoveBackward methodsFor: 'actioning' stamp: 'FL 12/2/2020 07:00:46'!
moveFrom: anOrientatedPosition

	^anOrientatedPosition moveBackward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackward class' category: 'Mars-Rover'!
MoveBackward class
	instanceVariableNames: ''!

!MoveBackward class methodsFor: 'testing' stamp: 'FL 12/2/2020 07:55:50'!
mustBeCreatedFrom: typeOfMovement

	^(typeOfMovement = $b).! !


!classDefinition: #MoveForward category: 'Mars-Rover'!
Movement subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MoveForward methodsFor: 'actioning' stamp: 'FL 12/2/2020 06:56:36'!
moveFrom: anOrientatedPosition

	^anOrientatedPosition moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForward class' category: 'Mars-Rover'!
MoveForward class
	instanceVariableNames: ''!

!MoveForward class methodsFor: 'testing' stamp: 'FL 12/2/2020 07:56:03'!
mustBeCreatedFrom: typeOfMovement

	^(typeOfMovement = $f).! !


!classDefinition: #NoMove category: 'Mars-Rover'!
Movement subclass: #NoMove
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!NoMove methodsFor: 'as yet unclassified' stamp: 'FL 12/2/2020 06:37:04'!
moveFrom: anOrientatedPosition

	^anOrientatedPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoMove class' category: 'Mars-Rover'!
NoMove class
	instanceVariableNames: ''!

!NoMove class methodsFor: 'testing' stamp: 'FL 12/2/2020 06:18:35'!
mustBeCreatedFrom: typeOfMovement

	^false! !


!classDefinition: #TurnLeft category: 'Mars-Rover'!
Movement subclass: #TurnLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!TurnLeft methodsFor: 'actioning' stamp: 'FL 12/2/2020 07:15:45'!
moveFrom: anOrientatedPosition

	^anOrientatedPosition turnLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnLeft class' category: 'Mars-Rover'!
TurnLeft class
	instanceVariableNames: ''!

!TurnLeft class methodsFor: 'testing' stamp: 'FL 12/2/2020 07:56:19'!
mustBeCreatedFrom: typeOfMovement

	^(typeOfMovement = $l).! !


!classDefinition: #TurnRight category: 'Mars-Rover'!
Movement subclass: #TurnRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!TurnRight methodsFor: 'actioning' stamp: 'FL 12/2/2020 06:57:33'!
moveFrom: anOrientatedPosition 

	^anOrientatedPosition turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnRight class' category: 'Mars-Rover'!
TurnRight class
	instanceVariableNames: ''!

!TurnRight class methodsFor: 'testing' stamp: 'FL 12/2/2020 07:56:32'!
mustBeCreatedFrom: typeOfMovement

	^(typeOfMovement = $r).! !


!classDefinition: #OrientatedPosition category: 'Mars-Rover'!
Object subclass: #OrientatedPosition
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!OrientatedPosition methodsFor: 'initialization' stamp: 'FL 12/2/2020 06:08:55'!
initializeLocatedAt: aPosition andLookingAt: aDirection

	position := aPosition.
	direction := aDirection.! !


!OrientatedPosition methodsFor: 'testing' stamp: 'FL 12/2/2020 06:38:35'!
isLocatedAt: aPosition lookingAt: aDirection

	^(position = aPosition) and: (direction isKindOf: aDirection)! !


!OrientatedPosition methodsFor: 'private' stamp: 'FL 12/2/2020 07:41:51'!
moveBackward

	^OrientatedPosition locatedAt: position + direction moveBackward 
					
		andLookingAt: direction.! !

!OrientatedPosition methodsFor: 'private' stamp: 'FL 12/2/2020 07:42:02'!
moveForward
	
	^OrientatedPosition locatedAt:  position + direction moveForward 
		
		andLookingAt: direction.! !

!OrientatedPosition methodsFor: 'private' stamp: 'FL 12/2/2020 07:42:12'!
turnLeft
	
	^OrientatedPosition locatedAt:  position 
	
		andLookingAt: direction turnLeft.! !

!OrientatedPosition methodsFor: 'private' stamp: 'FL 12/2/2020 07:42:19'!
turnRight
	
	^OrientatedPosition locatedAt:  position 
	
		andLookingAt: direction turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrientatedPosition class' category: 'Mars-Rover'!
OrientatedPosition class
	instanceVariableNames: ''!

!OrientatedPosition class methodsFor: 'instance creation' stamp: 'FL 12/2/2020 06:07:48'!
locatedAt: aPosition andLookingAt: aDirection

	^self new initializeLocatedAt: aPosition andLookingAt: aDirection! !


!OrientatedPosition class methodsFor: 'private' stamp: 'FL 12/2/2020 06:49:51'!
isLocatedAt: aPoint lookingAt: aClass 
	self shouldBeImplemented.! !


!OrientatedPosition class methodsFor: 'error handling' stamp: 'FL 12/2/2020 06:51:04'!
error: aString 
	self shouldBeImplemented.! !
