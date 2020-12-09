//
//  Extension.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    func value<T>(typeOf: T.Type, forKey key: String) -> T? {
    self[key] as? T
  }
}
