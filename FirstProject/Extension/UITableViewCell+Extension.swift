//
//  UITableViewCell+Extension.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import UIKit

extension UITableViewCell {
  static var id: String {
    String(describing: self)
  }
  
  static var nib: UINib {
    UINib(nibName: id, bundle: nil)
  }
}
