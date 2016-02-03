//
//  DetailedViewController.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/02/03.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var productName = String()
    var productBrandText = String()
    var productPriceText = Int()
    var productImageName = String()
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    override func viewWillAppear(animated: Bool) {
        let imageStartUrl = "https://www.spree.co.za/api/v1/catalog/product/thumbnail/H599921/thumbnail/345x464"
        let picURL = imageStartUrl + "\(productImageName)"
        let url = NSURL(string: picURL)
        let data = NSData(contentsOfURL: url!)

        productTitle.text = productName
        productBrand.text = productBrandText
        productPrice.text = "R\(productPriceText)"
        productImage.image = UIImage(data: data!)
    }
    

  
    
    
}
