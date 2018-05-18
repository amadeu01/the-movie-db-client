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
    var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol?
    
    func searchMovie(forName name: String) {
    
    }
    
    func getNextMoviesReleases() {
        Alamofire
            .request(Endpoints.UpcomingMovie.fetch.url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .failure(_ ):
                    self.remoteRequestHandler?.onError()
                case .success(_):
                    if let json = response.result.value {
                        if let data = try? JSONSerialization.data(withJSONObject: json) {
                            let movieUpcomingResponse = try? JSONDecoder().decode(MovieUpcomingResponse.self, from: data)
                            self.remoteRequestHandler?.onUpcomingMovieRetrieved(movieUpcomingResponse!)
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
                case .failure(_ ):
                    self.remoteRequestHandler?.onError()
                case .success(_):
                    if let json = response.result.value {
                        if let data = try? JSONSerialization.data(withJSONObject: json) {
                            let configuration = try? JSONDecoder().decode(TMDbApiConfigurationResponse.self, from: data)
                            self.remoteRequestHandler?.onTMDbApiConfigurationRetrieved(configuration!)
                        }
                    }
                }
        }
    }
}
