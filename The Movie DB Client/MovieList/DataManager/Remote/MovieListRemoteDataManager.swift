//
//  MovieListRemoteDataManager.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 17/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import Alamofire

class MovieListRemoteDataManager: MovieListRemoteDataManagerInputProtocol {
	var remoteUpcomingRequestHandler: UpcomingMovieOutputProtocol?
	var remoteTMDbConfigurationRequestHandler: TMDbApiConfigurationOutputProtocol?

	func getUpcomingReleases(forPageAt page: Int = 1) {
		if page == 1 {
			Alamofire
				.request(Endpoints.ApiConfiguration.fetch.url, method: .get)
				.validate()
				.responseJSON { response in
					switch response.result {
					case .failure(let error):
						self.remoteUpcomingRequestHandler?.onError()
					case .success:
						if let json = response.result.value {
							if let data = try? JSONSerialization.data(withJSONObject: json) {
								let configuration = try? JSONDecoder().decode(TMDbApiConfigurationResponse.self, from: data)
								self.getUpcomingReleases(forPageAt: page, withConfiguration: configuration)
							}
						}
					}
			}
		} else {
			getUpcomingReleases(forPageAt: page, withConfiguration: nil)
		}
	}

	func getUpcomingReleases(forPageAt page: Int, withConfiguration configuration: TMDbApiConfigurationResponse?) {
		let parameters = ["page": page]

		Alamofire
			.request(Endpoints.UpcomingMovie.fetch.url, method: .get, parameters: parameters)
			.validate()
			.responseJSON { response in
				switch response.result {
				case .failure(let error):
					self.remoteUpcomingRequestHandler?.onError()
				case .success:
					if let json = response.result.value {
						if let data = try? JSONSerialization.data(withJSONObject: json) {
							let movieUpcomingResponse = try? JSONDecoder().decode(MovieUpcomingResponse.self, from: data)
							self.remoteUpcomingRequestHandler?.onUpcomingMovieRetrieved(movieUpcomingResponse!, configuration)
						}
					}
				}
		}
	}

	func getTMDbApiConfiguration() {
		Alamofire
			.request(Endpoints.ApiConfiguration.fetch.url, method: .get)
			.validate()
			.responseJSON { response in
				switch response.result {
				case .failure(let error):
					self.remoteTMDbConfigurationRequestHandler?.onError()
				case .success:
					if let json = response.result.value {
						if let data = try? JSONSerialization.data(withJSONObject: json) {
							let configuration = try? JSONDecoder().decode(TMDbApiConfigurationResponse.self, from: data)
							self.remoteTMDbConfigurationRequestHandler?.onTMDbApiConfigurationRetrieved(configuration!)
						}
					}
				}
		}
	}
}
