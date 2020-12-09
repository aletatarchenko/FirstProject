//
//  AppFlow.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import RxFlow
import RxCocoa

final class AppFlow: Flow {

  var root: Presentable {
    rootWindow
  }

  private let rootWindow: UIWindow
  private let appServices: AppServices

  // MARK: - Initialization
  init(window: UIWindow, appServices: AppServices) {

    self.rootWindow = window
    self.appServices = appServices
  }

  func navigate(to step: Step) -> FlowContributors {

    guard let appStep = step as? AppStep else { return .none }

    switch appStep {
    case .main:
      return navigateToMain()
    }
  }

  private func navigateToMain() -> FlowContributors {

    let mainFlow = MainFlow(service: appServices)

    Flows.use(mainFlow, when: .created) { [unowned self] (root) in

      (self.rootWindow.rootViewController as? UINavigationController)?.setViewControllers([], animated: false)
      self.rootWindow.rootViewController = root
      self.rootWindow.makeKeyAndVisible()
    }

    return .one(flowContributor: .contribute(withNextPresentable: mainFlow,
                                             withNextStepper: OneStepper(withSingleStep: MainStep.programs)))
  }
}

class AppStepper: Stepper {

  let steps = PublishRelay<Step>()

  var initialStep: Step { AppStep.main }
}
