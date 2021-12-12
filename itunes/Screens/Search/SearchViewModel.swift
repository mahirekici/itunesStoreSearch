//
//  SearchViewModel.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewPresentable {
    
    typealias Input = (
        search:Driver<String>,
        navArtist: Driver<SearchCellViewModel>,
        music:Driver<Void>,
        movie:Driver<Void>
    )
    typealias Output = (
        stockCells: Observable<[SearchTableViewModel]>,
        progress  :Observable<Bool?>?
    )
 
    
    typealias Dependencies = (service: AppAPI, ())
    typealias ViewModelBuilder = (Input) -> SearchViewPresentable
    
    var input: Input { get }
    var output: Output { get }
    
    func checkDidEnd(indexPath :IndexPath)
}

final class SearchViewModel: SearchViewPresentable {
    
    let input: Input
    let output: Output
    private let dependencies: Dependencies
    
    var router: SearchViewRouter!
    
    typealias State = (data:BehaviorRelay<[SearchResultDto]>,progress:BehaviorRelay<Bool?>?) //  yeni bir tip oluştur
    
    private let state: State = (data:BehaviorRelay(value: []),progress:BehaviorRelay(value: true))// ilkd değerleri ata
    
    
    private let bag = DisposeBag()
    
    var offset = 0
    var searchTerm = ""
    var searchMediaType  =  SearchMediaType.music
    
    
    init(input: Input, dependencies: Dependencies) {
        self.input = input
        
        self.output = SearchViewModel.output(input: input, state: state)
        self.dependencies = dependencies
        
        
        input.search
            .debounce(.milliseconds(500))
            .asObservable()
            .map({ [weak self] term in
                if (self!.searchTerm == term) {
                    return
                }
                self!.seacrh(term: term)
                
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
        
        input.music
            .asObservable()
            .map({ [ self] term in
                searchMediaType = SearchMediaType.music
                seacrh(term: searchTerm)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
        input.movie
            .asObservable()
            .map({ [self] term in
                searchMediaType = SearchMediaType.movie
                seacrh(term: searchTerm)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
        selectArtist()
        
        
    }
    
    
}

 extension SearchViewModel {
    
    static func output(input: Input, state: State) -> Output {
        
        let stocksObservable = state.data.asObservable()
        let progressObserver  = state.progress?.asObservable()
        
        let stocksCells = stocksObservable
            .map({ stocks -> [SearchTableViewModel] in
                [SearchTableViewModel(title: "",
                                      items: stocks.map({
                                        SearchCellViewModel(result: $0)
                                      }))
                ]
            })
        
        
        return (
            stockCells: stocksCells,
            progress:progressObserver
        
        )
    }
    
    private func seacrh(term:String){
        if (term.count > 1)
        {
            offset = 0
            state.data.accept([])
            searchTerm =  term
            fetchItunes(with: term)
        }
    }
    
    
  private  func fetchItunes(with term: String) {
        
        state.progress?.accept(false)
        dependencies
            .service
            .search(term: term, limit: 20, offset: offset, searchMediaType: searchMediaType)
            .map({ stocks in
                
                if (stocks.results?.count ?? 0 > 0){
                    self.offset +=  stocks.resultCount!
                    self.state.data.accept(  (self.state.data.value) +  stocks.results!)
                }
                self.state.progress?.accept(true)

            })
            .subscribe()
            .disposed(by: bag)
    }
    

      func checkDidEnd(indexPath: IndexPath) {
       
        if state.data.value.count ==  indexPath.row + 1 {
            fetchItunes(with: searchTerm)
        }
    }
    
    private  func selectArtist(){
        
        input.navArtist
            .asObservable()
            .map({ view in
                
                let id  =  self.searchMediaType  == SearchMediaType.music
                    ? view.artistId
                    :  view.trackId
                self.router.routeToDetail(with: id ?? 0, searchMediaType: self.searchMediaType)
                
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
    }
    
 
   
   
}
