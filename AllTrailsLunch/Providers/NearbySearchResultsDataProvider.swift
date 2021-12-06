//
//  RestaurantDataProvider.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/6/21.
//

import Foundation
import Combine

class NearbySearchResultsDataProvider {
	private let networkClient: NetworkClientRepresentable
	private var cancellables: Set<AnyCancellable> = []
	
	let locationManager: LocationManger
	@Published var placeResults: [NearbySearchResponse.PlaceResponse] = []
	
	init(networkClient: NetworkClientRepresentable = NetworkClient(), locationManager: LocationManger = LocationManger()) {
		self.networkClient = networkClient
		self.locationManager = locationManager
		
		self.locationManager
			.$currentLocation
			.dropFirst()
			.print()
			.removeDuplicates()
			.flatMap { location -> AnyPublisher<NearbySearchResponse, Error> in
				let location = GetNearbyPlacesNetworkRequest.Location(latitude: location.latitude, longitdue: location.longitude)
				let request = GetNearbyPlacesNetworkRequest(location: location)
				return self.networkClient.execute(type: NearbySearchResponse.self, networkRequest: request)
			}
			.receive(on: RunLoop.main)
			.map(\.results)
			.sink { completion in
				switch completion {
				case .failure(let error):
					print("There was an error: \(error)")
				case .finished:
					print("Finished")
				}
			} receiveValue: { placeResponse in
				self.placeResults = placeResponse
			}
			.store(in: &cancellables)

		self.locationManager.requestAuthorization()
	}
}
