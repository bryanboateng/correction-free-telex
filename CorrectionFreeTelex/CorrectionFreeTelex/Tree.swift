struct Node {
	let character: Character
	let mapping: String
	let children: [Node]
}

let rootNodes = [
	Node(
		character: "a",
		mapping: "a",
		children: [
			Node(
				character: "a",
				mapping: "â",
				children: [
					Node(
						character: "a",
						mapping: "aa",
						children: []
					)
				]
			),
			Node(
				character: "w",
				mapping: "ă",
				children: [
					Node(
						character: "w",
						mapping: "aw",
						children: []
					)
				]
			),
		]
	),
	Node(
		character: "d",
		mapping: "d",
		children: [
			Node(
				character: "d",
				mapping: "đ",
				children: [
					Node(
						character: "d",
						mapping: "dd",
						children: []
					)
				]
			)
		]
	),
	Node(
		character: "e",
		mapping: "e",
		children: [
			Node(
				character: "e",
				mapping: "ê",
				children: [
					Node(
						character: "e",
						mapping: "ee",
						children: []
					)
				]
			)
		]
	),
	Node(
		character: "o",
		mapping: "o",
		children: [
			Node(
				character: "o",
				mapping: "ô",
				children: [
					Node(
						character: "o",
						mapping: "oo",
						children: []
					)
				]
			),
			Node(
				character: "w",
				mapping: "ơ",
				children: [
					Node(
						character: "w",
						mapping: "ow",
						children: []
					)
				]
			)
		]
	),
	Node(
		character: "u",
		mapping: "u",
		children: [
			Node(
				character: "w",
				mapping: "ư",
				children: [
					Node(
						character: "w",
						mapping: "uw",
						children: []
					)
				]
			)
		]
	)
]

