//
//  AppServices.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Foundation

protocol AppServices {
  func projectService() -> ProjectService
}

final class AppServicesImp: AppServices {

  func projectService() -> ProjectService {
    ProjectServiceImp()
  }
}
