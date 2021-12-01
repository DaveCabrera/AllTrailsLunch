//
//  LocationManager.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/30/21.
//

import Foundation

import Combine
import CoreLocation

class LocationManger: NSObject {
	@Published var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
	
	private let locationManger: CLLocationManager
	private var cancellables: Set<AnyCancellable> = []
	
	init(locationManager: CLLocationManager = CLLocationManager()) {
		self.locationManger = locationManager
		super.init()
		self.locationManger.delegate = self
		self.locationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
	}
	
	func requestAuthorization() {
		locationManger.requestAlwaysAuthorization()
	}
}

extension LocationManger: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let currentLocation = locations.last else {
			return
		}
		self.currentLocation = currentLocation.coordinate
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .notDetermined:
			// do nothing
			break
		case .restricted:
			break
		case .denied:
			// TODO - Update for error states
			break
		case .authorizedAlways, .authorizedWhenInUse, .authorized:
			print("I have authorization")
			manager.requestLocation()
		@unknown default:
			// TODO -
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error: \(error)")
	}
}
