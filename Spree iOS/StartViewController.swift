//
//  StartViewController.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/01/31.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StartViewController: UIViewController {
    
    var productTitle = [String]()
    var productSku =   [String]()
    var productBrand = [String]()
    var productImage = [String]()
    var productPrice = [String]()
    
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var shopBtnViewBg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shopBtn.alpha = 0.0
        self.shopBtnViewBg.alpha = 0.0
        animateShopButton()
        print(productPrice)
        self.navigationController?.navigationBarHidden = true

    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewWillAppear(animated: Bool) {
        // Get JSON info from Spree API
        Alamofire.request(.GET, "https://www.spree.co.za/api/v1/catalog/browse/2641").responseJSON { (response) -> Void in
            self.productTitle = self.titlesFromJson(response.result.value)
            self.productSku = self.SkuFromJson(response.result.value)
            self.productBrand = self.brandFromJson(response.result.value)
            self.productImage = self.productImageFromJson(response.result.value)
            self.productPrice = self.productPriceFromJson(response.result.value)
            
        // Hide navigationBar
            self.navigationController?.navigationBarHidden = true

        }
    }
    
    // Assign JSON Data to Array
    // Product Title
    func titlesFromJson(data: AnyObject?) -> [String] {
        guard data != nil else {
            return []}
        let json = JSON(data!)
        var titles: [String] = []
        for (_, subJson): (String, JSON) in json["products"] {
            if let title = subJson["title"].string {
                titles.append(title) }}
        return titles
    }

    // Product SKU
    func SkuFromJson(data: AnyObject?) -> [String] {
        guard data != nil else {
            return []}
        let json = JSON(data!)
        var Sku: [String] = []
        for (_, subJson): (String, JSON) in json["products"] {
            if let title = subJson["sku"].string {
                Sku.append(title) }}
        return Sku
    }
    
    // Product Brand
    func brandFromJson(data: AnyObject?) -> [String] {
        guard data != nil else {
            return []}
        let json = JSON(data!)
        var Sku: [String] = []
        for (_, subJson): (String, JSON) in json["products"] {
            if let title = subJson["brand"]["name"].string {
                Sku.append(title) }}
        return Sku
    }

    // Product Image
    func productImageFromJson(data: AnyObject?) -> [String] {
        guard data != nil else {
            return []}
        let json = JSON(data!)
        var image: [String] = []
        for (_, subJson): (String, JSON) in json["products"] {
            if let title = subJson["pics"]["small"].string {
                image.append(title) }}
        return image
    }
   
    // Product Price
    func productPriceFromJson(data: AnyObject?) -> [String] {
        guard data != nil else {
            return []}
        let json = JSON(data!)
        var image: [String] = []
        for (_, subJson): (String, JSON) in json["products"] {
            if let title = subJson["price"]["selling"].string {
                image.append(title) }}
        return image
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Push data to ProductCollectionViewController
        let DestinationViewController = segue.destinationViewController as! ProductCollectionViewController
        DestinationViewController.productImages = self.productImage
        DestinationViewController.productBrand = self.productBrand
        DestinationViewController.productPrice = self.productPrice
        DestinationViewController.products = self.productTitle
    }
    
    // Create fade in animation for @shopBtn
    func animateShopButton(){
        UIView.animateKeyframesWithDuration(1.5, delay: 0.5, options: [], animations: ({
            self.shopBtn.alpha = 1.0
            self.shopBtnViewBg.alpha = 0.2
        }), completion: nil)
    }
    

    
    
    
    
    
    
    
    
}
