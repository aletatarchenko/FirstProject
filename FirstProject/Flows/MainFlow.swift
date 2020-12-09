//
//  MainFlow.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import RxFlow

final class MainFlow: Flow {

  lazy private(set) var navigationController = UINavigationController()

  private let service: AppServices

  var root: Presentable {
    navigationController
  }
  
  // MARK: - Initialization
  init(service: AppServices) {
    self.service = service
  }

  func navigate(to step: Step) -> FlowContributors {
    guard let mainStep = step as? MainStep else { return .none }

    switch mainStep {
    case .programs:
      return navigateToProgram()
    }
  }

  private func navigateToProgram() -> FlowContributors {

    let homeFlow = ProgramFlow(navigationController: navigationController, appServices: service.projectService())

    return .one(flowContributor: .contribute(withNextPresentable: homeFlow,
                                             withNextStepper: OneStepper(withSingleStep: ProgramStep.homePage)))
  }

  deinit {
    print(#function, type(of: self))
  }
}
