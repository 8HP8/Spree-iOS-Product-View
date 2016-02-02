//
//  DetailedViewController.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/02/01.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var detailImage = String()
    var productTitleText = String()
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productTitleText)
        print(detailImage)
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        
        let urlString = "https://www.spree.co.za/api/v1/catalog/product/thumbnail/H599921/thumbnail/345x464" + "\(detailImage)"
        
        let url = NSURL(string: urlString)!
        let data = NSData(contentsOfURL: url)!
        let image = UIImage(data: data)
        

        self.productTitle.text = productTitleText
        self.productImage.image = image
    }
}
