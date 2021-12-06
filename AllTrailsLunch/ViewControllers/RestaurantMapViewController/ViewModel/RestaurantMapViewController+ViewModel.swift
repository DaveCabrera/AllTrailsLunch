//
//  RestaurantMapViewController+ViewModel.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/6/21.
//

import Foundation
import Combine
import MapKit

extension RestaurantMapViewController {
	class ViewModel {
		let dataProvider: NearbySearchResultsDataProvider
		
		@Published var region: MKCoordinateRegion = MKCoordinateRegion()
		@Published var restaurantAnnotations: [MKPointAnnotation] = []
		
		private var cancellables: Set<AnyCancellable> = []
		
		init(dataProvider: NearbySearchResultsDataProvider) {
			self.dataProvider = dataProvider
			
			dataProvider.locationManager
				.$currentLocation
				.sink { [weak self] location in
					self?.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
				}
				.store(in: &cancellables)
			
			dataProvider
				.$placeResults
				.sink { [weak self] values in
					self?.restaurantAnnotations = values.compactMap { $0.geometry }.map {
						let annotation = MKPointAnnotation()
						annotation.coordinate = CLLocationCoordinate2D(latitude: $0.location.latitude, longitude: $0.location.lognitude)
						return annotation
					}
				}
				.store(in: &cancellables)
		}
	}
}
