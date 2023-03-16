//
//  URLSessionHTTPClient.swift
//  nCoffee
//
//  Created by Yago Marques on 09/03/23.
//

import Foundation

protocol HTTPClient {
    func request(endpoint: EndpointProtocol, completion: @escaping (Result<Data, APICallError>) -> Void)
}

final class URLSessionHTTPClient: HTTPClient {

    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request(endpoint: EndpointProtocol, completion: @escaping (Result<Data, APICallError>) -> Void) {
        do {
            let request = try endpoint.makeRequest()

            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.network(error)))
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.invalidUrl))
                    return
                }

                switch response.statusCode {
                case 200...300:
                    if let data = data {
                        completion(.success(data))
                    }
                default:
                    completion(.failure(.httpError(code: response.statusCode)))
                }
            }

            task.resume()
        } catch {
            completion(.failure(error as! APICallError))
        }
    }

    func request(endpoint: EndpointProtocol) async throws -> Data? {
        do {
            let request = try endpoint.makeRequest()

            let (data, response) = try await session.data(for: request)

            guard let response = response as? HTTPURLResponse else { return nil }
            switch response.statusCode {
            case 200...300:
                return data
            default:
                return nil
            }
        } catch {
            throw error
        }
    }
}
