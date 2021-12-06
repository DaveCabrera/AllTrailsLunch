//
//  RestaurantListCollectionViewController.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 12/2/21.
//

import UIKit
import Combine

private let reuseIdentifier = "restaurantItem"

class RestaurantListCollectionViewController: UICollectionViewController {
	var viewModel: ViewModel!
	private var cancellables: Set<AnyCancellable> = []
    
	override func viewDidLoad() {
        super.viewDidLoad()

		collectionView.register(UINib(nibName:"RestaurantItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:reuseIdentifier)

		viewModel
			.$restauraunts
			.sink { [weak self] _ in
				self?.collectionView.reloadData()
			}
			.store(in: &cancellables)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.restauraunts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let value = viewModel.restauraunts[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RestaurantItemCollectionViewCell
		cell.restaurantNameLabel.text = value.name
		cell.supportingTextLabel.text = value.supportingText
		
		return cell
    }
}
