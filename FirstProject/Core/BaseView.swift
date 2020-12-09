//
//  BaseView.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 07.12.2020.
//

import UIKit

class BaseView: UIView {
  // MARK: - Properties

  private var isXibSetup = false

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  deinit {
    print(#function, type(of: self))
  }
  
  // MARK: - Private functions

  private func setup() {
    guard isXibSetup == false else {
      return
    }

    // Initialization of file owner
    let xibName = String(describing: type(of: self))
    let nib = UINib(nibName: xibName, bundle: nil)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }

    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)

    isXibSetup = true
  }
}
