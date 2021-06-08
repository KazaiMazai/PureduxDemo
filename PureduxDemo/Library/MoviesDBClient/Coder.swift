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
    static let movieDBClientDecoder: JSONDecoder = {
        var decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+inf",
                                                                        negativeInfinity: "-inf",
                                                                        nan: "nan")
        return decoder
    }()
}
