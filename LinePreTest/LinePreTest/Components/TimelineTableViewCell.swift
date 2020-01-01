//
//  TimelineTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 28/12/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit
import SDWebImage
import Nantes

class TimelineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  // MARK: IBOutlet
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var photoCollectionView: UICollectionView!
  
  @IBOutlet weak var photoZeroHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoSquareRatioConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoWideRatioConstraint: NSLayoutConstraint!
  
  // MARK: Cell lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
    photoCollectionView.dataSource = self
    photoCollectionView.delegate = self
    photoCollectionView.register(UINib(nibName: "PostPhotoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PostPhotoCollectionViewCell")
    
    titleLabel.text = ""
    setupAttributedLabel()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  // MARK: Do something
  
  let MAX_PHOTOS:Int = 3
  let CELL_SPACE:CGFloat = 4
  var datasource: PostAlbum = PostAlbum(title: "", photos: [])
  let attributedLabel: NantesLabel = .init(frame: .zero)
  
  func setupAttributedLabel() {
    // truncation & text style
    let truncationText:String = "…"
    let suffixText:String = " See More"
    let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: "\(truncationText)\(suffixText)")
    attributedString.addAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor.label,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)
      ], range: NSRange(location: 0, length: truncationText.count)
    )
    attributedString.addAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor.lightGray,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)
      ], range: NSRange(location: truncationText.count, length: suffixText.count)
    )
    attributedLabel.attributedTruncationToken = attributedString
    attributedLabel.numberOfLines = 4
    attributedLabel.textColor = UIColor.label
    
    // add view
    contentView.addSubview(attributedLabel)
    
    // constraint
    attributedLabel.translatesAutoresizingMaskIntoConstraints = false
    let labelLeadingConstraint = NSLayoutConstraint(item: attributedLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 8)
    let labelTrailingConstraint = NSLayoutConstraint(item: attributedLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -8)
    let labelTopConstraint = NSLayoutConstraint(item: attributedLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 8)
    let labelBottomConstraint = NSLayoutConstraint(item: attributedLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoCollectionView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -8)
    NSLayoutConstraint.activate([labelLeadingConstraint, labelTrailingConstraint, labelTopConstraint, labelBottomConstraint])
  }
  
  func displayCell(postAlbum: PostAlbum)
  {
    datasource = postAlbum
    
    attributedLabel.text = datasource.title
    
    // adjust layout with photos count
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
    return min(datasource.photos.count, MAX_PHOTOS)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:PostPhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostPhotoCollectionViewCell", for: indexPath as IndexPath) as! PostPhotoCollectionViewCell

    let item:PostPhoto = datasource.photos[indexPath.row]
    cell.displayCell(postPhoto: item)
    
    return cell
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var widthSpace:CGFloat = CELL_SPACE
    var heightSpace:CGFloat = CELL_SPACE
    
    var widthScale:CGFloat = 1
    
    var widthRatio:CGFloat = 1
    var heightRatio:CGFloat = 1
    
    if (datasource.photos.count == 1) {
      widthSpace = 0
      heightSpace = 0
      widthScale = 1
      widthRatio = 16
      heightRatio = 9
    } else if (datasource.photos.count == 2) {
      widthSpace = CELL_SPACE
      heightSpace = 0
      widthScale = 0.5
      widthRatio = 1
      heightRatio = 2
    } else if (datasource.photos.count >= 3) {
      if (indexPath.row == 0) {
        widthSpace = CELL_SPACE
        heightSpace = 0
        widthScale = 0.5
        widthRatio = 1
        heightRatio = 2
      } else {
        widthSpace = CELL_SPACE
        heightSpace = CELL_SPACE
        widthScale = 0.5
        widthRatio = 1
        heightRatio = 1
      }
    }
    
    let width = self.frame.width * widthScale
    let height = width * heightRatio / widthRatio
    return CGSize(width: width - widthSpace / 2, height: height - heightSpace / 2)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return CELL_SPACE
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return CELL_SPACE
  }
}
