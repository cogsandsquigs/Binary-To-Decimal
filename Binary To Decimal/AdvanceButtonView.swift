//
//  AdvanceButtonView.swift
//  Binary To Decimal
//
//  Created by Ian Pratt on 6/27/24.
//

import SwiftUI

struct AdvanceButtonView: View {
	@ObservedObject var b2d: Bin2Dec
	@State private var buttonText = "Rotate Left"
	@State private var isAutoStepping = false

	var body: some View {
		HStack(alignment: .center, spacing: 25) {
			Button(self.buttonText) {
				self.b2d.advance()
			}
			.disabled(self.b2d.state == .Done)
			.font(.largeTitle)
			.padding()
			.overlay(
				RoundedRectangle(cornerRadius: 18)
					.stroke(self.b2d.state == .Done ? .gray : .blue, lineWidth: 2)
			)

			Spacer()

			Text("Rotations: \(self.b2d.rotLeftCount)")
				.font(.title)
				.foregroundStyle(.gray)

			Button("Reset") {
				self.b2d.reset(newBinNum: self.b2d.originalNum)
				self.isAutoStepping = false
			}
			.foregroundStyle(.red)
			.font(.largeTitle)
			.padding()
			.overlay(
				RoundedRectangle(cornerRadius: 18)
					.stroke(.red, lineWidth: 2)
			)

			Button("Auto") {
				self.isAutoStepping.toggle()

				if self.isAutoStepping && self.b2d.state != .Done {
					self.autoStep()
				}
			}
			.font(.largeTitle)
			.padding()
			.disabled(self.b2d.state == .Done)
			.overlay(
				RoundedRectangle(cornerRadius: 18)
					.stroke(self.b2d.state == .Done ? .gray : .blue, lineWidth: 2)
			)
		}
		.onChange(of: b2d.state) { _, newState in
			self.buttonText = switch newState {
			case .RotLeft, .RotLeftThenClear:
				"Rotate Left"
			case .Sub10:
				"Subtract 10 (with Carry)"
			case .IgnoreSubResult:
				"Ignore Result"
			case .StoreSubResult:
				"Store Result"
			case .StoreDecDigit:
				"Record Decimal Digit"
			case .ClearRemainder:
				"Clear Remainder"
			case .FlipDecimalDigits:
				"Flip Decimal Digits"
			case .Done:
				"Done!"
			}
		}
	}

	func autoStep() {
		DispatchQueue.global().async {
			while self.isAutoStepping && self.b2d.state != .Done {
				DispatchQueue.main.async {
					self.b2d.advance()
				}
				Thread.sleep(forTimeInterval: 0.25)
			}
		}
	}
}

#Preview {
	var b2d = Bin2Dec(binNum: 42)

	AdvanceButtonView(b2d: b2d).padding()
}
