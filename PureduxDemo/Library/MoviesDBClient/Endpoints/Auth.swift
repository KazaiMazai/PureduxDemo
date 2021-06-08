//
//  Auth.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

protocol MoviesDBAuth {
    func createRequestToken() throws -> Client.Request<Client.Responses.Token>

    func createSession(requestToken: String) throws -> Client.Request<Client.Responses.Session>

    func createSessionWithLogin(username: String,
                                password: String,
                                requestToken: String) throws -> Client.Request<Client.Responses.Session>
}

extension Client: MoviesDBAuth {
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
