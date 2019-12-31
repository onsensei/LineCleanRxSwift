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
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var photoCollectionView: UICollectionView!
  
  @IBOutlet weak var photoZeroHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoSquareRatioConstraint: NSLayoutConstraint!
  @IBOutlet weak var photoWideRatioConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var separatorViewHeightConstraint: NSLayoutConstraint!
  
  
  let label: NantesLabel = .init(frame: .zero)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    photoCollectionView.dataSource = self
    photoCollectionView.delegate = self
    photoCollectionView.register(UINib(nibName: "PostPhotoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PostPhotoCollectionViewCell")
    
    let myAttributeSSS:NSMutableAttributedString = NSMutableAttributedString(string: "… See More")
    myAttributeSSS.addAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor.label,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)
      ], range: NSRange(location: 0, length: 1)
    )
    myAttributeSSS.addAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor.lightGray,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)
      ], range: NSRange(location: 1, length: 9)
    )
    label.attributedTruncationToken = myAttributeSSS // NSAttributedString(string: "... See More", attributes: myAttribute)
    label.numberOfLines = 4
    label.textColor = UIColor.label
    self.contentView.addSubview(label)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    let labelLeadingConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 8)
    let labelTrailingConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -8)
    let labelTopConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 8)
    let labelBottomConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoCollectionView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -8)
    NSLayoutConstraint.activate([labelLeadingConstraint, labelTrailingConstraint, labelTopConstraint, labelBottomConstraint])
    
//    titleLabel.attributedTruncationToken = NSAttributedString(string: "... See More")
//    titleLabel.numberOfLines = 4
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  // MARK: Do something
  
  let CELL_SPACE:CGFloat = 4
  
  var datasource: PostAlbum = PostAlbum(title: "", photos: [])
  
  func displayCell(postAlbum: PostAlbum)
  {
    datasource = postAlbum
    
//    titleLabel.text = datasource.title
//    titleLabel.text = "\(datasource.title) \(datasource.title) \(datasource.title) \(datasource.title) \(datasource.title) (\(datasource.photos.count))" // !!!
    
    label.text = "\(datasource.title) \(datasource.title) \(datasource.title) \(datasource.title) \(datasource.title) (\(datasource.photos.count))" // !!!
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
