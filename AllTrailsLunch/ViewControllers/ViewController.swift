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
	let viewModel = ViewModel()
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
}

