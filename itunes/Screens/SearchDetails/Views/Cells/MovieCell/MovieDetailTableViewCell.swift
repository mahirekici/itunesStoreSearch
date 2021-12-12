//
//  MovieDetailTableViewCell.swift
//  Imkb
//
//  Created by mahir ekici on 12.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artwork: UIImageView!
    
    @IBOutlet weak var detailText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(usingViewModel viewModel: SearchDetailCellViewModel, with indexPath: IndexPath) {
       
        
        title.text =  viewModel.trackName
        
        if (viewModel.artworkUrl100 != nil){
            artwork.downloaded(from: viewModel.artworkUrl100!)
        }
        
        detailText.text =  viewModel.longDescription


    }
}
