//
//  GetCatsMainRequest.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//
import Foundation
import Alamofire
import GenericNetworkingLayer

final class GetCatsMainRequest: GenericWebServiceRequestable {

    // MARK: - PROPERTIES
    private let limit: Int

    // MARK: - INIT
    init(limit: Int) {
        self.limit = limit
    }

    // MARK: - PROTOCOL CONFORMANCE
    var baseUrl: String { "https://cataas.com/api" }
    var endPointPath: String { "/cats" }
    var method: Alamofire.HTTPMethod { .get }
    var headers: Alamofire.HTTPHeaders { HTTPHeaders() }
    var timeOut: Double { 30.0 }
    var queryItems: [URLQueryItem]? {[URLQueryItem(name: "limit",
                                                   value: limit.description)]}

}
