//
//  TimelineTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 28/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var photoCollectionView: UICollectionView!
  
  @IBOutlet weak var photoZeroHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoSquareRatioConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoWideRatioConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  // MARK: Do something
  
  func displayCell(postAlbum: PostAlbum)
  {
    titleLabel.text = postAlbum.title
    titleLabel.text = "\(postAlbum.title) (\(postAlbum.photos.count))"
    
    if (postAlbum.photos.count == 0) {
      photoZeroHeightConstraint.isActive = true
      photoSquareRatioConstraint.isActive = false
      photoWideRatioConstraint.isActive = false
    } else if (postAlbum.photos.count == 1) {
      photoZeroHeightConstraint.isActive = false
      photoSquareRatioConstraint.isActive = false
      photoWideRatioConstraint.isActive = true
    } else if (postAlbum.photos.count > 1) {
      photoZeroHeightConstraint.isActive = false
      photoSquareRatioConstraint.isActive = true
      photoWideRatioConstraint.isActive = false
    }
  }
}
