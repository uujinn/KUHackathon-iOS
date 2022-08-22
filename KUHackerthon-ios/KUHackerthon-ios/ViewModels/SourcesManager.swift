//
//  SourcesManager.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation
import Alamofire
import Combine

enum SourcesManager: URLRequestConvertible {
  
  case getSources
  case postSources(ids: [Int], filename: String)
  
  var baseURL: URL {
    switch self {
    case .postSources:
      return URL(string: "http://54.215.106.122/edit")!
    case .getSources:
      return URL(string: "http://54.215.106.122/sources")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getSources:
      return .get
    case .postSources:
      return .post
      
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    switch self {
    case .postSources:
      headers["accept"] = "application/json"
//      headers["Content-Type"] = "application/json"
    case .getSources:
      return headers

    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()
    
    switch self {

    case let .getSources:
      return params
    case .postSources(ids: let ids, filename: let filename):
      params["ids"] = ids
      params["filename"] = filename
      return params
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    switch self {
    case .getSources:
      request = try URLEncoding.default.encode(request, with: nil)
    case .postSources:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
      print(parameters)
    }
    
    return request
  }
}

