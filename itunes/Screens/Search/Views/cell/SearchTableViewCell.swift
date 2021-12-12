//
//  SearchTableViewCell.swift
//  Imkb
//
//  Created by mahir ekici on 8.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var subTitle2: UILabel!
    @IBOutlet weak var artworkImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(usingViewModel viewModel: SearchCellViewModel, with indexPath: IndexPath) {
       
        var kind  = ""
        
        if ((viewModel.kind ) != nil){
            kind = " /  kind: " +  (viewModel.kind ?? "")
        }
        
        var artistId = ""
        
        if ((viewModel.artistId ) != nil){
            
            artistId = " /  artistId: " +  String((viewModel.artistId ?? 0))
        }
        
        
        subTitle2.text =  (viewModel.collectionName ?? "")
            
        subTitle.text = viewModel.wrapperType!.rawValue + kind + artistId
       
        DispatchQueue.main.async {
            self.artworkImage.downloaded(from:viewModel.artworkUrl60!)
           }
        
       
        
        if (viewModel.wrapperType == WrapperType.track)
        {
            title.text =  viewModel.trackName
            (backgroundColor = UIColor(hexString: "C3B091"))
            
        } else {
            title.text =  viewModel.collectionName
            (backgroundColor = UIColor(hexString: "FFE6BC"))
        }
        

    }
    
}
