//
//  Movie.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

struct Movie: Entity {
    //swiftlint:disable type_name
    struct ID: EntityID {
        let rawValue: Int
    }

    let id: ID
    let title: String
    let description: String
    let posterUrl: String?
}
