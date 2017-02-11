//
//  ViewController.swift
//  NProgressDemo
//
//  Created by 洪朔 on 2017/2/7.
//  Copyright © 2017年 Tuccuay. All rights reserved.
//

import UIKit
import NProgress

class ViewController: UIViewController {
    
    var p: NProgress?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let np = NProgress(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 10))
        let np = NProgress(frame: view.bounds)
        view.addSubview(np)
        np.start()
        
        p = np
        
    }

    @IBAction func start(_ sender: Any) {
        p?.start()
    }
    
    @IBAction func set(_ sender: Any) {
        p?.set(0.4)
    }
    
    @IBAction func inc(_ sender: Any) {
        p?.inc()
    }
    
    @IBAction func done(_ sender: Any) {
        p?.done()
    }
}

