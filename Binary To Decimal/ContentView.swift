//
//  ContentView.swift
//  Binary To Decimal
//
//  Created by Ian Pratt on 6/26/24.
//

import Combine
import SwiftUI

// import Fonts

struct ContentView: View {
	@StateObject var b2d = Bin2Dec(binNum: 42)

	var body: some View {
		VStack {
			VStack {
				InputView(b2d: self.b2d)

				Spacer()
					.frame(height: 50)

				AdvanceButtonView(b2d: self.b2d)
			}

			Spacer()
				.frame(height: 100)

			HStack(alignment: .top, spacing: 0) {
				VStack {
					CarryBit(self.b2d.binNumCarry)

					if self.b2d.state == .IgnoreSubResult || self.b2d.state == .StoreSubResult {
						Spacer()

						CarryBit(self.b2d.last16Sub10WithCarry().1)
					}
				}

				Spacer()

				VStack(alignment: .trailing) {
					HStack(alignment: .top, spacing: 0) {
						Padded16Bits(self.b2d.last16Bits)
					}

					if self.b2d.state == .IgnoreSubResult || self.b2d.state == .StoreSubResult {
						Text("- 1010")

						Padded16Bits(self.b2d.last16Sub10WithCarry().0)
					} else if self.b2d.state == .StoreDecDigit {
						Text("+ 00110000")

						HStack(spacing: 0) {
							Spacer()

							Padded16Bits(self.b2d.last16Bits + 0b00110000)
						}
					}
				}

				VStack {
					Text("|")
						.foregroundStyle(.blue)
				}
				.padding(.horizontal, 8)

				VStack(alignment: .leading) {
					Padded16Bits(self.b2d.first16Bits)

					if self.b2d.state == .StoreDecDigit {
						Spacer()

						Text("ASCII for '0'")
							.foregroundStyle(.gray)
							.font(.largeTitle)

						Spacer()
						Spacer()
						Spacer()

						Text("ASCII for '\(String(self.b2d.last16Bits))'")
							.foregroundStyle(.gray)
							.font(.largeTitle)

						Spacer()
					}
				}
			}
			.fixedSize(horizontal: false, vertical: true)
			.padding()
			.font(.largerTitle)
			.layoutPriority(1)

			Spacer()

			Text("Decimal Representation:").font(.title)
			Text("'\(self.b2d.decDigits.map { String($0) }.joined())'")
				.font(.largerTitle)
				.padding()
				.overlay(
					RoundedRectangle(cornerRadius: 18)
						.stroke(.blue, lineWidth: 2)
				)
		}
		.padding()
		// More padding for MacOS
		#if os(macOS)
			.padding()
			.padding()
		#endif
	}
}

#Preview {
	ContentView()
		.environment(\.font, Font.custom("FiraCode-Regular", size: 14))
}
