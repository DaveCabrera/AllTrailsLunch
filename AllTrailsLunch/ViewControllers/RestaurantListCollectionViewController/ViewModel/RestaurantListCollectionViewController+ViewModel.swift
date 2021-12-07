//
//  RestaurantListCollectionViewController+ViewModel.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/2/21.
//

import Foundation
import Combine

extension RestaurantListCollectionViewController {
	class ViewModel {
		struct Restaurant {
			struct Location {
				let latitude: Double
				let longitude: Double
			}
			
			let id: String
			let name: String
			let supportingText: String
			let rating: Double
			let iconURL: URL?
		}
		
		@Published var restauraunts: [Restaurant] = []
		
		private let dataProvider: NearbySearchResultsDataProvider
		private var cancellables: Set<AnyCancellable> = []
		
		init(dataProvider: NearbySearchResultsDataProvider) {
			self.dataProvider = dataProvider
			
			self.dataProvider.$placeResults
				.sink { placeResponse in
					self.restauraunts = placeResponse.map { Restaurant(id: $0.placeId ?? UUID().description,
																	   name: $0.name ?? "Placeholder Name",
																	   supportingText: $0.formattedAddress ?? "",
																	   rating: $0.rating ?? Double(0),
																	   iconURL: URL(string: $0.icon ?? ""))}
					print("The restaurants: \(self.restauraunts)")
				}
				.store(in: &cancellables)
		}
	}
}
