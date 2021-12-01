//
//  CLLocationCoordinate2D+Equatable.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/1/21.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
	public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
	}
}
