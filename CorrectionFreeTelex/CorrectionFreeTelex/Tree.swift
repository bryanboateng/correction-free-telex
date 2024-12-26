struct Node {
	let mapping: String
	let children: [Character: Node]
}

let rootNodes: [Character: Node] = [
	"a": Node(
		mapping: "a",
		children: [
			"a": Node(
				mapping: "â",
				children: [
					"a": Node(
						mapping: "aa",
						children: [:]
					)
				]
			),
			"w": Node(
				mapping: "ă",
				children: [
					"w": Node(
						mapping: "aw",
						children: [:]
					)
				]
			),
		]
	),
	"d": Node(
		mapping: "d",
		children: [
			"d": Node(
				mapping: "đ",
				children: [
					"d": Node(
						mapping: "dd",
						children: [:]
					)
				]
			)
		]
	),
	"e": Node(
		mapping: "e",
		children: [
			"e": Node(
				mapping: "ê",
				children: [
					"e": Node(
						mapping: "ee",
						children: [:]
					)
				]
			)
		]
	),
	"o": Node(
		mapping: "o",
		children: [
			"o": Node(
				mapping: "ô",
				children: [
					"o": Node(
						mapping: "oo",
						children: [:]
					)
				]
			),
			"w": Node(
				mapping: "ơ",
				children: [
					"w": Node(
						mapping: "ow",
						children: [:]
					)
				]
			)
		]
	),
	"u": Node(
		mapping: "u",
		children: [
			"w": Node(
				mapping: "ư",
				children: [
					"w": Node(
						mapping: "uw",
						children: [:]
					)
				]
			)
		]
	)
]

