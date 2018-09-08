//
//  MovieListLocalDataManager.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 17/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import CoreData

class MovieListLocalDataManager: MovieListLocalDataManagerInputProtocol {

    fileprivate let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func getTMDbApiConfiguration() throws -> ConfigurationEntity? {
        let request: NSFetchRequest<TMDbApiConfiguration> = NSFetchRequest(entityName: String(describing: TMDbApiConfiguration.self))

        let localConfig = try managedObjectContext.fetch(request).first

        if let localConfig = localConfig {
            return ConfigurationEntity(from: localConfig)
        } else {
            return nil
        }
    }

    func searchMovie(forTitle title: String) throws -> [Movie] {
        let request: NSFetchRequest<Movie> = NSFetchRequest(entityName: String(describing: Movie.self))
        request.predicate = NSPredicate(format: "title like[cd] %@", title)
        return try managedObjectContext.fetch(request)
    }

    func getNextMoviesReleases() throws -> [Movie] {
        let request: NSFetchRequest<Movie> = NSFetchRequest(entityName: String(describing: Movie.self))

        return try managedObjectContext.fetch(request)
    }

    func saveMovie(for movieUpcomingElement: MovieUpcomingResponse.ResultsElement) throws {
        let movie: Movie

        do {
            movie = try getMovieEntity(for: movieUpcomingElement.id!)
        } catch is PersistenceError {
            guard let newMovie =
                NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
                    return
            }
            movie = Movie(entity: newMovie, insertInto: managedObjectContext)
            movie.remoteId = movieUpcomingElement.id ?? -1
        }

        populateMovieEntity(movie, with: movieUpcomingElement)
        try managedObjectContext.save()
    }

    func getMovieEntity(for id: Int) throws -> Movie {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "remoteId == %d", id)
        let fetchedObjectContext = try managedObjectContext.fetch(request)

        guard fetchedObjectContext.count == 1,
            let fetchedMovie = fetchedObjectContext.first else {
                throw PersistenceError.objectNotFound
        }

        return fetchedMovie
    }

    fileprivate func populateMovieEntity(
        _ movieEntity: Movie, with movieUpcomingElement: MovieUpcomingResponse.ResultsElement) {

        movieEntity.title = movieUpcomingElement.title
        movieEntity.overview = movieUpcomingElement.overview
        movieEntity.posterPath = movieUpcomingElement.posterPath
        movieEntity.backdropPath = movieUpcomingElement.backdropPath
        movieEntity.releaseDate = movieUpcomingElement.releaseDate
        movieEntity.originalTitle = movieUpcomingElement.originalTitle
        movieEntity.video = NSNumber(booleanLiteral: movieUpcomingElement.video ?? false)
        movieEntity.adult = NSNumber(booleanLiteral: movieUpcomingElement.adult ?? false)
        movieEntity.genreIds = movieUpcomingElement.genreIds as [NSNumber]
        movieEntity.voteAverage = movieUpcomingElement.voteAverage
        movieEntity.popularity = movieUpcomingElement.popularity
        movieEntity.originalLanguage = movieUpcomingElement.originalLanguage
    }

    func saveMovie(for movieUpcomingResponse: MovieUpcomingResponse) throws {
        movieUpcomingResponse.results.forEach { resultsElement in
            try? saveMovie(for: resultsElement)
        }
    }

    func saveTMDbApiConfiguration(for configuration: TMDbApiConfigurationResponse) throws {
        let request: NSFetchRequest<TMDbApiConfiguration> = NSFetchRequest(entityName: String(describing: TMDbApiConfiguration.self))

        let fetched = try managedObjectContext.fetch(request)

        if fetched.count == 1 {
            let tempConfig = fetched.first!
            tempConfig.backdropSizes = (configuration.images?.backdropSizes)!
            tempConfig.baseUrl = configuration.images?.baseUrl
            tempConfig.logoSizes = (configuration.images?.logoSizes)!
            tempConfig.backdropSizes = (configuration.images?.backdropSizes)!
            tempConfig.posterSizes = (configuration.images?.posterSizes)!
            tempConfig.secureBaseUrl = configuration.images?.secureBaseUrl
            tempConfig.stillSizes = (configuration.images?.stillSizes)!
            tempConfig.profileSizes = (configuration.images?.profileSizes)!

            try managedObjectContext.save()
        } else {
            if let newConfig = NSEntityDescription.entity(forEntityName: "TMDbApiConfiguration",
                                                          in: managedObjectContext) {
                let config = TMDbApiConfiguration(entity: newConfig, insertInto: managedObjectContext)
                config.backdropSizes = (configuration.images?.backdropSizes)!
                config.baseUrl = configuration.images?.baseUrl
                config.logoSizes = (configuration.images?.logoSizes)!
                config.backdropSizes = (configuration.images?.backdropSizes)!
                config.posterSizes = (configuration.images?.posterSizes)!
                config.secureBaseUrl = configuration.images?.secureBaseUrl
                config.stillSizes = (configuration.images?.stillSizes)!
                config.profileSizes = (configuration.images?.profileSizes)!

                try managedObjectContext.save()
            }
        }
    }
}
