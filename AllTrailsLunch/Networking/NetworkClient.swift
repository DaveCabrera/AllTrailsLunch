//
//  NetworkClient.swift
//  AllTrailsLunch
//
//  Created by David Cabrera on 11/18/21.
//

import Foundation
import Combine

public final class NetworkClient: NetworkClientRepresentable {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
	func execute<Response: Codable>(type: Response.Type, networkRequest: JSONNetworkRequest) -> AnyPublisher<Response, Error> {
		session.dataTaskPublisher(for: networkRequest.asURLRequest())
			.map(\.data)
			.decode(type: Response.self, decoder: networkRequest.decoder)
            .eraseToAnyPublisher()
    }
}
