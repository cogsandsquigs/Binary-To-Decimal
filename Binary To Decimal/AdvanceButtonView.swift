//
//  AdvanceButtonView.swift
//  Binary To Decimal
//
//  Created by Ian Pratt on 6/27/24.
//

import SwiftUI

struct AdvanceButtonView: View {
	@ObservedObject var b2d: Bin2Dec
	@State private var buttonText: String = "Rotate Left"

	var body: some View {
		HStack(alignment: .center) {
			Button(self.buttonText) {
				self.b2d.advance()

				self.buttonText = switch self.b2d.state {
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
			.disabled(self.b2d.state == .Done)
			.font(.largeTitle)
			.padding()
			.overlay(
				RoundedRectangle(cornerRadius: 18)
					.stroke(self.b2d.state == .Done ? .gray : .blue, lineWidth: 2)
			)

			Spacer()

			Text("Left Rotations: \(self.b2d.rotLeftCount)")
				.font(.title)
		}
		.onChange(of: b2d.state) { oldState, _ in
//			// Have to have this here b/c
//			// when going from "Done!" to new num. it doesn't update button
//			// text for some reason?
//			self.buttonText = "Rotate Left"
			if oldState == .Done {
				self.buttonText = "Rotate Left"
			}
		}
	}
}

#Preview {
	var b2d = Bin2Dec(binNum: 42)

	AdvanceButtonView(b2d: b2d).padding()
}
