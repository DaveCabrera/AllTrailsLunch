//
//  ViewController.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/18/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
	var client: NetworkClientRepresentable!
	var cancellables: Set<AnyCancellable> = []
	let manager = LocationManger()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		client = NetworkClient()
		
		manager
			.$currentLocation
			.dropFirst()
			.removeDuplicates()
			.sink { location in
				print(location)
			}
			.store(in: &cancellables)
        
		manager.requestAuthorization()
		
		// Do any additional setup after loading the view.
		client
			.execute(type: NearbySearchResponse.self, networkRequest: GetNearbyPlacesNetworkRequest(apiKey: "AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE", location: GetNearbyPlacesNetworkRequest.Location(latitude: -33.8670522, longitdue: 151.1957362)))
			.print()
			.map(\.results)
			.print()
			.sink { test in
				print(test)
			} receiveValue: { response in
				print(response)
			}
			.store(in: &cancellables)

    }


}

