//
//  TimelineTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 28/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
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
  
  var datasource: PostAlbum = PostAlbum(title: "", photos: [])
  
  func displayCell(postAlbum: PostAlbum)
  {
    datasource = postAlbum
    
    titleLabel.text = datasource.title
    titleLabel.text = "\(datasource.title) (\(datasource.photos.count))"
    
    if (datasource.photos.count == 0) {
      photoZeroHeightConstraint.isActive = true
      photoSquareRatioConstraint.isActive = false
      photoWideRatioConstraint.isActive = false
    } else if (datasource.photos.count == 1) {
      photoZeroHeightConstraint.isActive = false
      photoSquareRatioConstraint.isActive = false
      photoWideRatioConstraint.isActive = true
    } else if (datasource.photos.count > 1) {
      photoZeroHeightConstraint.isActive = false
      photoSquareRatioConstraint.isActive = true
      photoWideRatioConstraint.isActive = false
    }
  }
  
  // MARK: UICollectionViewDataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return datasource.photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // get a reference to our storyboard cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell

    // Use the outlet in our custom class to get a reference to the UILabel in the cell
    cell.myLabel.text = self.items[indexPath.item]
    cell.backgroundColor = UIColor.cyan // make cell more visible in our example project

    return cell
  }
}
