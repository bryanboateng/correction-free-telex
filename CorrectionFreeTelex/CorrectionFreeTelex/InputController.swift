import Cocoa
import InputMethodKit

@objc(InputController)
class InputController: IMKInputController {

	private var currentState: String?

	override func handle(_ event: NSEvent!, client sender: Any!) -> Bool {
		guard let textInputClient = sender as? IMKTextInput else {
			return false
		}

		guard let newCharacter = self.firstPrintableCharacter(in: event) else {
			self.currentState = nil
			return false
		}

		if let nextState = self.nextState(matching: newCharacter) {
			self.currentState = nextState

			if entryStates.contains(nextState) {
				self.insert(nextState, into: textInputClient)
			} else {
				self.replaceText(nextState, textInputClient: textInputClient)
			}
			return true
		} else {
			self.currentState = nil

			if let nextState = self.nextState(matching: newCharacter) {
				self.currentState = nextState
				self.insert(nextState, into: textInputClient)
				return true
			} else {
				return false
			}
		}
	}

	private func firstPrintableCharacter(in event: NSEvent) -> Character? {
		if
			let characters = event.characters,
			self.isPrintable(characters),
			let firstCharacter = characters.first
		{
			return firstCharacter
		} else {
			return nil
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
			if entryStates.contains(targetCharacter) {
				return String(targetCharacter)
			} else {
				return nil
			}
		}
	}

	private func insert(_ text: String, into textInputClient: IMKTextInput) {
		textInputClient.insertText(text, replacementRange: replacementRange())
	}

	private func replaceText(_ text: String, textInputClient: IMKTextInput) {
		let selectedRange = textInputClient.selectedRange()

		if selectedRange != NSRange(location: NSNotFound, length: NSNotFound) && selectedRange.location > 0 {
			let replacementLength = selectedRange.length == 0 ? 1 : selectedRange.length + 1
			let replacementRange = NSRange(location: selectedRange.location - 1, length: replacementLength)
			textInputClient.insertText(text, replacementRange: replacementRange)
		} else {
			textInputClient.insertText(text, replacementRange: replacementRange())
		}
	}
}
