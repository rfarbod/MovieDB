//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation

typealias ReaquestHeaders = [String: String]
typealias RequestParameters = [String: Any]
typealias RequestBody = [String: Any?]

enum RequestMethod: String { case get = "GET" }
enum RequestType { case data }
enum ResponseType { case json }

let baseUrl = "https://api.themoviedb.org/3"
let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNTA5OTU3YzkyZThiNWQ1ODMxZTllYTI4YjI4Njc2NiIsInN1YiI6IjY2MmZjN2IxNjlkMjgwMDEyMzQzOTBkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WIoztE5UxssrXbstmj4lf-cJ3hiHfN765_B5pebQemE"

protocol RequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: RequestParameters? { get }
    var authorizationToken: String { get }
    var timeoutInterval: TimeInterval { get }
    var retryDelay: UInt64 { get }
}

extension RequestProtocol {
    var baseURL: String { baseUrl }
    var method: RequestMethod { .get }
    var requestType: RequestType { .data }
    var responseType: ResponseType { .json }
    var authorizationToken: String { "Bearer \(token)" }
    var timeoutInterval: TimeInterval { 30.0 }
    var retryDelay: UInt64 { 1_000_000_000 }

    private var queryItems: [URLQueryItem]? {
        guard let parameters = parameters else {
            return nil
        }
        return parameters.map { (key: String, value: Any) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }

    private func url() -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

    func urlRequest() -> URLRequest? {
        guard let url = url() else {
            return nil
        }
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue
        request.setValue(authorizationToken, forHTTPHeaderField: "Authorization")
        request.cachePolicy = .returnCacheDataElseLoad
        return request
    }

    func verifyResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 401:
            throw APIError.authorizationError
        case 400...499:
            throw APIError.badRequest
        case 500...599:
            throw APIError.serverError
        default:
            throw APIError.unknown
        }
    }
}
