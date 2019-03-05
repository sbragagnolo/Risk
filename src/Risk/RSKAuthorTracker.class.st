Class {
	#name : #RSKAuthorTracker,
	#superclass : #IceTreeVisitor,
	#instVars : [
		'analyzedCommits',
		'classes',
		'commit',
		'currentContribution',
		'errors'
	],
	#category : #Risk
}

{ #category : #tracking }
RSKAuthorTracker >> analyzedCommits [
	^ analyzedCommits
]

{ #category : #accessing }
RSKAuthorTracker >> authors [
	^ (classes flatCollect: #allAuthors) asSet
]

{ #category : #visiting }
RSKAuthorTracker >> classNamed: aName [
	^ classes
		detect: [ :c | c name = aName ]
		ifNone: [ | newClassReference |
			newClassReference := RSKClassReference new
				name: aName;
				yourself.
			classes add: newClassReference.
			newClassReference ]
]

{ #category : #accessing }
RSKAuthorTracker >> classes [
	^ classes
]

{ #category : #visiting }
RSKAuthorTracker >> currentContribution [
	^ currentContribution 
]

{ #category : #accessing }
RSKAuthorTracker >> initialize [
	super initialize.
	analyzedCommits := 0.
	classes := OrderedCollection new.
	errors := OrderedCollection new
]

{ #category : #tracking }
RSKAuthorTracker >> loopOnceOn: next [
	analyzedCommits := analyzedCommits + 1.
	commit := next.
	currentContribution := RSKContribution new
		author: commit author;
		commitish: commit id.
	[ (commit diffTo: commit parent) accept: self ]
		on: Error
		do: [ :err | errors add: (currentContribution -> err )]
]

{ #category : #tracking }
RSKAuthorTracker >> registerDefinition: aDefinition [ 
	self shouldBeImplemented.
]

{ #category : #tracking }
RSKAuthorTracker >> trackDown: anIceLibgitCommitWalk [
	[ anIceLibgitCommitWalk hasNext ]
		whileTrue: [ self loopOnceOn: anIceLibgitCommitWalk next ]
]

{ #category : #visiting }
RSKAuthorTracker >> visitAddition: anIceAddition [
	currentContribution kind: #addition.
	anIceAddition definition accept: self.
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
RSKAuthorTracker >> visitClassDefinition: anIceClassDefinition [
	(self classNamed: anIceClassDefinition name)
		addContribution:  self currentContribution
]

{ #category : #visiting }
RSKAuthorTracker >> visitDirectoryDefinition: anIceDirectoryDefinition [ 
 " Nothing to do "
]

{ #category : #visiting }
RSKAuthorTracker >> visitExtensionDefinition: anIceExtensionDefinition [ 
	" "
]

{ #category : #visiting }
RSKAuthorTracker >> visitFileNode: anIceFileDefinition [ 
	" Nothing to doo "
]

{ #category : #visiting }
RSKAuthorTracker >> visitMethodNode: anIceMethodDefinition [
	((self classNamed: anIceMethodDefinition className)
		methodNamed: anIceMethodDefinition name
		meta: anIceMethodDefinition classIsMeta)
		addContribution: self currentContribution
]

{ #category : #visiting }
RSKAuthorTracker >> visitModification: anIceModification [
	currentContribution kind: #modification.
	anIceModification definition accept: self.
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
RSKAuthorTracker >> visitNoModification: anIceNoModification [ 
	self visitChildrenOf: currentNode 
]

{ #category : #visiting }
RSKAuthorTracker >> visitPackage: anIcePackageDefinition [
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
RSKAuthorTracker >> visitRemoval: anIceRemoval [
	currentContribution kind: #remove.
	anIceRemoval definition accept: self.
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
RSKAuthorTracker >> visitTraitDefinition: anIceTraitDefinition [
	self visitClassDefinition: anIceTraitDefinition
]
