//
//  ItemDataManager.swift
//  ItemSearchApp
//
//  Created by MaedaAkira on 2017/06/14.
//  Copyright © 2017年 d_na_ser. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class ItemDataManager {
    static let sharedInstance = ItemDataManager()
    
    var ItemDataArray = [ItemData]()
    let entryUrl = "http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?"
    let appID = "dj0zaiZpPTRXYXhydXFOY3RDMyZzPWNvbnN1bWVyc2VjcmV0Jng9Zjg-"
    
    
    func getItemData(text:String) -> [ItemData]{
        //入力したテキストを元にAPIに通信。その結果を配列に格納して返す
        
        //appIDと検索文字の2点をエンコード
        let apiParameter = [
            "appid": appID,
            "query": text
        ]
        let requstURL = getRequestURL(parameter: apiParameter)
        getData(requestURL: requstURL)
        
        
        return ItemDataArray
    }
    
    private init() {
        
    }
    
    //appIDと商品検索用のクエリ文字列をリクエスト可能な文字列にエンコード
    func encodeParameter(key: String, value: String) -> String? {
        //エンコード処理
        guard let encodedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            //エンコード失敗
            return nil
        }
        
        //エンコードした値を返す
        return "\(key)=\(encodedValue)"
    }
    
    //エンコードした文字列を元にリクエスト用のURLを作成
    func getRequestURL(parameter: [String:String]) -> String {
        //WebAPIにリクエスト送る際はURLエンコード(リクエストに使用できない)が必要
        //URLエンコードとはリクエストに使用できない文字列の変換を行うこと
        var parameterArray:[String] = []
        for (key,value) in parameter{
            parameterArray.append(encodeParameter(key: key, value: value)!)
        }
        
        let requestURL = entryUrl + parameterArray[0] + "&" + parameterArray[1]
        return requestURL
        
        
    }
    
    //WebAPIにリクエストを送信
    func getData(requestURL: String) {
        Alamofire.request(requestURL, method: .get).responseJSON{ response in
            
            guard let itemData = response.result.value else{
                print("json取得できねえ！")
                return
            }
            
            let jsonData = JSON(itemData)["ResultSet"]["0"]["Result"] //取得した商品データ一覧のJSON
            print("jsonの中身：\(jsonData)")
            
            for (index,_):(String, JSON) in jsonData {
                //JSONパースして商品情報のオブジェクトを作成する
                self.createItemData(jsonData: jsonData, index: index)
            }
            
        }
    }
    
    func createItemData(jsonData: JSON, index: String) {
        let itemData = ItemData()
        
        itemData.imageImageUrl = jsonData["\(index)"]["Image"]["Medium"].string
        itemData.itemTitle = jsonData["\(index)"]["Nmae"].string
        itemData.itemPrice = jsonData["\(index)"]["Price"]["_value"].string
        itemData.itemUrl = jsonData["\(index)"]["Url"].string
        
        ItemDataArray.append(itemData)
    }
}
