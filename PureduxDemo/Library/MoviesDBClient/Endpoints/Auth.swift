//
//  Auth.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Client {
    func createRequestToken() throws -> Request<Responses.Token> {
        request(urlRequest: try get(to: "authentication/token/new"))
    }

    func createSession(requestToken: String) throws -> Request<Responses.Session> {
        let body = Requests.CreateSession(requestToken: requestToken)
        return request(
            urlRequest: try post(
                body,
                to: "authentication/session/new"))
    }

    func createSessionWithLogin(username: String,
                                password: String,
                                requestToken: String) throws -> Request<Responses.Session> {

        let body = Requests.CreateSessionWithLogin(
            username: username,
            password: password,
            requestToken: requestToken)

        return request(
            urlRequest: try post(
                body,
                to: "/authentication/token/validate_with_login"))
    }
}
