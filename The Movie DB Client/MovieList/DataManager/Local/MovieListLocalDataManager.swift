//
//  MovieListLocalDataManager.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 17/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import CoreData

class MovieListLocalDataManager: MovieListLocalDataManagerInputProtocol {
	func getTMDbApiConfiguration() throws -> ConfigurationEntity? {
		guard let managedOC = CoreDataStore.managedObjectContext else {
			throw PersistenceError.managedObjectContextNotFound
		}
		
		let request: NSFetchRequest<TMDbApiConfiguration> = NSFetchRequest(entityName: String(describing: TMDbApiConfiguration.self))
		
		let localConfig = try managedOC.fetch(request).first
		
		if let localConfig = localConfig {
			return ConfigurationEntity(from: localConfig)
		} else {
			return nil
		}
	}
	
    
    func searchMovie(forTitle title: String) throws -> [Movie] {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let request: NSFetchRequest<Movie> = NSFetchRequest(entityName: String(describing: Movie.self))
        request.predicate = NSPredicate(format: "title like[cd] %@", title)
        return try managedOC.fetch(request)
    }
    
    func getNextMoviesReleases() throws -> [Movie]  {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Movie> = NSFetchRequest(entityName: String(describing: Movie.self))
        
        return try managedOC.fetch(request)
    }
    
    func saveMovie(forMovieUpcomingResponseElement movieUpcomingElement: MovieUpcomingResponse.ResultsElement) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let request: NSFetchRequest<Movie> = NSFetchRequest(entityName: String(describing: Movie.self))
        request.predicate = NSPredicate(format: "remoteId == %d", movieUpcomingElement.id!)
        let fetched = try managedOC.fetch(request)
        
        if fetched.count == 1 {
            let tempMovie = fetched.first!
            tempMovie.title = movieUpcomingElement.title
            tempMovie.overview = movieUpcomingElement.overview
            tempMovie.posterPath = movieUpcomingElement.posterPath
            tempMovie.backdropPath = movieUpcomingElement.backdropPath
            tempMovie.releaseDate = movieUpcomingElement.releaseDate
            tempMovie.originalTitle = movieUpcomingElement.originalTitle
            tempMovie.video = NSNumber(booleanLiteral: movieUpcomingElement.video!)
            tempMovie.adult = NSNumber(booleanLiteral: movieUpcomingElement.adult!)
            tempMovie.genreIds = movieUpcomingElement.genreIds as [NSNumber]
            tempMovie.voteAverage = movieUpcomingElement.voteAverage
            tempMovie.popularity = movieUpcomingElement.popularity
            
            try managedOC.save()
        } else {
            if let newMovie = NSEntityDescription.entity(forEntityName: "Movie",
                                                         in: managedOC) {
                let movie = Movie(entity: newMovie, insertInto: managedOC)
                movie.remoteId = Int32(movieUpcomingElement.id!)
                movie.overview = movieUpcomingElement.overview
                movie.posterPath = movieUpcomingElement.posterPath
                movie.backdropPath = movieUpcomingElement.backdropPath
                movie.releaseDate = movieUpcomingElement.releaseDate
                movie.originalTitle = movieUpcomingElement.originalTitle
                movie.video = NSNumber(booleanLiteral: movieUpcomingElement.video!)
                movie.adult = NSNumber(booleanLiteral: movieUpcomingElement.adult!)
                movie.genreIds = movieUpcomingElement.genreIds as [NSNumber]
                movie.voteAverage = movieUpcomingElement.voteAverage
                movie.popularity = movieUpcomingElement.popularity
                
                try managedOC.save()
            }
        }
    }
    
    func saveMovie(forMovieUpcomingResponse movieUpcomingResponse: MovieUpcomingResponse) throws {
        movieUpcomingResponse.results.map { resultsElement in
            try? saveMovie(forMovieUpcomingResponseElement: resultsElement)
        }
    }
    
    func saveTMDbApiConfiguration(forConfiguration configuration: TMDbApiConfigurationResponse) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<TMDbApiConfiguration> = NSFetchRequest(entityName: String(describing: TMDbApiConfiguration.self))
        
        let fetched = try managedOC.fetch(request)
        
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
			
			try managedOC.save()
		} else {
			if let newConfig = NSEntityDescription.entity(forEntityName: "TMDbApiConfiguration",
														 in: managedOC) {
				let config = TMDbApiConfiguration(entity: newConfig, insertInto: managedOC)
				config.backdropSizes = (configuration.images?.backdropSizes)!
				config.baseUrl = configuration.images?.baseUrl
				config.logoSizes = (configuration.images?.logoSizes)!
				config.backdropSizes = (configuration.images?.backdropSizes)!
				config.posterSizes = (configuration.images?.posterSizes)!
				config.secureBaseUrl = configuration.images?.secureBaseUrl
				config.stillSizes = (configuration.images?.stillSizes)!
				config.profileSizes = (configuration.images?.profileSizes)!
				
				try managedOC.save()
			}
		}
    }
}
