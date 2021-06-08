//
//  MoviesMapping.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Client.Responses.Movie {
    var appModel: Movie {
        Movie(
            id: Movie.ID(rawValue: id),
            title: title,
            description: overview,
            posterUrl: posterPath)
    }
}
