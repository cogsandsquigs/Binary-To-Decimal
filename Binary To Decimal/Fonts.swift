//
//  Fonts.swift
//  Binary To Decimal
//
//  Created by Ian Pratt on 6/27/24.
//

import Foundation
import SwiftUI

// import UIKit
#if os(macOS)
import AppKit.NSFont

public extension Font {
	/// Create a font with the large title text style.
	static var largeTitle: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .largeTitle).pointSize)
	}
	
	/// Create a font with the large title text style.
	static var largerTitle: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .largeTitle).pointSize + 16)
	}

	/// Create a font with the title text style.
	static var title: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .title1).pointSize)
	}
	
	/// Create a font with the title text style.
	static var title2: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .title2).pointSize)
	}

	/// Create a font with the title text style.
	static var title3: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .title2).pointSize)
	}

	/// Create a font with the headline text style.
	static var headline: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .headline).pointSize)
	}
	
	/// Create a font with the subheadline text style.
	static var subheadline: Font {
		return Font.custom("FiraCode-Light", size: NSFont.preferredFont(forTextStyle: .subheadline).pointSize)
	}
	
	/// Create a font with the body text style.
	static var body: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .body).pointSize)
	}
	
	/// Create a font with the callout text style.
	static var callout: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .callout).pointSize)
	}
	
	/// Create a font with the footnote text style.
	static var footnote: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .footnote).pointSize)
	}
	
	/// Create a font with the caption text style.
	static var caption: Font {
		return Font.custom("FiraCode-Regular", size: NSFont.preferredFont(forTextStyle: .caption1).pointSize)
	}
	
	static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
		var font = "FiraCode-Regular"
		switch weight {
			case .bold: font = "FiraCode-Bold"
			case .heavy: font = "FiraCode-Bold" // no "FiraCode-ExtraBold"
			case .light: font = "FiraCode-Light"
			case .medium: font = "FiraCode-Regular"
			case .semibold: font = "FiraCode-SemiBold"
			case .thin: font = "FiraCode-Light"
			case .ultraLight: font = "FiraCode-Light"
			default: break
		}
		return Font.custom(font, size: size)
	}
}

#elseif os(iOS)
import UIKit.UIFont

public extension Font {
	/// Create a font with the large title text style.
	static var largeTitle: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
	}
	
	/// Create a font with the large title text style.
	static var largerTitle: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize + 16)
	}
	
	/// Create a font with the title text style.
	static var title: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
	}
	
	/// Create a font with the title text style.
	static var title2: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
	}
	
	/// Create a font with the title text style.
	static var title3: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
	}

	/// Create a font with the headline text style.
	static var headline: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
	}
	
	/// Create a font with the subheadline text style.
	static var subheadline: Font {
		return Font.custom("FiraCode-Light", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
	}
	
	/// Create a font with the body text style.
	static var body: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
	}
	
	/// Create a font with the callout text style.
	static var callout: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
	}
	
	/// Create a font with the footnote text style.
	static var footnote: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
	}
	
	/// Create a font with the caption text style.
	static var caption: Font {
		return Font.custom("FiraCode-Regular", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
	}
	
	static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
		var font = "FiraCode-Regular"
		switch weight {
			case .bold: font = "FiraCode-Bold"
			case .heavy: font = "FiraCode-Bold" // no "FiraCode-ExtraBold"
			case .light: font = "FiraCode-Light"
			case .medium: font = "FiraCode-Regular"
			case .semibold: font = "FiraCode-SemiBold"
			case .thin: font = "FiraCode-Light"
			case .ultraLight: font = "FiraCode-Light"
			default: break
		}
		return Font.custom(font, size: size)
	}
}
#endif
