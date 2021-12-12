//
//  SearchViewController.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources
import SideMenu
import KRProgressHUD

final class SearchDetailViewController: UIViewController {


    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
   
    
    @IBOutlet private weak var detailTableView: UITableView!
    
    private static var MusicDetailTableViewCell = "MusicDetailTableViewCell"
    private static let MovieDetailTableViewCell = "MovieDetailTableViewCell"
    
    
    private var viewModel: SearchDetailViewPresentable!
    var viewModelBuilder: SearchDetailViewPresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel = viewModelBuilder((
            
        ))
        
        
        setupUI()
     
        
        viewModel
            .output
            .searchMediaType
            .map({  media in
                if (media ==  SearchMediaType.music){
                    self.musicSetupBindings()
                } else {
                    self.movieSetupBindings()
                }
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive().disposed(by: bag)
        
        
        viewModel
            .output
            .progress
            .map({  p in
                !p ? KRProgressHUD.show() : KRProgressHUD.dismiss()
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
        
    }
    
}

private extension SearchDetailViewController {
    
    func setupUI() {
        detailTableView.register(with: SearchDetailViewController.MusicDetailTableViewCell)
        detailTableView.register(with: SearchDetailViewController.MovieDetailTableViewCell)
        navigationItem.title = "Details Page"
    }
    
    func musicSetupBindings() {
        
        detailTableView.rowHeight =  63
        
        let musicDataSource = RxTableViewSectionedReloadDataSource<SearchDetailTableViewModel>(configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailViewController.MusicDetailTableViewCell, for: indexPath) as! MusicDetailTableViewCell
            cell.configure(usingViewModel: item, with: indexPath)
            return cell
        })
        
        viewModel
            .output
            .amgDetails
            .bind(to: detailTableView.rx.items(dataSource: musicDataSource))
            .disposed(by: bag)
        

        viewModel.output.artistName!.drive(artistNameLabel.rx.text).disposed(by: bag)
        subTitleLabel.text =  "Albums"
        
    }
    
    func movieSetupBindings() {
        
        detailTableView.rowHeight =  241
        detailTableView.isScrollEnabled =  false
        
        let movieDataSource = RxTableViewSectionedReloadDataSource<SearchDetailTableViewModel>(configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailViewController.MovieDetailTableViewCell, for: indexPath) as! MovieDetailTableViewCell
            cell.configure(usingViewModel: item, with: indexPath)
            return cell
        })
        
        viewModel
            .output
            .amgDetails
            .bind(to: detailTableView.rx.items(dataSource: movieDataSource))
            .disposed(by: bag)
        

        viewModel.output.artistName!.drive(artistNameLabel.rx.text).disposed(by: bag)
        subTitleLabel.text =  "Movie Details"
        
    }
}



