//
//  ProjectService.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import RxSwift

protocol ProjectService {
  func feetchPrograms() -> Single<ProgramsResponse>
}

final class ProjectServiceImp: ProjectService {

  func feetchPrograms() -> Single<ProgramsResponse> {
    API.rx.request(.fetchPograms())
      .map(ProgramsResponse.self)
  }
}
