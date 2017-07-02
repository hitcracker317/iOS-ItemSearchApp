//
//  ItemSearchTableViewController.swift
//  ItemSearchApp
//
//  Created by MaedaAkira on 2017/06/14.
//  Copyright © 2017年 d_na_ser. All rights reserved.
//

import UIKit

class ItemSearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet var itemTableView: UITableView!
    
    var itemDataArray = [ItemData]()
    var selectedCellData: ItemData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemCell") //カスタムテーブルビューセルを読み込む
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //UISearchBarの「検索」ボタンをタップしたタイミングで呼ばれるデリゲートメソッド
        guard let searchText = itemSearchBar.text else {
            return
        }
        
        if searchText.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            //1文字以上入力してたら
            ItemDataManager.sharedInstance.getItemData(text: searchText) { response in
                //リクエストが終了してデータを取得したらクロージャー実行
                self.itemDataArray = response as [ItemData]
                print("レスポンス：\(self.itemDataArray)")
                
                self.itemTableView.reloadData() //取得したデータを元にtableviewを更新
            }
        }
        itemSearchBar.resignFirstResponder() //キーボード閉じる
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        //テーブルビューのセクション
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セクション内のセルの数
        return itemDataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルの描画
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        itemCell.addItemData(itemData: self.itemDataArray[indexPath.row]) 
        return itemCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellData = itemDataArray[indexPath.row] as ItemData
        performSegue(withIdentifier: "toItemDetailViewController", sender: nil) //IDで指定したセグエを呼び出して画面遷移
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //セグエで画面遷移をするタイミングで実行されるメソッド
        
        if segue.identifier == "toItemDetailViewController" {
            let detailViewController = segue.destination as? ItemDetailViewController
            detailViewController?.itemDetailURL = (selectedCellData?.itemUrl)! //遷移先のviewControllerに値を受け渡す
        }
    }
}
