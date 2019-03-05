Class {
	#name : #RiskManifest,
	#superclass : #PackageManifest,
	#classInstVars : [
		'tracker'
	],
	#category : #Risk
}

{ #category : #'as yet unclassified' }
RiskManifest class >> analyzePharo [
	| repository latestCommit earliestCommit walker |
	repository := IceRepository registry detect: [ :r | r name = #pharo ].
	latestCommit := repository lookupCommit: 'b882595'.
	earliestCommit := repository lookupCommit: 'bef708e'.
	walker := latestCommit newCommitWalk uptoCommit: earliestCommit.
	tracker := RSKAuthorTracker new.
	tracker trackDown: walker.
	tracker authors size
]
