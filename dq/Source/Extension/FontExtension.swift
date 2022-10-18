//
//  FontExtension.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct AppFontName {
    static let mainfont = "Mabinogi_Classic_OTF"
    static let logofont = "PacificNorthwestLettersW01"
}

extension Font {
    static let dqLogoFont = Font.custom(AppFontName.logofont, size: Font.TextStyle.title.size
                                        , relativeTo: .largeTitle)
    static let dqBigLogoFont = Font.custom(AppFontName.logofont, size: 150
                                        , relativeTo: .largeTitle)
    static let dqMediumLogoFont = Font.custom(AppFontName.logofont, size: Font.TextStyle.title2.size
                                        , relativeTo: .largeTitle)
    static let dqSmallLogoFont = Font.custom(AppFontName.logofont, size: Font.TextStyle.title3.size
                                        , relativeTo: .largeTitle)
    static let dqVeryBigFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.largeTitle.size
                                           , relativeTo: .caption)
    static let dqBigBigFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.title.size
                                       , relativeTo: .caption)
    static let dqBigFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.title2.size
                                       , relativeTo: .caption)
    static let dqBigSmallFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.title3.size
                                       , relativeTo: .caption)
    static let dqMediumBigFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.headline.size
                                             , relativeTo: .caption)
    static let dqMediumFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.subheadline.size
                                          , relativeTo: .caption)
    static let dqMediumSmallFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.footnote.size
                                               , relativeTo: .caption)
    static let dqSmallFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.caption.size
                                         , relativeTo: .caption)
    static let dqVerySmallFont = Font.custom(AppFontName.mainfont, size: Font.TextStyle.caption2.size
                                             , relativeTo: .caption)
}

extension Font.TextStyle {
    
    var size: CGFloat {
        switch self {
        case .largeTitle: return 60
        case .title: return 48
        case .title2: return 34
        case .title3: return 24
        case .headline, .body: return 18
        case .subheadline, .callout: return 16
        case .footnote: return 14
        case .caption: return 12
        case .caption2: return 10
        @unknown default:
            return 8
        }
    }
}
