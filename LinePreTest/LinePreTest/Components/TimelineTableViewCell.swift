//
//  TimelineTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 28/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit
import SDWebImage

class TimelineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
    return min(datasource.photos.count, 3)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:PostPhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostPhotoCollectionViewCell", for: indexPath as IndexPath) as! PostPhotoCollectionViewCell

    let item:PostPhoto = datasource.photos[indexPath.row]
    cell.photoImageView.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "placeholder"))
    
    return cell
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var widthScale:CGFloat = 1
    var widthRatio:CGFloat = 1
    var heightRatio:CGFloat = 1
    
    if (datasource.photos.count == 1) {
      widthScale = 1
      widthRatio = 16
      heightRatio = 9
    } else if (datasource.photos.count == 2) {
      widthScale = 0.5
      widthRatio = 1
      heightRatio = 2
    } else if (datasource.photos.count >= 3) {
      if (indexPath.row == 0) {
        widthScale = 0.5
        widthRatio = 1
        heightRatio = 2
      } else {
        widthScale = 0.5
        widthRatio = 1
        heightRatio = 1
      }
    }
    
    let width = self.frame.width * widthScale
    let height = width * heightRatio / widthRatio
    return CGSize(width: width, height: height)
  }
}
