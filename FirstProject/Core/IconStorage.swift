//
//  IconStorage.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Foundation
import UIKit.UIImage

enum IconStorage {
  
  //MARK: - Player
  enum Player {
    static let play = UIImage(named: "ic_play")
    static let pause = UIImage(named: "ic_pause")
  }
}

// MARK: - Private helpers
private extension String {
  func toImage() -> UIImage? {
    let image = UIImage(named: self)
    #if DEBUG
    assert(image != nil, "Couldn't find image in catalog with name: \(self)")
    #endif

    return image
  }
}
