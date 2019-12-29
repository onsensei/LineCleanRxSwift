//
//  TimelineTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 28/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit
import SDWebImage

class TimelineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var photoCollectionView: UICollectionView!
  
  @IBOutlet weak var photoZeroHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoSquareRatioConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoWideRatioConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    photoCollectionView.dataSource = self
    photoCollectionView.delegate = self
    photoCollectionView.register(UINib(nibName: "PostPhotoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PostPhotoCollectionViewCell")
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
    
    photoCollectionView.reloadData()
  }
  
  // MARK: UICollectionViewDataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return datasource.photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:PostPhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostPhotoCollectionViewCell", for: indexPath as IndexPath) as! PostPhotoCollectionViewCell

    let item:PostPhoto = datasource.photos[indexPath.row]
    cell.photoImageView.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "placeholder"))
    
    return cell
  }
}
