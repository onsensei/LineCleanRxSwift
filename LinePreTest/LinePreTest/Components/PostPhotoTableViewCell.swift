//
//  PostPhotoTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 31/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit

class PostPhotoTableViewCell: UITableViewCell {
  
  // MARK: IBOutlet
  
  @IBOutlet weak var photoImageView: UIImageView!
  
  // MARK: Cell lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // MARK: Do something
  
  func displayCell(postPhoto: PostPhoto) {
    photoImageView.sd_setImage(with: URL(string: postPhoto.thumbnail), placeholderImage: UIImage(named: "placeholder"))
  }
}
