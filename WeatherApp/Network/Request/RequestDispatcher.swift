//
//  RequestDispatcher.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//
import Foundation

class RequestDispatcher {

    class func request<T: Codable>(apiRouter: Router) async throws -> T {
        
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        components.queryItems = apiRouter.parameters
        
        guard let url = components.url else {
            throw NetworkError.badUrl
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRouter.method
        let session = URLSession(configuration: .default)
        
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return continuation.resume(with: .failure(error))
                }

                guard let data = data else {
                    return continuation.resume(with: .failure(NetworkError.noData))
                }

                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    return continuation.resume(with: .failure(error))
                }
            }
            dataTask.resume()
        }
    }
}

