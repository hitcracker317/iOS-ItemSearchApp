//
//  ItemDetailViewController.swift
//  ItemSearchApp
//
//  Created by MaedaAkira on 2017/06/14.
//  Copyright © 2017年 d_na_ser. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    var itemDetailURL = ""
    @IBOutlet weak var itemDetailWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //webviewにwebページの表示
        let itemURL = URL(string: itemDetailURL)
        let request = URLRequest(url: itemURL!)
        itemDetailWebView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
