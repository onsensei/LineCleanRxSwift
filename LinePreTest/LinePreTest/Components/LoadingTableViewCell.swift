//
//  LoadingTableViewCell.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 01/01/63 BE.
//  Copyright © 2563 Thanaphat Suwannikornkul. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
  
  // MARK: IBOutlet
  
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  // MARK: Cell lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
