//
//  ViewController+ViewModel.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/1/21.
//

import Combine
import CoreLocation

extension ViewController {
	class ViewModel {
		struct Restaurant {
			struct Location {
				let latitude: Double
				let longitude: Double
			}
			
			let id: String
			let name: String
			let supportingText: String = NSLocalizedString("Supporting Text", comment: "")
			let rating: Double
			let iconURL: URL?
		}
		
		@Published var restauraunts: [Restaurant] = []
		
		private let networkClient: NetworkClientRepresentable
		private let locationManager: LocationManger
		private var cancellables: Set<AnyCancellable> = []
		
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
				.map(\.results)
				.sink { completion in
					switch completion {
					case .failure(let error):
						print("There was an error: \(error)")
					case .finished:
						print("Finished")
					}
				} receiveValue: { placeResponse in
					self.restauraunts = placeResponse.map { Restaurant(id: $0.placeId ?? UUID().description,
																  name: $0.name ?? "Placeholder Name",
																  rating: $0.rating ?? Double(0),
																  iconURL: URL(string: $0.icon ?? ""))}
					print("The restaurants: \(self.restauraunts)")
				}
				.store(in: &cancellables)

			self.locationManager.requestAuthorization()
		}
	}
}
