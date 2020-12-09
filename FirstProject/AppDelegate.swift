//
//  AppDelegate.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 04.12.2020.
//

import NSObject_Rx
import RxCocoa
import RxFlow
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private let coordinator = FlowCoordinator()

  lazy private var appFlow = { AppFlow(window: self.window!, appServices: AppServicesImp()) }()
  lazy private var appStepper = { AppStepper() }()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    coordinator.rx.didNavigate
      .subscribe(onNext: { (flow, step) in
        debugPrint("did navigate to flow=\(flow) and step=\(step)")
      })
      .disposed(by: rx.disposeBag)
    
    coordinator.coordinate(flow: appFlow,
                           with: appStepper)
    return true
  }
}

