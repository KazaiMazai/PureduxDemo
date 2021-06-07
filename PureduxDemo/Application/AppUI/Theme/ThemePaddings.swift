//
//  ThemePaddings.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import UIKit

extension AppUITheme {
    struct Paddings {
        private let step: CGFloat

        var tiny: CGFloat {
            step / 4
        }

        var small: CGFloat {
            step / 2
        }

        var normal: CGFloat {
            step
        }

        var large: CGFloat {
            step * 2
        }

        var huge: CGFloat {
            step * 4
        }

        static var defaultPaddings: Paddings {
            Paddings(step: 8)
        }
    }
}
