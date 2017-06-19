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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            //itemDataArray = ItemDataManager.sharedInstance.getItemData(text: searchText)
            ItemDataManager.sharedInstance.getItemData(text: searchText) { response in
                //リクエストが終了してデータを取得したらクロージャー実行
                self.itemDataArray = response as [ItemData]
                print("レスポンス：\(self.itemDataArray)")
                
                self.itemTableView.reloadData() //取得したデータを元にtableviewを更新
            }
        }
        itemSearchBar.resignFirstResponder() //キーボード閉じる
    }

    // MARK: - Table view data source
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
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // セルを編集可能にするかどうか
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //セルの削除、追加
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //セルを移動させたタイミング
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        //セルを移動可能にするか
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //セグエの画面遷移をするタイミング
        let selectedCell = sender as? ItemTableViewCell //sederって何？
        let detailViewController = segue.destination as? ItemDetailViewController
        detailViewController?.itemDetailURL = (selectedCell?.itemURL)!
    }
    

}
