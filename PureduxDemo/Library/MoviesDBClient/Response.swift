//
//  Response.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation

extension Client {
    enum Responses {}
}

extension Client {
    enum Response<Result: Decodable> {
        case success(Result)
        case cancelled
        case unauthorized(Error)
        case failed(Error)
    }
}
