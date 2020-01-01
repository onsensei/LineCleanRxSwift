//
//  PostPhotoCollectionViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 29/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit

class PostPhotoCollectionViewCell: UICollectionViewCell {

  // MARK: IBOutlet
  
  @IBOutlet weak var photoImageView: UIImageView!
  
  // MARK: Cell lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
  }
  
  // MARK: Do something
  
  func displayCell(image: UIImage) {
    photoImageView.image = image
  }
}
