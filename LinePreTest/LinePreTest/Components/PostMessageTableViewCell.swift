//
//  PostMessageTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 31/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit

class PostMessageTableViewCell: UITableViewCell {
  
  // MARK: IBOutlet
  
  @IBOutlet weak var titleLabel: UILabel!
  
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
  
  func displayCell(postAlbum: PostAlbum) {
    titleLabel.text = postAlbum.title
  }
}
