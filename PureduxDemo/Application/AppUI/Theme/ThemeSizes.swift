//
//  ThemeSizes.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import UIKit

extension AppUITheme {
    struct Sizes {
        let components: ComponentsSizes
        let boarders: Borders
        let corners: Corners

        static var defaultSizes: Sizes {
            Sizes(components: .defaultComponentsSizes,
                  boarders: .defaultBorders,
                  corners: .defaultCorners)
        }

    }
}

extension AppUITheme.Sizes {
    struct Borders {
        let line: CGFloat

        static let defaultBorders = Borders(line: 1)
    }
}

extension AppUITheme.Sizes {
    struct ComponentsSizes {
        let inputFields: CGFloat

        static let defaultComponentsSizes = ComponentsSizes(inputFields: 52)
    }
}

extension AppUITheme.Sizes {
    struct Corners {
        let extraTiny: CGFloat
        let tiny: CGFloat
        let small: CGFloat
        let large: CGFloat

        static let defaultCorners = Corners(extraTiny: 4,
                                            tiny: 6,
                                            small: 8,
                                            large: 15)
    }
}
