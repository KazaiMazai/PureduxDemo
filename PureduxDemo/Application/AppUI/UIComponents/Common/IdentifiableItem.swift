//
//  IdentifiableItem.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation

struct Identifying<ID: Hashable, Element>: Identifiable {
    let id: ID
    let element: Element
}
