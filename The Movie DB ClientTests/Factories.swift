//
//  Factories.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante Filho on 08/09/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

@testable import The_Movie_DB_Client

final class MovieUpcomingResponseFactory {
    static public var LaDoceVita: MovieUpcomingResponse.ResultsElement {
        return MovieUpcomingResponse.ResultsElement(
            voteCount: 501,
            id: 439,
            video: false,
            voteAverage: 8.1,
            title: "La dolce vita",
            popularity: 10.0,
            posterPath: "/aU7WLwPVCOoonAPWOPBmZ8X0c3c.jpg",
            originalLanguage: "it",
            originalTitle: "La dolce vita",
            genreIds: [35, 18],
            backdropPath: "/b3ofp0vhkbKsrz2V44DimBRKkxf.jpg",
            adult: false,
            overview: "Episodic journey of an Italian journalist scouring Rome in search of love.",
            releaseDate: "1960-02-05"
        )
    }

    static public var AvengersInfinityWar: MovieUpcomingResponse.ResultsElement {
        return MovieUpcomingResponse.ResultsElement(
            voteCount: 7745,
            id: 299536,
            video: false,
            voteAverage: 8.3,
            title: "Avengers: Infinity War",
            popularity: 260.161,
            posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
            originalLanguage: "it",
            originalTitle: "La dolce vita",
            genreIds: [35, 18],
            backdropPath: "/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
            adult: false,
            overview: """
            As the Avengers and their allies have continued to protect the world from threats too large
            for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos.
            A despot of intergalactic infamy, his goal is to collect all six Infinity Stones,
            artifacts of unimaginable power, and use them to inflict his twisted will on all of reality.
            Everything the Avengers have fought for has led up to this moment -
            the fate of Earth and existence itself has never been more uncertain.
            """,
            releaseDate: "1960-02-05"
        )
    }

    public static var MoviesUpcoming: MovieUpcomingResponse {
        return MovieUpcomingResponse(
            results: [MovieUpcomingResponseFactory.AvengersInfinityWar,
                      MovieUpcomingResponseFactory.LaDoceVita],
            page: 1,
            totalResults: 2,
            dates: MovieUpcomingResponse.Dates.mocked,
            totalPages: 1)
    }
}

final class TMDbApiConfigurationFactory {
    public static var Config: TMDbApiConfigurationResponse {
        return TMDbApiConfigurationResponse(
            images: Images,
            changeKeys: ["adult",
                         "air_date",
                         "also_known_as",
                         "alternative_titles",
                         "biography",
                         "birthday",
                         "budget",
                         "cast",
                         "certifications",
                         "character_names",
                         "created_by",
                         "crew",
                         "deathday",
                         "episode",
                         "episode_number",
                         "episode_run_time",
                         "freebase_id",
                         "freebase_mid",])
    }

    public static var Images: TMDbApiConfigurationResponse.Images {
        return TMDbApiConfigurationResponse.Images(
            baseUrl: "http://image.tmdb.org/t/p/",
            secureBaseUrl: "https://image.tmdb.org/t/p/",
            backdropSizes: ["w300",
                            "w780",
                            "w1280",
                            "original"],
            logoSizes: ["w45",
                        "w92",
                        "w154",
                        "w185",
                        "w300",
                        "w500",
                        "original"],
            posterSizes: ["w92",
                          "w154",
                          "w185",
                          "w342",
                          "w500",
                          "w780",
                          "original"],
            profileSizes: ["w45",
                           "w185",
                           "h632",
                           "original"],
            stillSizes: ["w92",
                         "w185",
                         "w300",
                         "original"])
    }
}
