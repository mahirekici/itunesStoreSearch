//
//  SearchTableViewCell.swift
//  Imkb
//
//  Created by mahir ekici on 8.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import UIKit

class MusicDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var artwork: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(usingViewModel viewModel: SearchDetailCellViewModel, with indexPath: IndexPath) {
       
        print("amgArtistId -----")
        print(viewModel.amgArtistId ?? 0)
        
        title.text =  viewModel.collectionName
        
        if (viewModel.artworkUrl100 != nil){
            artwork.downloaded(from: viewModel.artworkUrl100!)
        }


    }
    
}
