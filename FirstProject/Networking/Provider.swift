//
//  Provider.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Alamofire
import Moya

let API = MoyaProvider<FirstProjectTarget>(plugins: [])

enum FirstProjectTarget {

  //MARK: - fetch programs
  case fetchPograms(cache: Bool = false)
}

extension FirstProjectTarget: TargetType {

  var baseURL: URL { Constants.baseURL }

  var sampleData: Data { Data() }

  var headers: [String: String]? { nil }

  var validationType: ValidationType { .successAndRedirectCodes }

  var path: String {
    switch self {
    case .fetchPograms:
      return "/api/v2/media-library/free"
    }
  }

  var method: Moya.Method {
    switch self {
    case .fetchPograms:
      return .get
    }
  }

  var task: Moya.Task {
    switch self {
    case let .fetchPograms(cache):
      let params = ["resetCache": "\(cache)"] as [String : Any]
      return .requestParameters(parameters: params,
                                encoding: URLEncoding.default)
    }
  }
}
