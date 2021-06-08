//
//  SuccessResponse.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation

extension Client.Responses {
    struct SuccessResponse: Codable {
        let success: Bool
    }
}
