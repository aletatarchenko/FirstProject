//
//  TracksViewModel.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift
import RxOptional

protocol PlayerViewModel {
  var player: Player? { get set }
  var driveCurrentTime: Driver<Int?> { get }
  var driveCurrentValueLine: Driver<Float> { get }
  var driveIsShowPlayer: Observable<Bool> { get }
  var currentTrackRelay: BehaviorRelay<TrackItem?> { get set }
  func setupPlayerWith(_ trackItem: TrackItem)
  func pausePlayer()
  func playPlayer()
}

protocol TracksViewModel: PlayerViewModel {

  var driverTracks: Driver<[TrackItem]> { get }
}

final class TracksViewModelImp: TracksViewModel {

  var player: Player?

  private var disposeBag = DisposeBag()

  private let trackRelay = BehaviorRelay<[TrackItem]>(value: [])

  var currentTrackRelay = BehaviorRelay<TrackItem?>(value: nil)

  var driverTracks: Driver<[TrackItem]> {
    Observable.combineLatest(trackRelay.asObservable(), currentTrackRelay.asObservable())
      .map { (tracks: [TrackItem], track: TrackItem?) -> [TrackItem] in
        if let track = track {
          tracks.first(where: { $0.key == track.key })?.isPlaying = track.isPlaying
          return tracks
        } else {
          tracks.forEach { $0.isPlaying = .idle }
          return tracks
        }
      }
      .map { $0.sorted() }
      .asDriver(onErrorJustReturn: [])
  }

  private let currentTimeRelay = BehaviorRelay<Int?>(value: nil)
  var driveCurrentTime: Driver<Int?> {
    currentTimeRelay.asDriver()
  }

  private let currentValueLineRelay = PublishRelay<Float>()
  var driveCurrentValueLine: Driver<Float> {
    currentValueLineRelay.asDriver(onErrorJustReturn: .zero)
      .map { [weak self] in
        guard let duration = self?.currentTrackRelay.value?.duration else { return .zero }
        return $0 / Float(duration)
      }
  }

  var driveIsShowPlayer: Observable<Bool> {
    currentTrackRelay
      .asObservable()
      .filterNil()
      .map { $0.isPlaying == .playing }
      .take(1)
  }

  // MARK: - Initialization
  init(_ program: Program) {
    let trackItem = program.tracks.map { TrackItem($0) }
    trackRelay.accept(trackItem)
  }

  func pausePlayer() {
    player?.pause()
    setupCurrentTrackWith(.paused)
  }

  func playPlayer() {
    player?.play()
    setupCurrentTrackWith(.playing)
  }

  private func nextTack() {
    if
      let currentTrack = currentTrackRelay.value,
      let index = trackRelay.value.firstIndex(of: currentTrack),
      let newCurrentTrack = trackRelay.value[safe: index + 1] {
      currentTrackRelay.accept(newCurrentTrack)
      setupPlayerWith(newCurrentTrack)
    } else
    if let newCurrentTrack = trackRelay.value.first {
      currentTrackRelay.accept(newCurrentTrack)
      setupPlayerWith(newCurrentTrack)
    }
  }

  func setupPlayerWith(_ trackItem: TrackItem) {
    disposeBag = DisposeBag()
    currentTrackRelay.accept(nil)

    player = PlayerImp(url: trackItem.media.mp3.url)

    player?.driveTime
      .drive(onNext: { [weak self] in
        self?.currentValueLineRelay.accept(Float($0))
        self?.currentTimeRelay.accept($0)
      })
      .disposed(by: disposeBag)

    player?.drivePlayerFinishedPlaying
      .drive(onNext: { [weak self] in
        self?.nextTack()
      })
      .disposed(by: disposeBag)

    trackItem.isPlaying = .playing
    currentTrackRelay.accept(trackItem)
    player?.play()
  }

  private func setupCurrentTrackWith(_ state: PlayerState) {
    let playNowTrack = currentTrackRelay.value
    playNowTrack?.isPlaying = state
    currentTrackRelay.accept(playNowTrack)
  }

  deinit {
    debugPrint(#function, type(of: self))
  }
}

final class TrackItem {

  let key, title: String
  let duration: Int
  let media: Media
  var isPlaying: PlayerState = .idle

  init(_ track: Track) {
    self.key = track.key
    self.title = track.title
    self.duration = track.duration
    self.media = track.media
  }
}

extension TrackItem: Comparable {
  static func < (lhs: TrackItem, rhs: TrackItem) -> Bool {
    lhs.key < rhs.key
  }

  static func == (lhs: TrackItem, rhs: TrackItem) -> Bool {
    lhs.key == rhs.key
  }
}

fileprivate extension Collection {
  subscript (safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}
