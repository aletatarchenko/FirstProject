//
//  ProgramFlow.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import RxFlow

final class ProgramFlow: Flow {

  private var navigationController: UINavigationController

  private var service: ProjectService

  var root: Presentable {
    navigationController
  }
  
  // MARK: - Initialization
  init(navigationController: UINavigationController, appServices: ProjectService) {
    self.navigationController = navigationController
    self.service = appServices
  }

  func navigate(to step: Step) -> FlowContributors {

    guard let programStep = step as? ProgramStep else { return .none }

    switch programStep {
    case .homePage:
      return navigateToHome()
    case let .tracks(program):
      return navigateToProgram(program)
    }
  }

  private func navigateToHome() -> FlowContributors {

    let viewModel = ProgramViewModelImp(service: service)
    let viewController = ProgramViewController(viewModel: viewModel)
    viewController.title = "Program"
    navigationController.show(viewController, sender: nil)
    return .one(flowContributor: .contribute(withNextPresentable: viewController,
                                             withNextStepper: viewModel))
  }

  private func navigateToProgram(_ program: Program) -> FlowContributors {

    let viewModel = TracksViewModelImp(program)
    let viewController = TracksTableViewController(viewModel: viewModel)
    viewController.title = program.title
    navigationController.show(viewController, sender: nil)

    return .one(flowContributor: .contribute(withNextPresentable: viewController,
                                             withNextStepper: OneStepper(withSingleStep: ProgramStep.tracks(program))))
  }

  deinit {
    debugPrint(#function, type(of: self))
  }
}

