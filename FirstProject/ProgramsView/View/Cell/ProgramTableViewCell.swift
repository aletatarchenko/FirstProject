//
//  ProgramTableViewCell.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Reusable

final class ProgramTableViewCell: UITableViewCell, NibReusable {

  // MARK: - IBOutlet
  @IBOutlet private weak var programBannerImage: UIImageView!
  @IBOutlet private weak var programNameLabel: UILabel!

  func setupCellWith(_ program: Program) {
    programNameLabel.text = program.title
    guard let banner = program.banner else { return }
    programBannerImage.setupImageWith(banner.url)
  }
}
