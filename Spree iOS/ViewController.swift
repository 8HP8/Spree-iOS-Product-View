//
//  ViewController.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/01/30.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Test

    Alamofire.request(.GET, "https://www.spree.co.za/api/v1/catalog/browse/2641").responseJSON { (response) -> Void in
        
        //Check if the result have value
            if let JSON = response.result.value {
                print(JSON)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

