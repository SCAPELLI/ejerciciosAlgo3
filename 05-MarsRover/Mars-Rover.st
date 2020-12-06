!classDefinition: #MarsRoverTest category: 'Mars-Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 21:11:24'!
test01AnEmptyMoveSequencyWillNoChangePositionOrDirection

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #N.
	
	aRover doTheseMovements: ''.
	
	self assert: (aRover isLocatedAt: 0@0).
	self assert: (aRover isLookingAt: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 21:13:41'!
test02ANotEmptyMoveSequencyShouldChangePosition

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #N.
	
	aRover doTheseMovements: 'f'.
	
	self deny: (aRover isLocatedAt: 0@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 21:16:51'!
test03TheRoverCanHandleMoreThanOneMoveAtOneTime

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #N.
	
	aRover doTheseMovements: 'ff'.
	
	self assert: (aRover isLocatedAt: 2@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 21:19:26'!
test04TheRoverCanDoDifferentMovements

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #N.
	
	aRover doTheseMovements: 'b'.
	
	self assert: (aRover isLocatedAt: -1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 23:01:24'!
test05MoveForwardDependsOfTheRoverDirection
	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #E.
	
	aRover doTheseMovements: 'f'.
	
	self assert: (aRover isLocatedAt: 0@1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 23:01:10'!
test06TheRoverCanMoveBackward
	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #E.
	
	aRover doTheseMovements: 'b'.
	
	self assert: (aRover isLocatedAt: 0@-1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 23:00:50'!
test07TurnRightChangesTheRoverDirection

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #E.
	
	aRover doTheseMovements: 'r'.
	
	self deny: (aRover isLookingAt: #E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 23:00:41'!
test08TurnRightDependsOfTheRoverDirection

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #E.
	
	aRover doTheseMovements: 'r'.
	
	self assert: (aRover isLookingAt: #S).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 23:00:28'!
test09TheRoverCanTurnLeft

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #E.
	
	aRover doTheseMovements: 'l'.
	
	self assert: (aRover isLookingAt: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FL 12/5/2020 23:40:51'!
test10TheRoverStopMovingWithAnInvalidMovementRequest

	| aRover |
	
	aRover := MarsRover locatedAt: 0@0 lookingAt: #E.
	
	aRover doTheseMovements: 'lllkrrr'.
	
	self assert: (aRover isLookingAt: #S).! !


!classDefinition: #MarsRover category: 'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position cardinalDirection positionIncrement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'FL 12/5/2020 22:14:41'!
initializeLocatedAt: aPosition lookingAt: aCardinalDirection 
	
	position := aPosition.
	cardinalDirection := aCardinalDirection.
	
	positionIncrement := Dictionary new.
	
	positionIncrement at: #N put: 1@0.
	positionIncrement at: #S put: -1@0.
	positionIncrement at: #E put: 0@1.
	positionIncrement at: #O put: 0@-1.! !


!MarsRover methodsFor: 'actions' stamp: 'FL 12/5/2020 22:51:02'!
decrementDirection
	
	3 timesRepeat: [self incrementDirection].! !

!MarsRover methodsFor: 'actions' stamp: 'FL 12/5/2020 23:37:55'!
doTheseMovements: moveSequency 
	
	| invalidMovementPosition |
	
	invalidMovementPosition := moveSequency findFirst: [:aMovement |		self isAnInvalidMovement: aMovement	].
	
	(invalidMovementPosition = 0) ifTrue: [invalidMovementPosition := moveSequency size].
	
	(moveSequency copyFrom: 1 to: invalidMovementPosition) do: [:aMovement | 
		
		aMovement = $f ifTrue: [self moveForward].	
		aMovement = $b ifTrue: [ self moveBackward ].	
		aMovement = $r ifTrue: [ self incrementDirection].
		aMovement = $l ifTrue: [ self decrementDirection].
	].! !

!MarsRover methodsFor: 'actions' stamp: 'FL 12/5/2020 22:50:17'!
incrementDirection
	
	| newCardinalDirection |
	cardinalDirection = #N ifTrue: [newCardinalDirection := #E].
	cardinalDirection = #S ifTrue: [newCardinalDirection := #O].
	cardinalDirection = #E ifTrue: [newCardinalDirection := #S].
	cardinalDirection = #O ifTrue: [newCardinalDirection := #N].
	
	cardinalDirection := newCardinalDirection.! !

!MarsRover methodsFor: 'actions' stamp: 'FL 12/5/2020 22:15:10'!
moveBackward
	
	position _ position - positionIncrement at: cardinalDirection.! !

!MarsRover methodsFor: 'actions' stamp: 'FL 12/5/2020 22:15:26'!
moveForward

	position _ position + positionIncrement at: cardinalDirection.! !


!MarsRover methodsFor: 'testing' stamp: 'FL 12/5/2020 23:32:15'!
isAnInvalidMovement: aMovement
	
	| isInvalid |
	
	isInvalid := true.
	
	aMovement = $f ifTrue: [isInvalid := false].
	aMovement = $b ifTrue: [isInvalid := false].
	aMovement = $r ifTrue: [isInvalid := false].
	aMovement = $l ifTrue: [isInvalid := false].
	
	^isInvalid.! !

!MarsRover methodsFor: 'testing' stamp: 'FL 12/5/2020 20:53:41'!
isLocatedAt: aPosition 
	
	^position = aPosition.! !

!MarsRover methodsFor: 'testing' stamp: 'FL 12/5/2020 22:20:54'!
isLookingAt: aCardinalDirection 
	
	^aCardinalDirection = cardinalDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FL 12/5/2020 20:43:47'!
locatedAt: aPosition lookingAt: aCardinalDirection 

	^self new initializeLocatedAt: aPosition lookingAt: aCardinalDirection! !
