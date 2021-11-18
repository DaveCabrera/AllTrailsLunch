//
//  GetPlacesNetworkRequest.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/18/21.
//

import Foundation

struct GetNearbyPlacesNetworkRequest: JSONNetworkRequest {
	struct Location: CustomStringConvertible {
		let latitude: Double
		let longitdue: Double
		
		var description: String {
			return latitude.description + longitdue.description
		}
	}
	
	enum PlaceType: String {
		case restaurant
	}
	
    var path: String {
        return "maps/api/place/nearbysearch/json"
    }
	
	var method: URLRequest.Method {
		return .get
	}
	
	var queryItems: [URLQueryItem] {
		return [URLQueryItem(name: "type", value: placeType.rawValue),
				URLQueryItem(name: "location", value: location.description),
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
	
	init(apiKey: String, location: Location, type: PlaceType = .restaurant) {
		self.apiKey = apiKey
        self.location = location
		self.placeType = type
    }
}
