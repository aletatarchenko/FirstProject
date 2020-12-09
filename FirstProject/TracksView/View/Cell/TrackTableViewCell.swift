//
//  TrackTableViewCell.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

final class TrackTableViewCell: UITableViewCell, NibReusable {

  // MARK: - IBOutlet
  @IBOutlet private weak var titleTrackLabel: UILabel!
  @IBOutlet private(set) weak var playButton: UIButton!

  private(set) var disposeBag = DisposeBag()

  override func prepareForReuse() {
    super.prepareForReuse()
    
    playButton.setImage(nil, for: .normal)
    titleTrackLabel.text = nil
    disposeBag = DisposeBag()
  }

  func setupCellWith(_ track: TrackItem) {
    titleTrackLabel.text = track.title
    setupImage(track.isPlaying)
  }

  private func setupImage(_ playerState: PlayerState) {
    switch playerState {
    case .idle:
      self.playButton.setImage(IconStorage.Player.play, for: .normal)
    case .playing:
      self.playButton.setImage(IconStorage.Player.pause, for: .normal)
    case .paused:
      self.playButton.setImage(IconStorage.Player.play, for: .normal)
    }
  }

  deinit {
    print(#function, type(of: self))
  }
}

