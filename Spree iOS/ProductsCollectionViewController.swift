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

    @IBOutlet var productCollection: UICollectionView!

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


    // Get Product Title
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
    
    // Get Product Image
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
    
    // Get Product Brand
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
    
    // Get Product Price
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
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ProductsCollectionViewCell
        cell.productImage.image = nil
        cell.productBrand.text = nil
        cell.productPrice.text = nil
        cell.productTitle.text = nil
        
        cell.productBg.layer.cornerRadius = 15.0
        cell.productBg.clipsToBounds = true
        
        // Run this code on second thread
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_async(queue) { () -> Void in

              // Check for errors
                if self.items == [] {
                    print("Error loading Product Titles")
                }
                else if self.productImages == []{
                    print("Error loading Product Images")
                }
                else if self.productBrand == []{
                    print("Error loading Product Brands")
                }
                else if self.productPrice == []{
                    print("Error loading Product Price")
                }
                else {
                    
                    // Convert Product Image String -> NSData
                    let imageStartUrl = "https://www.spree.co.za/api/v1/catalog/product/thumbnail/H599921/thumbnail/345x464"
                    let picURL = imageStartUrl + "\(self.productImages[indexPath.row])"
                    let url = NSURL(string: picURL)
                    let data = NSData(contentsOfURL: url!)
                    
                    // Return this to main Thread
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.productImage.image = UIImage(data: data!)
                                cell.productTitle.text = self.items[indexPath.row] as? String
                                cell.productBrand.text = self.productBrand[indexPath.row] as? String
                                cell.productPrice.text = "R\(self.productPrice[indexPath.row])"
                            })
                        }
                    }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Push Product Info from cell selected to DetailedViewController
        if segue.identifier == "showDetail" {
            let indexPaths = self.productCollection!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destinationViewController as! DetailedViewController
           
            vc.productName = self.items[indexPath.row] as! String
            vc.productBrandText = self.productBrand[indexPath.row] as! String
            vc.productImageName = self.productImages[indexPath.row] as! String
            vc.productPriceText = self.productPrice[indexPath.row] as! Int
        }
    }
}
