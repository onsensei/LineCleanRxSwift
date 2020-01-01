//
//  AddPhotoCollectionViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 31/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit

class AddPhotoCollectionViewCell: UICollectionViewCell {
  
  // MARK: Cell lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.systemBlue.cgColor
  }
}
