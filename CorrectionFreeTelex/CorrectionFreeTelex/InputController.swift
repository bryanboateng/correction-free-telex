import Cocoa
import InputMethodKit

@objc(InputController)
class InputController: IMKInputController {

	private var currentNode: Node?
	private let noRange = NSRange(location: NSNotFound, length: NSNotFound)

	override func handle(_ event: NSEvent!, client sender: Any!) -> Bool {
		guard let textInputClient = sender as? IMKTextInput else {
			return false
		}

		switch translateToKeyEvent(event) {
		case .character(let newCharacter):
			if let nextNode = nextNode(matching: newCharacter) {
				commitNodeIfLeafElseMark(nextNode, using: textInputClient)
				return true
			} else {

				if let currentNode = self.currentNode {
					commit(currentNode, using: textInputClient)
				}
				if let nextNode = nextNode(matching: newCharacter) {
					commitNodeIfLeafElseMark(nextNode, using: textInputClient)
					return true
				}
			}

		case .delete:
			if currentNode != nil {
				currentNode = nil
				textInputClient.setMarkedText(
					"",
					selectionRange: noRange,
					replacementRange: noRange
				)
				return true
			}

		case .unknown:
			if let currentNode = self.currentNode {
				commit(currentNode, using: textInputClient)
				return true
			}

		}
		return false
	}

	private func translateToKeyEvent(_ event: NSEvent) -> KeyEvent {
		if event.keyCode == 51 {
			return .delete
		} else if
			let characters = event.characters,
			isPrintable(characters),
			let firstCharacter = characters.first
		{
			return .character(firstCharacter)
		} else {
			return .unknown
		}
	}

	private func isPrintable(_ text: String) -> Bool {
		let printable: CharacterSet = [
			CharacterSet.alphanumerics,
			CharacterSet.symbols,
			CharacterSet.punctuationCharacters,
		].reduce(CharacterSet()) { $0.union($1) }

		return !text.unicodeScalars.contains { !printable.contains($0) }
	}

	private func nextNode(matching targetCharacter: Character) -> Node? {
		let searchSpace = self.currentNode?.children ?? rootNodes
		return searchSpace.first { node in
			node.character == targetCharacter
		}
	}

	private func commitNodeIfLeafElseMark(
		_ node: Node,
		using textInputClient: IMKTextInput
	) {
		if node.children.isEmpty {
			commit(node, using: textInputClient)
		} else {
			textInputClient.setMarkedText(
				node.mapping,
				selectionRange: noRange,
				replacementRange: noRange
			)
			currentNode = node
		}
	}

	private func commit(_ node: Node, using textInputClient: IMKTextInput) {
		textInputClient.setMarkedText(
			"",
			selectionRange: self.noRange,
			replacementRange: self.noRange
		)
		textInputClient.insertText(node.mapping, replacementRange: self.noRange)
		self.currentNode = nil
	}
}

fileprivate enum KeyEvent {
	case character(Character)
	case delete
	case unknown
}
