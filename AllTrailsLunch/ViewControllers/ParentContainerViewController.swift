//
//  ParentContainerViewController.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/2/21.
//

import UIKit
import MapKit

class ParentContainerViewController: UIViewController {
	private let nearbySearchResultsDataProvider = NearbySearchResultsDataProvider()
	
	@IBOutlet private weak var headerNavView: UIView!
	@IBOutlet private weak var viewTypeButton: UIButton!
	
	enum ViewType {
		case list
		case map
		
		var nextType: ViewType {
			switch self {
			case .list:
				return .map
			case .map:
				return .list
			}
		}
		
		var image: UIImage {
			switch self {
			case .list:
				return UIImage(systemName: "list.bullet")!
			case .map:
				return UIImage(named: "mapPin")!
			}
		}
		
		var title: String {
			switch self {
			case .list:
				return NSLocalizedString("List", comment: "")
			case .map:
				return NSLocalizedString("Map", comment: "")
			}
		}
	}
	
	private lazy var restaurantListCollectionVeiwController: RestaurantListCollectionViewController = {
		let storyboard = UIStoryboard(name: "RestaurantListCollectionViewController", bundle: Bundle.main)
		let vc = storyboard.instantiateInitialViewController() as! RestaurantListCollectionViewController
		vc.viewModel = RestaurantListCollectionViewController.ViewModel(dataProvider: nearbySearchResultsDataProvider)
		return vc
	}()
	
	private lazy var restaurantMapViewController: RestaurantMapViewController = {
		let storyboard = UIStoryboard(name: "RestaurantMapViewStoryboard", bundle: Bundle.main)
		let vc = storyboard.instantiateInitialViewController() as! RestaurantMapViewController
		vc.viewModel = RestaurantMapViewController.ViewModel(dataProvider: nearbySearchResultsDataProvider)
		return vc
	}()
	
	private var nextViewType: ViewType = .map
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        swapViewControllers()
    }
    
	@IBAction func didTapPrimaryButton(_ sender: UIButton) {
		swapViewControllers()
	}
}

private extension ParentContainerViewController {
	func swapViewControllers() {
		viewTypeButton.setTitle(nextViewType.title, for: .normal)
		viewTypeButton.setImage(nextViewType.image, for: .normal)
		
		let nextType = nextViewType.nextType
		switch nextType {
		case .list:
			removeChild(restaurantMapViewController)
			addChildVC(restaurantListCollectionVeiwController)
		case .map:
			removeChild(restaurantListCollectionVeiwController)
			addChildVC(restaurantMapViewController)
		}
		nextViewType = nextType
	}
	
	func addChildVC(_ vc: UIViewController) {
		addChild(vc)
		view.addSubview(vc.view)
		view.bringSubviewToFront(headerNavView)
		view.bringSubviewToFront(viewTypeButton)
		
		vc.view.translatesAutoresizingMaskIntoConstraints = false
		vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		vc.view.topAnchor.constraint(equalTo: headerNavView.bottomAnchor).isActive = true
		vc.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		vc.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

		
		vc.didMove(toParent: self)
	}
	
	func removeChild(_ vc: UIViewController) {
		vc.willMove(toParent: nil)
		vc.view.removeFromSuperview()
		vc.removeFromParent()
	}
}
