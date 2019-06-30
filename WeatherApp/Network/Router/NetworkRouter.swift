//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

public class NetworkRouter<Service: ServiceType>: NetworkRoutable {
    private let session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func request<T>(type:T.Type, route: Service, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(request: request, completionHandler: { [weak self] (data, response, error) in
                let httpResponse = response as? HTTPURLResponse
                DispatchQueue.main.async {
                    self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
                }
            })
        } catch {
            completion(.failure(.failed))
        }

        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    // MARK: - Helper

    private func buildRequest(from route: Service) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.method.rawValue
        
        do {
            switch route.task {
            case .request:
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            case .requestParameters(bodyParameters: let bodyParameters,
                                    urlParameters: let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)

            case .requestParametersWithHeaders(bodyParameters: let bodyParameters,
                                               urlParameters: let urlParameters,
                                               additionHeaders: let additionHeaders):
                addHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func addHeaders(_ headers: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> ()) {
        guard error == nil else {
            return completion(.failure(.unknown))
        }

        guard let response = response else {
            return completion(.failure(.noResponse))
        }
        
        switch response.statusCode {
        case 200...299:
            guard let responseData = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                print(jsonData)

                let model = try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(model))
            } catch {
                completion(.failure(.unableToDecode))
            }

        case 401...500: return completion(.failure(.authenticationError))
        case 501...599: return completion(.failure(.badRequest))
        case 600: return completion(.failure(.outdated))
        default: return completion(.failure(.failed))
        }
    }
}
