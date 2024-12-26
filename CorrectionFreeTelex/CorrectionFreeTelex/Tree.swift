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
					),
					"f": Node(mapping: "ầ", children: [:]),
					"s": Node(mapping: "ấ", children: [:]),
					"r": Node(mapping: "ẩ", children: [:]),
					"x": Node(mapping: "ẫ", children: [:]),
					"j": Node(mapping: "ậ", children: [:]),
				]
			),
			"w": Node(
				mapping: "ă",
				children: [
					"w": Node(
						mapping: "aw",
						children: [:]
					),
					"f": Node(mapping: "ằ", children: [:]),
					"s": Node(mapping: "ắ", children: [:]),
					"r": Node(mapping: "ẳ", children: [:]),
					"x": Node(mapping: "ẵ", children: [:]),
					"j": Node(mapping: "ặ", children: [:]),
				]
			),
			"f": Node(mapping: "à", children: [:]),
			"s": Node(mapping: "á", children: [:]),
			"r": Node(mapping: "ả", children: [:]),
			"x": Node(mapping: "ã", children: [:]),
			"j": Node(mapping: "ạ", children: [:]),
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
					),
					"f": Node(mapping: "ề", children: [:]),
					"s": Node(mapping: "ế", children: [:]),
					"r": Node(mapping: "ể", children: [:]),
					"x": Node(mapping: "ễ", children: [:]),
					"j": Node(mapping: "ệ", children: [:]),
				]
			),
			"f": Node(mapping: "è", children: [:]),
			"s": Node(mapping: "é", children: [:]),
			"r": Node(mapping: "ẻ", children: [:]),
			"x": Node(mapping: "ẽ", children: [:]),
			"j": Node(mapping: "ẹ", children: [:]),
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
					),
					"f": Node(mapping: "ồ", children: [:]),
					"s": Node(mapping: "ố", children: [:]),
					"r": Node(mapping: "ổ", children: [:]),
					"x": Node(mapping: "ỗ", children: [:]),
					"j": Node(mapping: "ộ", children: [:]),
				]
			),
			"w": Node(
				mapping: "ơ",
				children: [
					"w": Node(
						mapping: "ow",
						children: [:]
					),
					"f": Node(mapping: "ờ", children: [:]),
					"s": Node(mapping: "ớ", children: [:]),
					"r": Node(mapping: "ở", children: [:]),
					"x": Node(mapping: "ỡ", children: [:]),
					"j": Node(mapping: "ợ", children: [:]),
				]
			),
			"f": Node(mapping: "ò", children: [:]),
			"s": Node(mapping: "ó", children: [:]),
			"r": Node(mapping: "ỏ", children: [:]),
			"x": Node(mapping: "õ", children: [:]),
			"j": Node(mapping: "ọ", children: [:]),
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
					),
					"f": Node(mapping: "ừ", children: [:]),
					"s": Node(mapping: "ứ", children: [:]),
					"r": Node(mapping: "ử", children: [:]),
					"x": Node(mapping: "ữ", children: [:]),
					"j": Node(mapping: "ự", children: [:]),
				]
			),
			"f": Node(mapping: "ù", children: [:]),
			"s": Node(mapping: "ú", children: [:]),
			"r": Node(mapping: "ủ", children: [:]),
			"x": Node(mapping: "ũ", children: [:]),
			"j": Node(mapping: "ụ", children: [:]),
		]
	)
]

