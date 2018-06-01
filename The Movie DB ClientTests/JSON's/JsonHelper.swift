//
//  JsonHelper.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante Filho on 30/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
@testable import The_Movie_DB_Client

public class JsonHelper {

    public func loadGetUpcomingResponseJsonData() -> Data {
        let bundle = Bundle(for: type(of: self))

        let path = bundle.path(forResource: "get_upcoming", ofType: "json")

        return try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    }

    public func loadGetUpcomingResponseJson() -> MovieUpcomingResponse {
        let data = self.loadGetUpcomingResponseJsonData()

        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

        let jsonData = try! JSONSerialization.data(withJSONObject: jsonResult)

        return try! JSONDecoder().decode(MovieUpcomingResponse.self, from: jsonData)

    }

    public func loadGetApiConfigurationResponseJsonData() -> Data {
        let bundle = Bundle(for: type(of: self))

        let path = bundle.path(forResource: "get_api_configuration", ofType: "json")

        return try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    }

    public func loadGetApiConfigurationResponseJson() -> TMDbApiConfigurationResponse {
        let data = self.loadGetApiConfigurationResponseJsonData()

        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

        let jsonData = try! JSONSerialization.data(withJSONObject: jsonResult)

        return try! JSONDecoder().decode(TMDbApiConfigurationResponse.self, from: jsonData)
    }
}
