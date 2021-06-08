//
//  Discover.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

protocol MoviesDBDiscover {
    func discoverPopularMovies(
        page: Int) throws -> Client.Request<Client.Responses.PaginatedResponse<Client.Responses.Movie>>

    func discoverPopularMovies() throws ->
    Client.Request<Client.Responses.PaginatedResponse<Client.Responses.Movie>>
}

extension Client: MoviesDBDiscover {
    func discoverPopularMovies() throws -> Request<Responses.PaginatedResponse<Responses.Movie>> {
        try discoverPopularMovies(page: 0)
    }

    func discoverPopularMovies(
        page: Int) throws -> Request<Responses.PaginatedResponse<Responses.Movie>> {

        let parameters = [
            URLQueryItem(name: Requests.QueryKeys.page, value: String(page)),
            URLQueryItem(name: Requests.QueryKeys.sort, value: "popularity.desc")
        ]

        return request(urlRequest: try get(to: "discover/movie", with: parameters))
    }
}
