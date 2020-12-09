//
//  ProgramViewModel.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import RxFlow
import RxCocoa
import RxSwift
import RxDataSources

protocol ProgramViewModel {
  func showProgramWith(_ program: Program)
  var driveSection: Driver<[ProgramSection]> { get }
  var driveShowLoading: Driver<Bool> { get }
  var listIsEmpty: Driver<Bool> { get }
  var driveErrorDescription: Driver<String> { get }
  var loadPageTrigger: BehaviorRelay<()> { get set }
}

final class ProgramViewModelImp: ProgramViewModel {

  let steps = PublishRelay<Step>()

  private let service: ProjectService
  private let disposeBag = DisposeBag()

  var loadPageTrigger = BehaviorRelay<()>(value: ())

  private let sectionRelay = PublishRelay<[ProgramSection]>()
  var driveSection: Driver<[ProgramSection]> {
    sectionRelay.asDriver(onErrorJustReturn: [])
  }

  private let showLoadingRelay = BehaviorRelay<Bool>(value: true)
  var driveShowLoading: Driver<Bool> {
    showLoadingRelay.asDriver()
  }

  private let errorDescriptionRelay = PublishRelay<String>()
  var driveErrorDescription: Driver<String> {
    errorDescriptionRelay.asDriver(onErrorJustReturn: "Something went wrong")
  }

  var listIsEmpty: Driver<Bool> {
    sectionRelay.map { $0.isEmpty }.asDriver(onErrorJustReturn: true).map(!)
  }

  private func fetchPrograms() -> Single<[ProgramSection]>{
    service.fetchPrograms()
      .map { [ProgramSection(items: $0.programs.map { ProgramItem(program: $0 ) })]}
  }

  // MARK: - Initialization
  init(service: ProjectService) {
    self.service = service

    loadPageTrigger
      .flatMap { [unowned self] in self.fetchPrograms() }
      .do(onCompleted: { [unowned self] in self.showLoadingRelay.accept(false)})
      .subscribe(onNext: { [unowned self] in
        self.sectionRelay.accept($0)
        self.showLoadingRelay.accept(false)
      }, onError: { [unowned self] in
        self.errorDescriptionRelay.accept($0.localizedDescription)
        self.showLoadingRelay.accept(false)
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - Stepper
extension ProgramViewModelImp: Stepper {

  func showProgramWith(_ program: Program) {
    steps.accept(ProgramStep.tracks(program))
  }
}


struct ProgramSection: AnimatableSectionModelType {

  typealias Identity = Int
  typealias Item = ProgramItem

  var identity: Int { .zero }
  var items: [Item]

  init(original: ProgramSection, items: [Item]) {
    self = original
    self.items = items
  }

  init(items: [Item]) {
    self.items = items
  }
}

struct ProgramItem {
  let program: Program
}

extension ProgramItem: IdentifiableType, Equatable {

  static func == (lhs: ProgramItem, rhs: ProgramItem) -> Bool {
    lhs.program.id == rhs.program.id
  }

  public var identity: String {
    program.title
  }
}
