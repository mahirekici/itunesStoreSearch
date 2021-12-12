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

final class SearchViewController: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField!
    
    
    @IBOutlet private weak var searchTableView: UITableView!
    
    
    @IBOutlet private weak var musicButton: UIButton!

    @IBOutlet private weak var movieButton: UIButton!

    @IBAction func musicTapButton(_ sender: Any) {
    
        selectFilterbutton(isMusic: true)
    
    }
    
    @IBAction func movieTapButton(_ sender: Any) {
        selectFilterbutton(isMusic: false)
    
    }
    
    
    private let dataSource = RxTableViewSectionedReloadDataSource<SearchTableViewModel>(configureCell: { dataSource, tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.SearhCellIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.configure(usingViewModel: item, with: indexPath)
        
        return cell
    })
        
    private static let SearhCellIdentifier = "SearchTableViewCell"
    
    private var viewModel: SearchViewPresentable!
    var viewModelBuilder: SearchViewPresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewModel =   viewModelBuilder((
              search: searchTextField.rx.text.orEmpty.asDriver(),
              navArtist: searchTableView.rx.modelSelected(SearchCellViewModel.self).asDriver(),
              music: musicButton.rx.tap.asDriver(),
              movie: movieButton.rx.tap.asDriver()
        ))
        
        
        setupUI()
        setupBindings()
    }
    
    private func selectFilterbutton(isMusic:Bool){
        if (isMusic){
            musicButton.setTitleColor(.blue, for: .normal)
            movieButton.setTitleColor(.gray, for: .normal)
        } else {
            musicButton.setTitleColor(.gray, for: .normal)
            movieButton.setTitleColor(.blue, for: .normal)
        }
      
    }
}



private extension SearchViewController {
    
    func setupUI() {
        searchTableView.register(with: SearchViewController.SearhCellIdentifier)
        navigationItem.title = "Itunes Search Screen"
     
        selectFilterbutton(isMusic: true)
       
        
        searchTableView
            .rx
            .willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                self.viewModel.checkDidEnd(indexPath: indexPath)
            })
            .disposed(by: bag)
        
    }
    
    func setupBindings() {
        
        viewModel
            .output
            .stockCells
            .bind(to: searchTableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)

        
        viewModel
            .output
            .progress?.subscribe({ p in
                !p.element!! ? KRProgressHUD.show() : KRProgressHUD.dismiss()
                print("")
            }).disposed(by: bag)
     
    }
}



