//
//  Bin2Dec.swift
//  Binary To Decimal
//
//  Created by Ian Pratt on 6/26/24.
//

import Foundation

class Bin2Dec: ObservableObject {
	/// The 16-bit binary number to convert to decimal, stored as a 32-bit binary number so shifting left is easier.
	@Published var binNum: UInt32

	/// The carry bit for the number
	@Published var binNumCarry: Bool = false

	/// The stored decimal characters that we get via converting from binary to decimal
	@Published var decDigits: [Int] = []

	/// The number of times we've rotated left.
	@Published var rotLeftCount: Int = 0

	@Published var state: B2DState = .RotLeft

	/// The original number
	var originalNum: UInt16

	/// The first 16 bits of the binary number, from right to left. AKA:
	///                         /--------------------> These ones
	///                 |--------------|
	/// 00000000000000000000000000000000
	var first16Bits: UInt16 {
		get {
			UInt16(self.binNum & 0x0000FFFF)
		}

		set {
			self.binNum = (self.binNum & 0xFFFF0000) | UInt32(newValue)
		}
	}

	/// The last 16 bits of the binary number, from right to left. AKA:
	///         /--------------------> These ones
	/// |--------------|
	/// 00000000000000000000000000000000
	var last16Bits: UInt16 {
		get {
			UInt16((self.binNum & 0xFFFF0000) >> 16)
		}

		set {
			self.binNum = (UInt32(newValue) << 16) | (self.binNum & 0x0000FFFF)
		}
	}

	init(binNum: UInt16) {
		self.binNum = UInt32(binNum)
		self.originalNum = binNum
	}

	/// Advances the state machine by 1 iteration
	func advance() {
		switch self.state {
			case .RotLeft:
				self.rotLeft()

				if self.rotLeftCount == 16 {
					self.state = .StoreDecDigit
				} else {
					self.state = .Sub10
				}

			case .Sub10:
				// Since we're about to subtract, we set the carry true so we subtract with carry
				self.binNumCarry = true

				if self.last16Sub10WithCarry().1 {
					self.state = .StoreSubResult
				} else {
					self.state = .IgnoreSubResult
				}

			case .IgnoreSubResult:
				self.binNumCarry = false
				self.state = .RotLeft

			case .StoreSubResult:
				(self.last16Bits, self.binNumCarry) = self.last16Sub10WithCarry()
				self.state = .RotLeft

			case .StoreDecDigit:
				self.decDigits.append(Int(self.last16Bits))
				self.rotLeft()
				self.state = .ClearRemainder

			case .RotLeftThenClear:
				self.rotLeft()
				self.state = .ClearRemainder

			case .ClearRemainder:
				self.binNumCarry = false
				self.last16Bits = 0
				self.rotLeftCount = 0

				if self.first16Bits == 0 {
					self.state = .FlipDecimalDigits
				} else {
					self.state = .RotLeft
				}

			case .FlipDecimalDigits:
				self.decDigits.reverse()
				self.state = .Done

			case .Done:
				// Do nothing! We finished!
				return
		}
	}

	/// A helper function to reset the state
	func reset(newBinNum: UInt16) {
		self.decDigits = []
		self.rotLeftCount = 0
		self.binNumCarry = false
		self.state = .RotLeft
		self.binNum = UInt32(newBinNum)
		self.originalNum = newBinNum
	}

	/// Get the subtract 10 with carry result
	func last16Sub10WithCarry() -> (UInt16, Bool) {
		let sub10 = self.last16Bits &- 10

		return (
			sub10,
			// Approximation for there being an overflow/using carry
			(sub10 > self.last16Bits) ? false : true
		)
	}

	/// A helper function to rotate the bits left
	private func rotLeft() {
		let prevCarry = self.binNumCarry
		self.binNumCarry = (self.last16Bits >> 15) == 1
		self.binNum <<= 1
		self.first16Bits = self.first16Bits | (prevCarry ? 0x0001 : 0x0000)

		self.rotLeftCount += 1
	}
}

enum B2DState {
	case RotLeft
	case Sub10
	case IgnoreSubResult
	case StoreSubResult
	case StoreDecDigit
	case RotLeftThenClear
	case ClearRemainder
	case FlipDecimalDigits
	case Done
}
