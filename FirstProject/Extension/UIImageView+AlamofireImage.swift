//
//  UIImageView+AlamofireImage.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import UIKit.UIImageView
import AlamofireImage

extension UIImageView {
  func setupImageWith(_ url: URL) {
    af.setImage(withURL: url)
  }
}
