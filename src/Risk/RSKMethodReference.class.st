Class {
	#name : #RSKMethodReference,
	#superclass : #Object,
	#instVars : [
		'name',
		'classIsMeta',
		'contributions'
	],
	#category : #Risk
}

{ #category : #accessing }
RSKMethodReference >> = anOtherMethod [
	^ self class = anOtherMethod class
		and: [ name = anOtherMethod name
				and: [ classIsMeta = anOtherMethod classIsMeta ] ]
]

{ #category : #adding }
RSKMethodReference >> addContribution: aContribution [
	contributions add: aContribution.
	^ aContribution
]

{ #category : #accessing }
RSKMethodReference >> authors [
	^ (contributions collect: #author) 
]

{ #category : #accessing }
RSKMethodReference >> classIsMeta [
	^ classIsMeta
]

{ #category : #accessing }
RSKMethodReference >> classIsMeta: anObject [
	classIsMeta := anObject
]

{ #category : #accessing }
RSKMethodReference >> contributions [
	^ contributions
]

{ #category : #accessing }
RSKMethodReference >> hash [
	^ (self class hash bitXor: name hash) bitXor: classIsMeta hash
]

{ #category : #initialization }
RSKMethodReference >> initialize [
	super initialize.
	contributions := Set new
]

{ #category : #accessing }
RSKMethodReference >> name [
	^ name
]

{ #category : #accessing }
RSKMethodReference >> name: anObject [
	name := anObject
]

{ #category : #initialization }
RSKMethodReference >> printOn: aStream [
	aStream
		nextPutAll: 'RSM(';
		nextPutAll: name;
		nextPutAll: ')'
]
