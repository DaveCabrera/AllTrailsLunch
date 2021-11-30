//
//  Place.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/18/21.
//

import Foundation

struct NearbySearchResponse: Codable {
	let htmlAttributions: [String]
	let nextPageToken: String?
	let results: [PlaceResponse]
	let status: String
}

struct PlaceResponse: Codable {
	struct Geometry: Codable {
		struct Location: Codable {
			let latitude: Double
			let lognitude: Double
			
			enum CodingKeys: String, CodingKey {
				case latitude = "lat"
				case lognitude = "lng"
			}
		}
		
		let location: Location
	}
	
	let name: String
	let placeId: String
	let rating: Decimal
	let geometry: Geometry
}
