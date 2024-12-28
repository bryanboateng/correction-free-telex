import Cocoa
import InputMethodKit

@objc(InputController)
class InputController: IMKInputController {

	private var currentState: String?
	private let noRange = NSRange(location: NSNotFound, length: NSNotFound)

	override func handle(_ event: NSEvent!, client sender: Any!) -> Bool {
		guard let textInputClient = sender as? IMKTextInput else {
			return false
		}

		switch translateToKeyEvent(event) {
		case .character(let newCharacter):
			if let nextState = self.nextState(matching: newCharacter) {
				self.commitStateIfLeafElseMark(nextState, using: textInputClient)
				return true
			} else {

				if let currentState = self.currentState {
					self.commit(currentState, using: textInputClient)
				}
				if let nextState = self.nextState(matching: newCharacter) {
					self.commitStateIfLeafElseMark(nextState, using: textInputClient)
					return true
				}
			}

		case .delete:
			if self.currentState != nil {
				self.currentState = nil
				textInputClient.setMarkedText(
					"",
					selectionRange: self.noRange,
					replacementRange: self.noRange
				)
				return true
			}

		case .unknown:
			if let currentState = self.currentState {
				self.commit(currentState, using: textInputClient)
			}

		}
		return false
	}

	private func translateToKeyEvent(_ event: NSEvent) -> KeyEvent {
		if event.keyCode == 51 {
			return .delete
		} else if
			let characters = event.characters,
			self.isPrintable(characters),
			let firstCharacter = characters.first
		{
			return .character(firstCharacter)
		} else {
			return .unknown
		}
	}

	private func isPrintable(_ text: String) -> Bool {
		let printable: CharacterSet = [
			.alphanumerics,
			.symbols,
			.punctuationCharacters,
		].reduce(CharacterSet()) { $0.union($1) }

		return !text.unicodeScalars.contains { !printable.contains($0) }
	}

	private func nextState(matching targetCharacter: Character) -> String? {
		if let currentState = self.currentState {
			return transitions[currentState]?[targetCharacter]
		} else {
			if rootStates.contains(targetCharacter) {
				return String(targetCharacter)
			} else {
				return nil
			}
		}
	}

	private func commitStateIfLeafElseMark(
		_ state: String,
		using textInputClient: IMKTextInput
	) {
		if transitions[state] == nil {
			self.commit(state, using: textInputClient)
		} else {
			textInputClient.setMarkedText(
				state,
				selectionRange: self.noRange,
				replacementRange: self.noRange
			)
			self.currentState = state
		}
	}

	private func commit(_ state: String, using textInputClient: IMKTextInput) {
		textInputClient.setMarkedText(
			"",
			selectionRange: self.noRange,
			replacementRange: self.noRange
		)
		textInputClient.insertText(state, replacementRange: self.noRange)
		self.currentState = nil
	}
}

fileprivate enum KeyEvent {
	case character(Character)
	case delete
	case unknown
}
