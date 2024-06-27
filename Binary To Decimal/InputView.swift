//
//  InputView.swift
//  Binary To Decimal
//
//  Created by Ian Pratt on 6/27/24.
//

import Combine
import SwiftUI

struct InputView: View {
	@State var chosenBinNum: UInt16 = 42
	@State var strChosenBinNum = "101010"
	@StateObject var b2d: Bin2Dec

	var body: some View {
		HStack(alignment: .center) {
			Text("Input Binary number: ")
				.font(.largeTitle)

			TextField(
				"101010",
				text: self.$strChosenBinNum
			)
			.font(.largeTitle)
			.multilineTextAlignment(.trailing)
			.onReceive(Just(self.strChosenBinNum)) { newValue in
				let filtered = newValue.filter { "01".contains($0) }
				if filtered != newValue {
					self.strChosenBinNum = filtered
				}
			}
			.onSubmit {
				self.chosenBinNum = UInt16(self.strChosenBinNum, radix: 2) ?? 0
				self.b2d.reset(newBinNum: self.chosenBinNum)
			}
			#if os(iOS)
			.keyboardType(.numberPad)
			#endif
		}
		.padding()
		.overlay(
			RoundedRectangle(cornerRadius: 18)
				.stroke(.gray, lineWidth: 2)
		)
	}
}

#Preview {
	var b2d = Bin2Dec(binNum: 42)

	InputView(b2d: b2d).padding()
}
