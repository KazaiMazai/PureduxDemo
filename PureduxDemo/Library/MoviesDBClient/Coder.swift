//
//  Coders.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation

extension JSONEncoder {
    static let movieDBClientEncoder: JSONEncoder = {
        var encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        encoder.nonConformingFloatEncodingStrategy = .convertToString(positiveInfinity: "+inf",
                                                                      negativeInfinity: "-inf",
                                                                      nan: "nan")
        return encoder
    }()
}

extension JSONDecoder {
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static let longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        return formatter
    }()

    static let movieDBClientDecoder: JSONDecoder = {
        var decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = JSONDecoder.longDateFormatter.date(from: dateString) {
                return date
            }

            if let date = JSONDecoder.shortDateFormatter.date(from: dateString) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)")

        })

        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+inf",
                                                                        negativeInfinity: "-inf",
                                                                        nan: "nan")
        return decoder
    }()
}
