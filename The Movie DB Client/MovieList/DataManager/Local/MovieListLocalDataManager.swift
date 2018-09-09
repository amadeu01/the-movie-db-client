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
        let request: NSFetchRequest<TMDbApiConfiguration> = TMDbApiConfiguration.fetchRequest()
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

    func saveMovie(for movieUpcomingResponse: MovieUpcomingResponse) throws {
        movieUpcomingResponse.results.forEach { resultsElement in
            try? saveMovie(for: resultsElement)
        }
    }

    func saveMovie(for movieUpcomingElement: MovieUpcomingResponse.ResultsElement) throws {
        let movie: Movie

        do {
            movie = try getMovieEntity(for: movieUpcomingElement.id!)
        } catch is PersistenceError {
            movie = try createMovieEntity()
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

    fileprivate func createMovieEntity() throws -> Movie {
        guard let newMovie = NSEntityDescription
            .entity(forEntityName: "Movie", in: managedObjectContext) else {
                throw PersistenceError.couldNotSaveObject
        }
        return Movie(entity: newMovie, insertInto: managedObjectContext)
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

    func saveTMDbApiConfiguration(for configurationResponse: TMDbApiConfigurationResponse) throws {
        let configuration: TMDbApiConfiguration

        do {
            configuration = try getTMDbApiConfigurationEntity()
        } catch is PersistenceError {
            configuration = try createConfigurationEntity()
        }

        populateConfigurationEntity(configuration, with: configurationResponse)
        try managedObjectContext.save()
    }

    fileprivate func createConfigurationEntity() throws -> TMDbApiConfiguration {
        guard let newConfiguration = NSEntityDescription
            .entity(forEntityName: "TMDbApiConfiguration", in: managedObjectContext) else {
                throw PersistenceError.couldNotSaveObject
        }
        return TMDbApiConfiguration(entity: newConfiguration, insertInto: managedObjectContext)
    }

    fileprivate func populateConfigurationEntity(_ configurationEntity: TMDbApiConfiguration,
                                                 with configuration: TMDbApiConfigurationResponse) {
        configurationEntity.backdropSizes = (configuration.images?.backdropSizes)!
        configurationEntity.baseUrl = configuration.images?.baseUrl
        configurationEntity.logoSizes = (configuration.images?.logoSizes)!
        configurationEntity.backdropSizes = (configuration.images?.backdropSizes)!
        configurationEntity.posterSizes = (configuration.images?.posterSizes)!
        configurationEntity.secureBaseUrl = configuration.images?.secureBaseUrl
        configurationEntity.stillSizes = (configuration.images?.stillSizes)!
        configurationEntity.profileSizes = (configuration.images?.profileSizes)!
        configurationEntity.changeKeys = configuration.changeKeys
    }

    func getTMDbApiConfigurationEntity() throws -> TMDbApiConfiguration {
        let request: NSFetchRequest<TMDbApiConfiguration> = TMDbApiConfiguration.fetchRequest()
        let fetchedObjectContext = try managedObjectContext.fetch(request)

        guard fetchedObjectContext.count == 1,
            let fetchedConfiguration = fetchedObjectContext.first else {
                throw PersistenceError.objectNotFound
        }

        return fetchedConfiguration
    }
}
