//
//  ProductCollectionViewController.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/01/31.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import UIKit


class ProductCollectionViewController: UICollectionViewController {

    @IBOutlet var productCollectionView: UICollectionView!
  
    var products = [String]()
    var productImages = [String]()
    var productBrand = [String]()
    var productPrice = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productPrice)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    // Change CollectionCell size
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let customHeight:CGFloat = 290
            let customWidth:CGFloat = collectionView.bounds.width / 2.1
            return CGSizeMake(customWidth, customHeight)
    }
       // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    // Make a cell for each cell index path
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ProductCollectionViewCell
        
        

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let entry = products[indexPath.row]
//      let price = productPrice[indexPath.row]
        let brand = productBrand[indexPath.row]

        let urlString = "https://www.spree.co.za/api/v1/catalog/product/thumbnail/H599921/thumbnail/345x464" + "\(productImages[indexPath.row])"
        
        let url = NSURL(string: urlString)!
        let data = NSData(contentsOfURL: url)!
        let image = UIImage(data: data)

        cell.productTitle.text = "\(entry)"
        cell.productImage.image = image
        cell.productBrand.text = brand
//        cell.productPrice.text = price
        
        return cell
    }

    // MARK: - UICollectionViewDelegate protocol
    var itemTaped:String!
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            let indexPaths = self.productCollectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! DetailedViewController
            
            vc.productTitleText = self.products[indexPath.row]
            vc.detailImage = self.productImages[indexPath.row]
//            vc.productBrand.text = productBrand[indexPath.row]
        }
    }
}


















