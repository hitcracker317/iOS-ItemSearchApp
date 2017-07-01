//
//  ItemTableViewCell.swift
//  ItemSearchApp
//
//  Created by MaedaAkira on 2017/06/14.
//  Copyright © 2017年 d_na_ser. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var itemURL:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        //セルの再利用時に呼ばれるメソッド
        //ここでセルの初期化処理を行う
        
    }
    
    func addItemData(itemData: ItemData) {
        var urlString = itemData.itemImageUrl
        
        if urlString == nil {
            urlString = ""
            return
        } else {
            let imageUrl = URL(string: urlString!)
            let imageData = NSData(contentsOf: imageUrl!)
            itemImageView.image = UIImage(data: imageData as! Data)
        }
        itemTitleLabel.text = itemData.itemTitle
        itemPriceLabel.text = itemData.itemPrice
        itemURL = itemData.itemUrl
    }

}
