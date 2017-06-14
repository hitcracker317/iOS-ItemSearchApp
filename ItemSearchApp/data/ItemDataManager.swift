//
//  ItemDataManager.swift
//  ItemSearchApp
//
//  Created by MaedaAkira on 2017/06/14.
//  Copyright © 2017年 d_na_ser. All rights reserved.
//

import Foundation

class ItemDataManager {
    static let sharedInstance = ItemDataManager()
    
    var ItemDataArray = [ItemData]()
    let entryUrl = "http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?"
    let appID = "dj0zaiZpPTRXYXhydXFOY3RDMyZzPWNvbnN1bWVyc2VjcmV0Jng9Zjg-"
    
    
    func getItemData(text:String) -> [ItemData]{
        //入力したテキストを元にAPIに通信。その結果を配列に格納して返す
        print("受け取った文字列は：\(text)")
        
        //TODO：
        
        
        //そのURLを使用してWebAPIにリクエストを送る
        //リクエストして返ってきたJSONをパースする
        //パースした内容をItemDataのプロパティに代入して、ItemDataオブジェクトを生成
        //生成したItemDataオブジェクトを配列に格納してviewControllerに渡す。
        
        
        
        
        //appIDと検索文字の2点をエンコード
        let apiParameter = [
            "appid": appID,
            "query": text
        ]
        var requstURL = getRequestURL(parameter: apiParameter)
        
        
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
}
