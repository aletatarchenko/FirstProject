//
//  Constants.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Foundation

class Constants {

  static let baseURL: URL = {
    guard let urlString = Bundle.main.infoDictionary?.value(typeOf: String.self, forKey: "API_BASE_URL"),
          let url = URL(string: urlString) else {
      fatalError()
    }
    return url
  }()
}
