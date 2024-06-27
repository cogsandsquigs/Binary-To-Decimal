//
//  Gizmos.swift
//  Binary To Decimal
//
//  Created by Ian Pratt on 6/27/24.
//

import SwiftUI

struct CarryBit: View {
	var bit: Bool

	init(_ bit: Bool) {
		self.bit = bit
	}

	var body: some View {
		Text("Carry")
			.padding(.top, -30)
			.font(.body)

		Text(self.bit ? "1" : "0")
			.overlay(
				Rectangle().frame(height: 4).foregroundStyle(.blue),
				alignment: .bottom
			)
	}
}

struct Padded16Bits: View {
	var number: UInt16

	init(_ number: UInt16) {
		self.number = number
	}

	var body: some View {
		Text("\(String(self.number, radix: 2).leftPadding(toLength: 16, withPad: "0"))")
	}
}

extension String {
	func leftPadding(toLength: Int, withPad character: Character) -> String {
		if self.count < toLength {
			return String(repeatElement(character, count: toLength - self.count)) + self
		} else {
			return self
		}
	}
}

#Preview {
	VStack {
		Spacer()

		CarryBit(true)
			.font(.largerTitle)

		Spacer()

		Padded16Bits(0xAAAA)
			.font(.largerTitle)

		Spacer()
	}
}
