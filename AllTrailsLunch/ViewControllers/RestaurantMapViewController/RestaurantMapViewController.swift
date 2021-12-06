//
//  RestaurantMapViewController.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/5/21.
//

import UIKit
import Combine
import MapKit

class RestaurantMapViewController: UIViewController {
	var viewModel: RestaurantMapViewController.ViewModel!
	private var cancellables: Set<AnyCancellable> = []
	
	@IBOutlet weak var mapView: MKMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		mapView.showsUserLocation = true
		mapView.delegate = self
		
		viewModel
			.$region
			.sink { [weak self] region in
				self?.mapView.setRegion(region, animated: true)
			}
			.store(in: &cancellables)
		
		viewModel
			.$restaurantAnnotations
			.sink { [weak self] annotations in
				self?.mapView.addAnnotations(annotations)
			}
			.store(in: &cancellables)
    }
}

extension RestaurantMapViewController: MKMapViewDelegate {
	
}
