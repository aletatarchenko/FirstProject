//
//  TracksTableViewController.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import UIKit

final class TracksTableViewController: UIViewController {

  // MARK: - IBOutlet
  @IBOutlet private weak var playerView: PlayerView!
  @IBOutlet private weak var tableView: UITableView!

  private let viewModel: TracksViewModel
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupBinding()
  }

  // MARK: - Initialization
  init(viewModel: TracksViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - private func
  private func setupBinding() {
    playerView.rewindPlayerButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.rewindAudio()
      })
      .disposed(by: rx.disposeBag)

    playerView.forwardPlayerButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.forwardAudio()
      })
      .disposed(by: rx.disposeBag)

    viewModel.driveIsShowPlayer
      .subscribe(onNext: { [weak self] _ in
        self?.showPlayer()
      })
      .disposed(by: rx.disposeBag)

    viewModel.currentTrackRelay
      .asObservable()
      .filterNil()
      .subscribe(onNext: { [weak self] in
        self?.playerView.setupWith($0)
        self?.playerView.setupImage($0.isPlaying)
      })
      .disposed(by: rx.disposeBag)

    playerView.playButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let trackItem = self?.viewModel.currentTrackRelay.value
        else { return }
        self?.pressingThePlayButton(trackItem)
      })
      .disposed(by: rx.disposeBag)

    viewModel.driveCurrentValueLine
      .drive(playerView.progressView.rx.progress)
      .disposed(by: rx.disposeBag)

    viewModel.driveCurrentTime
      .filterNil()
      .drive(onNext: { [weak self] in
        self?.playerView.setupCurrentTimeWith($0)
      })
      .disposed(by: rx.disposeBag)

    viewModel.driverTracks
      .drive(tableView.rx.items(cellIdentifier: TrackTableViewCell.id,
                                cellType: TrackTableViewCell.self)) { [weak self] (_, model: TrackItem, cell: TrackTableViewCell) in

        cell.setupCellWith(model)

        cell.playButton.rx.tap
          .subscribe(onNext: {
            self?.pressingThePlayButton(model)
          })
          .disposed(by: cell.disposeBag)
      }
      .disposed(by: rx.disposeBag)
  }

  private func setupUI() {
    tableView.register(cellType: TrackTableViewCell.self)
    tableView.tableFooterView = UIView()
  }

  private func pressingThePlayButton(_ model: TrackItem) {
    switch model.isPlaying {
    case .idle:
      self.viewModel.setupPlayerWith(model)
      model.isPlaying = .playing
    case .playing:
      self.viewModel.pausePlayer()
    case .paused:
      self.viewModel.playPlayer()
    }
  }

  private func showPlayer() {
    UIView.transition(
      with: playerView,
      duration: 0.2,
      options: .transitionCrossDissolve,
      animations: { [weak self] in
        self?.playerView.alpha = 1
      })
  }

  deinit {
    debugPrint(#function, type(of: self))
  }
}

