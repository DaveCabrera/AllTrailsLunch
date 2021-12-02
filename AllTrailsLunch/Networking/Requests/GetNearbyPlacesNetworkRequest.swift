//
//  GetPlacesNetworkRequest.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/18/21.
//

import Foundation

struct GetNearbyPlacesNetworkRequest: JSONNetworkRequest {
	struct Location {
		let latitude: Double
		let longitdue: Double
	}
	
	enum PlaceType: String {
		case restaurant
	}
	
    var path: String {
        return "/maps/api/place/nearbysearch/json"
    }
	
	var method: URLRequest.Method {
		return .get
	}
	
	var queryItems: [URLQueryItem]? {
		return nil
	}
	
	var percentEncodedQueryItems: [URLQueryItem]? {
		return [URLQueryItem(name: "type", value: placeType.rawValue),
				URLQueryItem(name: "location", value: "\(location.latitude)%2C\(location.longitdue)"),
				URLQueryItem(name: "radius", value: "1500"), // Docs say only location is req but both location + radius are
				URLQueryItem(name: "key", value: apiKey)]
	}
	
	var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}
    
	let apiKey: String
    let location: Location
	let placeType: PlaceType
	
	init(apiKey: String = "AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE", location: Location, type: PlaceType = .restaurant) {
		self.apiKey = apiKey
        self.location = location
		self.placeType = type
    }
}
