//
//  Player.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import AVFoundation
import RxSwift
import RxCocoa

protocol Player {
  var driveTime: Driver<Int> { get }
  var drivePlayerFinishedPlaying: Driver<()> { get }
  func play()
  func pause()
  func rewindAudio(by seconds: Float64)
  func forwardAudio(by seconds: Float64)
}

final class PlayerImp: Player {

  private let disposeBag = DisposeBag()
  
  private let currentTimeRelay = BehaviorRelay<Int>(value: .zero)
  var driveTime: Driver<Int> {
    currentTimeRelay.asDriver()
  }

  private let playerFinishedPlayingRelay = PublishRelay<()>()
  var drivePlayerFinishedPlaying: Driver<()> {
    playerFinishedPlayingRelay.asDriver(onErrorJustReturn: ())
  }

  private var player: AVPlayer?
  private let session = AVAudioSession.sharedInstance()

  // MARK: - Initialization
  init(url: URL) {

    do {
      try session.setCategory(AVAudioSession.Category.playback)
      try session.setActive(true)
    }
    catch {
      debugPrint("Error create session")
    }

    let item = AVPlayerItem(url: url)
    player = AVPlayer(playerItem: item)

    player?.automaticallyWaitsToMinimizeStalling = false
    addPeriodicTimeObserver()

    NotificationCenter.default.rx.notification(.AVPlayerItemDidPlayToEndTime)
      .map { _ in }
      .bind(to: playerFinishedPlayingRelay)
      .disposed(by: disposeBag)
  }


  private func addPeriodicTimeObserver() {
    player?.addPeriodicTimeObserver(
      forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
      queue: DispatchQueue.main,
      using: { [weak self] time in
        guard
          let `self` = self,
          let player = self.player
        else { return }

        if player.currentItem?.status == .readyToPlay {
          let currentTime = CMTimeGetSeconds(player.currentTime())
          self.currentTimeRelay.accept(Int(currentTime))
        }
      })
  }

  func play() {
    player?.play()
  }

  func pause() {
    player?.pause()
  }

  func rewindAudio(by seconds: Float64) {
    guard let player = player else { return }
    var newTime = CMTimeGetSeconds(player.currentTime()) - seconds
    if newTime <= .zero {
      newTime = .zero
    }
    player.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
  }

  func forwardAudio(by seconds: Float64) {
    guard
      let player = player,
      let duration = player.currentItem?.duration
    else { return }

    var newTime = CMTimeGetSeconds(player.currentTime()) + seconds
    if newTime >= CMTimeGetSeconds(duration) {
      newTime = CMTimeGetSeconds(duration)
    }
    player.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
  }

  deinit {
    print(#function, type(of: self))
  }
}

enum PlayerState: Int, Codable {
  case idle
  case playing
  case paused
}
