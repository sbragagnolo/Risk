Class {
	#name : #RSKContribution,
	#superclass : #Object,
	#instVars : [
		'author',
		'commitish',
		'kind'
	],
	#category : #Risk
}

{ #category : #accessing }
RSKContribution >> author [
	^ author
]

{ #category : #accessing }
RSKContribution >> author: anObject [
	author := anObject
]

{ #category : #accessing }
RSKContribution >> commitish [
	^ commitish
]

{ #category : #accessing }
RSKContribution >> commitish: anObject [
	commitish := anObject
]

{ #category : #accessing }
RSKContribution >> kind [
	^ kind
]

{ #category : #accessing }
RSKContribution >> kind: anObject [
	kind := anObject
]
