//
//  ProductsCollectionViewCell.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/02/03.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productBg: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
//    override func prepareForReuse() {
//        productImage.image = nil
//        productBrand.text = nil
//        productPrice.text = nil
//        productTitle.text = nil
//    }
}
