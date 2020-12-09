//
//  UIViewController+Extension.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 09.12.2020.
//

import RxAlertController
import RxSwift

protocol RxAlertControllerItem {
  var alertButton: UIAlertController.AlertButton { get }
}

extension UIViewController {
  func showErrorAlert(message: String) -> Single<AlertControllerItem> {
    showAlertController(title: "", message: message, items: [.ok])
  }

  private func showAlertController<Item: RxAlertControllerItem>(
    title: String,
    message: String,
    items: [Item]
  ) -> Single<Item> {
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )

    return alertController.rx.show(in: self, buttons: items.map { $0.alertButton })
      .map { items[$0] }
      .asObservable()
      .asSingle()
  }
}

enum AlertControllerItem: RxAlertControllerItem {
  case cancel
  case delete
  case yes
  case no
  case ok
  case confirm
  case `continue`

  var alertButton: UIAlertController.AlertButton {
    switch self {
    case .confirm:
      return .default("Confirm")
    case .ok:
      return .default("Ok")
    case .cancel:
      return .cancel("Cancel")
    case .delete:
      return .destructive("Delete")
    case .yes:
      return .default("Yes")
    case .no:
      return .cancel("No")
    case .continue:
      return .default("Continue")
    }
  }
}
