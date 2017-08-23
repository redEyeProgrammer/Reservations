//
//  ServicesCollectionViewCell.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/22/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet internal var imageView: UIImageView!
    @IBOutlet internal var label: UILabel!
    
    
    // MARK: - UIView
    public override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        layer.borderWidth = 2.0
    }
}


extension ServicesCollectionViewCell: PlanesViewModelView {

    public var planesImageView: UIImageView {
        return imageView
    }
    
    public var planesTitleLabel: UILabel {
        return label
    }

    
    
}
