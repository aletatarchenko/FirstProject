//
//  ProgramViewController.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import RxDataSources

final class ProgramViewController: UIViewController {

  //MARK: - IBOutlet
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var listIsEmptyLabel: UILabel!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

  //MARK: - property
  private let refreshControl = UIRefreshControl()
  private let viewModel: ProgramViewModel
  private var dataSource: RxTableViewSectionedAnimatedDataSource<ProgramSection>!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupBinding()
  }

  // MARK: - private func
  private func setupBinding() {

    refreshControl.rx.controlEvent(.valueChanged)
      .bind(to: viewModel.loadPageTrigger)
      .disposed(by: rx.disposeBag)

    viewModel.driveShowLoading
      .skip(1)
      .drive(refreshControl.rx.isRefreshing)
      .disposed(by: rx.disposeBag)

    tableView.rx.modelSelected(ProgramItem.self)
      .subscribe(onNext: { [weak self] in
        self?.viewModel.showProgramWith($0.program)
      })
      .disposed(by: rx.disposeBag)

    viewModel.listIsEmpty
      .drive(listIsEmptyLabel.rx.isHidden)
      .disposed(by: rx.disposeBag)

    viewModel.driveShowLoading
      .drive(activityIndicator.rx.isAnimating)
      .disposed(by: rx.disposeBag)

    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] in
        self?.tableView.deselectRow(at: $0, animated: true)
      })
      .disposed(by: rx.disposeBag)

    viewModel.driveSection
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: rx.disposeBag)

    viewModel.driveErrorDescription
      .asObservable()
      .filterEmpty()
      .flatMap { [unowned self] in self.showErrorAlert(message: $0) }
      .subscribe()
      .disposed(by: rx.disposeBag)
  }

  private func setupUI() {
    tableView.addSubview(refreshControl)
    tableView.tableFooterView = UIView()
    tableView.register(cellType: ProgramTableViewCell.self)
    configureTableViewCell()
  }

  // MARK: - Initialization
  init(viewModel: ProgramViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    debugPrint(#function, type(of: self))
  }
}

extension ProgramViewController {
  private func configureTableViewCell() {
    
    dataSource = .init(
      animationConfiguration: AnimationConfiguration(
        insertAnimation: .fade,
        reloadAnimation: .fade,
        deleteAnimation: .left
      ),
      configureCell: { (_, tableView: UITableView, indexPath, item: ProgramItem) -> UITableViewCell in

        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramTableViewCell.id, for: indexPath)

        guard let programCell = cell as? ProgramTableViewCell else {
          fatalError("Cant create ProgramTableViewCell")
        }

        programCell.setupCellWith(item.program)

        return programCell
      }
    )
  }
}
