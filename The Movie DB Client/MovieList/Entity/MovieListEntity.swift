//
//  MovieListEntity.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 19/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

struct MovieListEntity {
	
	public let page: Int?
	public let totalResults: Int?
	public let dates: Dates?
	public let totalPages: Int?
	public let movies: [MovieEntity]?
	public let configuration: ConfigurationEntity?
	
	public struct Dates {
		public let maximum: String?
		public let minimum: String?
	}
	
	init(fromUpcomingResponse movieUpcomingResponse: MovieUpcomingResponse, fromConfiguration configuration: ConfigurationEntity?) {
		self.page = movieUpcomingResponse.page
		self.totalResults = movieUpcomingResponse.totalResults
		self.dates = Dates(maximum: movieUpcomingResponse.dates?.maximum, minimum: movieUpcomingResponse.dates?.minimum)
		self.totalPages = movieUpcomingResponse.totalPages
		self.movies = movieUpcomingResponse.results.map { movieUpcomingResponseResult in
			return MovieEntity(movieUpcomingResponseResult, configuration)
		}
		self.configuration = configuration
	}
}
