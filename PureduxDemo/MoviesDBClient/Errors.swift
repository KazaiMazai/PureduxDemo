//
//  Errors.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation

extension Client {
    public enum Errors: Error {
        case unauthorrized

        case serverError(message: String)
        case unknownResponseFormat
        case unknownServerError
        case emptyResponse

        case invalidRequestBody
        case invalidUrlRequest
    }
}

extension Client.Errors: LocalizedError {
        public var errorDescription: String? {
            switch self {
            case .unauthorrized:
                return "Unauthorized"
            case .serverError(message: let message):
                return message
            case .unknownResponseFormat:
                return "Unknown Response Format"
            case .unknownServerError:
                return "Unknown Server Error"
            case .emptyResponse:
                return "Empty response"
            case .invalidRequestBody:
                return "Invalid Request Body"
            case .invalidUrlRequest:
                return "Invalid URL Request"
            }
        }
}
