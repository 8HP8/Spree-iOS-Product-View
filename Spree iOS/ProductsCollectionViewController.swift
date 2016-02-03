//
//  ProductsCollectionViewController.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/02/02.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "Cell"

class ProductsCollectionViewController: UICollectionViewController {


    var items = NSMutableArray()
    var productImages = NSMutableArray()
    var productBrand = NSMutableArray()
    var productPrice = NSMutableArray()

    override func viewWillAppear(animated: Bool) {
        addProductTitleData()
        addImageData()
        addBrandName()
        addPrice()
    }
    
    func addProductTitleData() {
        RestApiManager.sharedInstance.doSomeThing { json -> Void in
            
            let result = json["products"]
            for (_, subJson): (String, JSON) in result {
                if let title:AnyObject = subJson["title"].string {
                    self.items.addObject(title)
                dispatch_async(dispatch_get_main_queue(), {
                    collectionView?.reloadData()
                })
            }}
        }
    }
    
    func addImageData() {
        RestApiManager.sharedInstance.doSomeThing { json -> Void in
            let result = json["products"]
            for (_, subJson): (String, JSON) in result {
                if let image:AnyObject = subJson["pics"]["small"].string {
                    self.productImages.addObject(image)
                    dispatch_async(dispatch_get_main_queue(), {
                        collectionView?.reloadData()
                    })
                }}
        }
    }
    
    func addBrandName() {
        RestApiManager.sharedInstance.doSomeThing { json -> Void in
            let result = json["products"]
            for (_, subJson): (String, JSON) in result {
                if let image:AnyObject = subJson["brand"]["name"].string {
                    self.productBrand.addObject(image)
                    dispatch_async(dispatch_get_main_queue(), {
                        collectionView?.reloadData()
                    })
                }}
        }
    }
    
    func addPrice() {
        RestApiManager.sharedInstance.doSomeThing { json -> Void in
            let result = json["products"]
            for (_, subJson): (String, JSON) in result {
                if let image:AnyObject = subJson["price"]["selling"].intValue {
                    self.productPrice.addObject(image)
                    dispatch_async(dispatch_get_main_queue(), {
                        collectionView?.reloadData()
                    })
                }}
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ProductsCollectionViewCell
        
        if items == [] {
            print("error")
        }
        else if productImages == []{
            print("error")
        }
        else if productBrand == []{
            print("error")
        }            
        else if productPrice == []{
            print("error")
        }
        else {
        let imageStartUrl = "https://www.spree.co.za/api/v1/catalog/product/thumbnail/H599921/thumbnail/345x464"
        let picURL = imageStartUrl + "\(productImages[indexPath.row])"
        let url = NSURL(string: picURL)
        let data = NSData(contentsOfURL: url!)

        cell.productTitle.text = items[indexPath.row] as? String
        cell.productImage.image = UIImage(data: data!)
        cell.productBrand.text = productBrand[indexPath.row] as? String
        cell.productPrice.text = "R\(productPrice[indexPath.row])"
            
        // White Background rounded corners
        cell.productBg.layer.cornerRadius = 15.0
        cell.productBg.clipsToBounds = true
    
        }
        return cell

    }
  
}
