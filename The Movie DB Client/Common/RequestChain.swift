//
//  RequestChain.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 19/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import Alamofire

class RequestChain {
	typealias CompletionHandler = (_ success: Bool, _ errorResult: ErrorResult?) -> Void

	struct ErrorResult {
		let request: DataRequest?
		let error: Error?
	}

	fileprivate var requests: [DataRequest] = []

	init(requests: [DataRequest]) {
		self.requests = requests
	}

	func start(_ completionHandler: @escaping CompletionHandler) {
		if let request = requests.first {
			request.response(completionHandler: { (response: DefaultDataResponse) in
				if let error = response.error {
					completionHandler(false, ErrorResult(request: request, error: error))
					return
				}

				self.requests.removeFirst()
				self.start(completionHandler)
			})
			request.resume()
		} else {
			completionHandler(true, nil)
			return
		}

	}
}
