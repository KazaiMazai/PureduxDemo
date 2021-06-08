//
//  MoviesDBClient.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation

final class Client {
    private let baseURL: URL
    private let apiKey: String
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(baseURL: URL,
         apiKey: String,
         encoder: JSONEncoder = .movieDBClientEncoder,
         decoder: JSONDecoder = .movieDBClientDecoder) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.encoder = encoder
        self.decoder = decoder
    }
}

extension Client {
    func responseHandler<Result: Decodable>(data: Data?,
                                            response: URLResponse?,
                                            error: Error?) -> Response<Result> {
        if let error = error as NSError? {
            switch (error.domain, error.code) {
            case (NSURLErrorDomain, NSURLErrorCancelled): return .cancelled
            default: return .failed(error)
            }
        }

        guard let response = response as? HTTPURLResponse else {
            return .failed(Errors.emptyResponse)
        }

        guard response.statusCode != 401 else {
            return .unauthorized(Errors.unauthorrized)
        }

        guard response.statusCode == 200 else {
            guard let data = data,
                  let errorReponse = try? decoder.decode(Responses.ErrorResponse.self, from: data),
                  let statusMessage = errorReponse.statusMessage
            else {
                return .failed(Errors.unknownServerError)
            }

            return .failed(Errors.serverError(message: statusMessage))
        }

        guard let data = data else {
            return .failed(Errors.unknownResponseFormat)
        }

        do {
            let result = try decoder.decode(Result.self, from: data)
            return .success(result)
        } catch {
            return .failed(Errors.unknownResponseFormat)
        }
    }
}

extension Client {
    func request<Result: Decodable>(urlRequest: URLRequest) -> Request<Result> {
        Request(urlRequest: urlRequest, type: .data, handler: responseHandler)
    }
}

extension Client {
    func get(to path: String,
             with params: [URLQueryItem] = []) throws -> URLRequest {

        var request = try prepareRequest(for: path, with: params)
        request.httpMethod = "GET"
        return request
    }

    func post(to path: String,
              with params: [URLQueryItem] = []) throws -> URLRequest {
        var request = try prepareRequest(for: path, with: params)
        request.httpMethod = "POST"
        return request
    }

    func post<Body: Encodable>(_ body: Body,
                               to path: String,
                               with params: [URLQueryItem] = []) throws -> URLRequest {
        var request = try prepareRequest(for: path, with: params)

        request.httpMethod = "POST"
        request.httpBody = try encoder.encode(body)
        request.addJSONContentType()
        return request
    }

    func delete(to path: String,
                with params: [URLQueryItem] = []) throws -> URLRequest {

        var request = try prepareRequest(for: path, with: params)
        request.httpMethod = "DELETE"
        request.addJSONContentType()
        return request
    }

    func patch<Body: Encodable>(_ body: Body,
                                to path: String,
                                with params: [URLQueryItem] = []) throws -> URLRequest {

        var request = try prepareRequest(for: path, with: params)
        request.httpMethod = "PATCH"
        request.httpBody = try encoder.encode(body)
        request.addJSONContentType()
        return request
    }

    func put<Body: Encodable>(_ body: Body,
                              to path: String,
                              with params: [URLQueryItem] = []) throws -> URLRequest {

        var request = try prepareRequest(for: path, with: params)
        request.httpMethod = "PUT"
        request.httpBody = try encoder.encode(body)
        request.addJSONContentType()
        return request
    }
}

fileprivate extension URLRequest {
    mutating func addJSONContentType() {
        addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
}

extension Client {
    private func prepareRequest(for path: String,
                                with params: [URLQueryItem] = []) throws -> URLRequest {

        var url = baseURL
        url.appendPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw Errors.invalidUrlRequest
        }

        var parameters = params
        parameters.append(URLQueryItem(name: "api_key", value: apiKey))

        components.queryItems = parameters
        guard let componentsUrl = components.url else {
            throw Errors.invalidUrlRequest
        }

        return URLRequest(url: componentsUrl)
    }
}
