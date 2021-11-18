//
//  NetworkClientProtocol.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/18/21.
//

import Foundation
import Combine

protocol NetworkClientRepresentable {
	var session: URLSession { get }
	
	func execute<Response: Codable>(type: Response.Type, networkRequest: JSONNetworkRequest) -> AnyPublisher<Response, Error>
}
