Class {
	#name : #TestGetUserFromCommit,
	#superclass : #TestCase,
	#instVars : [
		'repository',
		'firstCommit'
	],
	#category : #Risk
}

{ #category : #running }
TestGetUserFromCommit >> runCaseManaged [ 
	^ self runCase
]

{ #category : #running }
TestGetUserFromCommit >> setUp [
	super setUp.
	repository := IceRepository registry detect: [ : r | r name = #pharo ].
	firstCommit := repository lookupCommit: 'b882595'.
	
]

{ #category : #running }
TestGetUserFromCommit >> testACommitInrRelationToItSelfHoldsNoAuthors [
	| tracker walker |
	tracker := RSKAuthorTracker new.
	walker := firstCommit newCommitWalk uptoCommit: firstCommit.
	tracker trackDown: walker.
	self assert: tracker analyzedCommits equals: 0.
	self assert: tracker authors isEmpty
]

{ #category : #running }
TestGetUserFromCommit >> testCommitsFrom_b882595_To_d5894f9 [
	| tracker walker |
	tracker := RSKAuthorTracker new.
	walker := firstCommit newCommitWalk
		uptoCommit: (repository lookupCommit: 'd5894f9').
	tracker trackDown: walker.
	self
		assert: tracker authors
		equals: #('Esteban Lorenzano' 'guillermo polito') asSet.
	self assert: tracker classes size equals: 1.
	self assert: tracker classes anyOne methods size equals: 1.
	self assert: tracker classes anyOne name equals: #BaselineOfIDE.
	self
		assert: tracker classes anyOne methods anyOne name
		equals: #loadIceberg
]

{ #category : #running }
TestGetUserFromCommit >> testCommitsFrom_b882595_To_e9c57ad [
	| tracker walker |
	tracker := RSKAuthorTracker new.
	walker := firstCommit newCommitWalk
		uptoCommit: (repository lookupCommit: 'e9c57ad').
	tracker trackDown: walker.
	self
		assert: tracker authors
		equals:
			#('StéphaneDucasse' 'Denis Kudriashov' 'Esteban Lorenzano' 'Sébastien Roccaserra' 'guillermo polito' 'Gabriel Omar Cotelli' 'Marcus Denker' 'Stephan Eggermont' 'pavel-krivanek' 'Julien Delplanque' 'Serge Stinckwich' 'Guille Polito' 'Pavel Krivanek' 'CyrilFerlicot' 'Pablo Tesone' 'dupriezt')
				asSet
]
