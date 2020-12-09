//
//  PlayerView.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 07.12.2020.
//

import UIKit

final class PlayerView: BaseView {

  // MARK: - IBOutlet
  @IBOutlet private(set) weak var progressView: UIProgressView!
  @IBOutlet private weak var compositionNameLabel: UILabel!
  @IBOutlet private weak var durationLabel: UILabel!
  @IBOutlet private weak var currentTimeLabel: UILabel!
  @IBOutlet private(set) weak var playButton: UIButton!
  @IBOutlet private(set) weak var rewindPlayerButton: UIButton!
  @IBOutlet private(set) weak var forwardPlayerButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()

    subviews.first?.layer.cornerRadius = 15
    subviews.first?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
  }

  func setupWith(_ trackItem: TrackItem) {
    compositionNameLabel.text = trackItem.title
    durationLabel.text = trackItem.duration.stringFromTimeInterval()
  }

  func setupCurrentTimeWith(_ time: Int) {
    currentTimeLabel.text = time.stringFromTimeInterval()
  }

  func setupImage(_ playerState: PlayerState) {
    switch playerState {
    case .idle:
      self.playButton.setImage(IconStorage.Player.play, for: .normal)
    case .playing:
      self.playButton.setImage(IconStorage.Player.pause, for: .normal)
    case .paused:
      self.playButton.setImage(IconStorage.Player.play, for: .normal)
    }
  }
  
}

fileprivate extension Int {

  func stringFromTimeInterval() -> String? {

    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad

    guard let formattedString = formatter.string(from: TimeInterval(self)) else { return nil }
    return formattedString
  }
}
