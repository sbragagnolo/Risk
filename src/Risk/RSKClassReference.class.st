Class {
	#name : #RSKClassReference,
	#superclass : #Object,
	#instVars : [
		'name',
		'methods',
		'contributions'
	],
	#category : #Risk
}

{ #category : #initialization }
RSKClassReference >> = anOtherClass [
	^ self == anOtherClass
		or: [ anOtherClass class = self class
				and: [ self name = anOtherClass name ] ]
]

{ #category : #initialization }
RSKClassReference >> addContribution: aContribution [
	contributions add: aContribution.
	^ aContribution
]

{ #category : #initialization }
RSKClassReference >> allAuthors [
	^ self authors , self methodAuthors
]

{ #category : #initialization }
RSKClassReference >> allContributions [ 
	^ self contributions, methods flatCollect: #contributions 
]

{ #category : #initialization }
RSKClassReference >> authors [
	^ (contributions collect: #author) asSet
]

{ #category : #initialization }
RSKClassReference >> contributions [ 
	^ contributions 
]

{ #category : #initialization }
RSKClassReference >> hash [
	^ name hash
]

{ #category : #initialization }
RSKClassReference >> initialize [
	super initialize.
	contributions := Set new.
	methods := OrderedCollection new
]

{ #category : #initialization }
RSKClassReference >> methodAuthors [
	^ methods flatCollect: #authors
]

{ #category : #initialization }
RSKClassReference >> methodNamed: aName meta: isMetaClass [
	^ methods
		detect: [ :m | m name = aName and: [ m classIsMeta = isMetaClass ] ]
		ifNone: [ | newMethodReference |
			newMethodReference := RSKMethodReference new
				name: aName;
				classIsMeta: isMetaClass;
				yourself.
			methods add: newMethodReference.
			newMethodReference ]
]

{ #category : #accessing }
RSKClassReference >> methods [
	^ methods
]

{ #category : #accessing }
RSKClassReference >> name [
	^ name
]

{ #category : #accessing }
RSKClassReference >> name: anObject [
	name := anObject
]

{ #category : #accessing }
RSKClassReference >> printOn: aStream [
	aStream
		nextPutAll: 'RSK(';
		nextPutAll: name;
		nextPutAll: ')'
]
