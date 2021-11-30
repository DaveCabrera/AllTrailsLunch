//
//  NetworkRequestProtocol.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/18/21.
//

import Foundation
import UIKit

protocol NetworkRequest {
	var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: URLRequest.Method { get }
	var queryItems: [URLQueryItem]? { get }
	var percentEncodedQueryItems: [URLQueryItem]? { get }
	var url: URL? { get }
	
	func asURLRequest() -> URLRequest
}


extension NetworkRequest {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "maps.googleapis.com"
    }
	
    var method: URLRequest.Method {
        return .post
    }
	
	var url: URL? {
		var components = URLComponents()
		components.scheme = scheme
		components.host = host
		components.path = path
		
		if let queryItems = queryItems {
			components.queryItems = queryItems
		}
		else if let percentEncodedQueryItems = percentEncodedQueryItems {
			components.percentEncodedQueryItems = percentEncodedQueryItems

		}
		
		guard let builtURL = components.url else {
			assertionFailure("Invalid URL Built")
			return nil
		}

		return builtURL
	}
	
	func asURLRequest() -> URLRequest {
		var request = URLRequest(url: url!)
		request.httpMethod = method.rawValue
		return request
	}
}

protocol JSONNetworkRequest: NetworkRequest {
	var decoder: JSONDecoder { get }
}
