import Algorithms
import NonEmpty

private struct Vowel {
	let ngangTone: Character
	let huyềnTone: Character
	let sắcTone: Character
	let hỏiTone: Character
	let ngãTone: Character
	let nặngTone: Character

	static let toneKeyPaths: [KeyPath<Self, Character>] = [
		\.ngangTone, \.huyềnTone, \.sắcTone, \.hỏiTone, \.ngãTone, \.nặngTone
	]
}

let entryStates: Set<Character> = ["a", "A", "d", "D", "e", "E", "i", "I", "o", "O", "u", "U", "y", "Y"]

let transitions: [String: NonEmpty<[Character: String]>] = {
	var transitions: [String: NonEmpty<[Character: String]>] = [:]

	let a = Vowel(ngangTone: "a", huyềnTone: "à", sắcTone: "á", hỏiTone: "ả", ngãTone: "ã", nặngTone: "ạ")
	let â = Vowel(ngangTone: "â", huyềnTone: "ầ", sắcTone: "ấ", hỏiTone: "ẩ", ngãTone: "ẫ", nặngTone: "ậ")
	let ă = Vowel(ngangTone: "ă", huyềnTone: "ằ", sắcTone: "ắ", hỏiTone: "ẳ", ngãTone: "ẵ", nặngTone: "ặ")
	let e = Vowel(ngangTone: "e", huyềnTone: "è", sắcTone: "é", hỏiTone: "ẻ", ngãTone: "ẽ", nặngTone: "ẹ")
	let ê = Vowel(ngangTone: "ê", huyềnTone: "ề", sắcTone: "ế", hỏiTone: "ể", ngãTone: "ễ", nặngTone: "ệ")
	let i = Vowel(ngangTone: "i", huyềnTone: "ì", sắcTone: "í", hỏiTone: "ỉ", ngãTone: "ĩ", nặngTone: "ị")
	let o = Vowel(ngangTone: "o", huyềnTone: "ò", sắcTone: "ó", hỏiTone: "ỏ", ngãTone: "õ", nặngTone: "ọ")
	let ô = Vowel(ngangTone: "ô", huyềnTone: "ồ", sắcTone: "ố", hỏiTone: "ổ", ngãTone: "ỗ", nặngTone: "ộ")
	let ơ = Vowel(ngangTone: "ơ", huyềnTone: "ờ", sắcTone: "ớ", hỏiTone: "ở", ngãTone: "ỡ", nặngTone: "ợ")
	let u = Vowel(ngangTone: "u", huyềnTone: "ù", sắcTone: "ú", hỏiTone: "ủ", ngãTone: "ũ", nặngTone: "ụ")
	let ư = Vowel(ngangTone: "ư", huyềnTone: "ừ", sắcTone: "ứ", hỏiTone: "ử", ngãTone: "ữ", nặngTone: "ự")
	let y = Vowel(ngangTone: "y", huyềnTone: "ỳ", sắcTone: "ý", hỏiTone: "ỷ", ngãTone: "ỹ", nặngTone: "ỵ")

	insertVowelTransitions(from: a, to: â, using: "a", into: &transitions)
	insertDecompositionTransitions(for: â, resettingTo: a, and: "a", into: &transitions)
	insertVowelTransitions(from: a, to: ă, using: "w", into: &transitions)
	insertDecompositionTransitions(for: ă, resettingTo: a, and: "w", into: &transitions)

	insertVowelTransitions(from: â, to: ă, using: "w", into: &transitions)
	insertVowelTransitions(from: ă, to: â, using: "a", into: &transitions)

	insertVowelTransitions(from: e, to: ê, using: "e", into: &transitions)
	insertDecompositionTransitions(for: ê, resettingTo: e, and: "e", into: &transitions)

	insertVowelTransitions(from: o, to: ô, using: "o", into: &transitions)
	insertDecompositionTransitions(for: ô, resettingTo: o, and: "o", into: &transitions)
	insertVowelTransitions(from: o, to: ơ, using: "w", into: &transitions)
	insertDecompositionTransitions(for: ơ, resettingTo: o, and: "w", into: &transitions)

	insertVowelTransitions(from: ô, to: ơ, using: "w", into: &transitions)
	insertVowelTransitions(from: ơ, to: ô, using: "o", into: &transitions)

	insertVowelTransitions(from: u, to: ư, using: "w", into: &transitions)
	insertDecompositionTransitions(for: ư, resettingTo: u, and: "w", into: &transitions)

	insertCasedTransitions(from: "d", to: "đ", using: "d", into: &transitions)
	insertDecompositionTransitions(for: "đ", resettingTo: "d", and: "d", into: &transitions)

	insertToneTransitions(for: a, into: &transitions)
	insertToneTransitions(for: â, into: &transitions)
	insertToneTransitions(for: ă, into: &transitions)
	insertToneTransitions(for: e, into: &transitions)
	insertToneTransitions(for: ê, into: &transitions)
	insertToneTransitions(for: i, into: &transitions)
	insertToneTransitions(for: o, into: &transitions)
	insertToneTransitions(for: ô, into: &transitions)
	insertToneTransitions(for: ơ, into: &transitions)
	insertToneTransitions(for: u, into: &transitions)
	insertToneTransitions(for: ư, into: &transitions)
	insertToneTransitions(for: y, into: &transitions)

	return transitions
}()

private func insertVowelTransitions(
	from originVowel: Vowel,
	to destinationVowel: Vowel,
	using input: Character,
	into transitions: inout [String: NonEmpty<[Character: String]>]
) {
	for toneKeyPath in Vowel.toneKeyPaths {
		insertCasedTransitions(
			from: originVowel[keyPath: toneKeyPath],
			to: destinationVowel[keyPath: toneKeyPath],
			using: input,
			into: &transitions
		)
	}
}

private func insertCasedTransitions(
	from originCharacter: Character,
	to destinationCharacter: Character,
	using input: Character,
	into transitions: inout [String: NonEmpty<[Character: String]>]
) {
	let uppercasedOriginCharacter = Character(originCharacter.uppercased())
	let uppercasedDestinationCharacter = Character(destinationCharacter.uppercased())
	let uppercasedInput = Character(input.uppercased())

	insertTransition(
		from: String(originCharacter),
		to: String(destinationCharacter),
		using: input,
		into: &transitions
	)
	insertTransition(
		from: String(originCharacter),
		to: String(destinationCharacter),
		using: uppercasedInput,
		into: &transitions
	)
	insertTransition(
		from: String(uppercasedOriginCharacter),
		to: String(uppercasedDestinationCharacter),
		using: input,
		into: &transitions
	)
	insertTransition(
		from: String(uppercasedOriginCharacter),
		to: String(uppercasedDestinationCharacter),
		using: uppercasedInput,
		into: &transitions
	)
}

private func insertTransition(
	from originState: String,
	to destinationState: String,
	using input: Character,
	into transitions: inout [String: NonEmpty<[Character: String]>]
) {
	if let transitionsForState = transitions[originState] {
		var updatedTransitions = transitionsForState
		if updatedTransitions.updateValue(destinationState, forKey: input) != nil {
			fatalError()
		}
		transitions[originState] = updatedTransitions
	} else {
		transitions[originState] = [input: destinationState]
	}
}

private func insertDecompositionTransitions(
	for originVowel: Vowel,
	resettingTo resetVowel: Vowel,
	and input: Character,
	into transitions: inout [String: NonEmpty<[Character: String]>]
) {
	for tonePath in Vowel.toneKeyPaths {
		insertDecompositionTransitions(
			for: originVowel[keyPath: tonePath],
			resettingTo: resetVowel[keyPath: tonePath],
			and: input,
			into: &transitions
		)
	}
}

private func insertDecompositionTransitions(
	for originCharacter: Character,
	resettingTo resetCharacter: Character,
	and input: Character,
	into transitions: inout [String: NonEmpty<[Character: String]>]
) {
	let uppercasedOriginCharacter = Character(originCharacter.uppercased())
	let uppercasedResetCharacter = Character(resetCharacter.uppercased())
	let uppercasedInput = Character(input.uppercased())

	insertTransition(
		from: String(originCharacter),
		to: "\(resetCharacter)\(input)",
		using: input,
		into: &transitions
	)
	insertTransition(
		from: String(uppercasedOriginCharacter),
		to: "\(uppercasedResetCharacter)\(input)",
		using: input,
		into: &transitions
	)
	insertTransition(
		from: String(originCharacter),
		to: "\(resetCharacter)\(uppercasedInput)",
		using: uppercasedInput,
		into: &transitions
	)
	insertTransition(
		from: String(uppercasedOriginCharacter),
		to: "\(uppercasedResetCharacter)\(uppercasedInput)",
		using: uppercasedInput,
		into: &transitions
	)
}

private func insertToneTransitions(
	for vowel: Vowel,
	into transitions: inout [String: NonEmpty<[Character: String]>]
) {
	let inputToToneMap: [Character: Character] = [
		"z": vowel.ngangTone,
		"f": vowel.huyềnTone,
		"s": vowel.sắcTone,
		"r": vowel.hỏiTone,
		"x": vowel.ngãTone,
		"j": vowel.nặngTone,
	]

	for pair in inputToToneMap.permutations(ofCount: 2) {
		insertCasedTransitions(
			from: pair[0].value,
			to: pair[1].value,
			using: pair[1].key,
			into: &transitions
		)
	}

	for (input, toneForm) in inputToToneMap {
		insertDecompositionTransitions(
			for: toneForm,
			resettingTo: vowel.ngangTone,
			and: input,
			into: &transitions
		)
	}
}
