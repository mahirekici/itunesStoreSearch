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

protocol SearchDetailViewPresentable {
    
    typealias Input = (
    )
//    typealias Output = (
//        progress  : Observable<Bool>,
//        artistName :Driver<String?>?,
//        wrapperType: Driver<String?>?,
//        artistLinkURL: Driver<String?>?,
//        artistId: Driver<Int?>?,
//        amgArtistId: Driver<String>,
//        amgDetails :Observable<[SearchDetailTableViewModel]>
//    )
    typealias Output = (
        progress  : Observable<Bool>,
        artistName :Driver<String?>?,
//        wrapperType: Driver<String?>?,
//        artistLinkURL: Driver<String?>?,
//        artistId: Driver<Int?>?,
//        amgArtistId: Driver<String>,
        searchMediaType:Observable<SearchMediaType>,
        amgDetails :Observable<[SearchDetailTableViewModel]>
    )
    
    typealias DetailsDependencies = (id: Int, service: AppAPI,searchMediaType:SearchMediaType)
    typealias ViewModelBuilder = (Input) -> SearchDetailViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class SearchDetailViewModel: SearchDetailViewPresentable {
    
    let input: Input
    let output: Output
    private let dependencies: DetailsDependencies
    
    var router: SearchDetailViewRouter!
    
   
    typealias State = (data:BehaviorRelay<[DetailsResultDto]>, progress:BehaviorRelay<Bool>) //  yeni bir tip oluştur
    
    private let state: State = (data:BehaviorRelay(value: []), progress:BehaviorRelay(value: true))// ilkd değerleri ata
    
    
    private let bag = DisposeBag()
    
    
    
    init(input: Input, dependencies: DetailsDependencies) {
        self.input = input
        
        self.output = SearchDetailViewModel.output(input: input, state: state,searchMediaType: dependencies.searchMediaType)
        self.dependencies = dependencies
        
        fetchLookup()
    }
    
    
}

 extension SearchDetailViewModel {
    
    static func output(input: Input, state: State,searchMediaType:SearchMediaType) -> Output {
        
   
      
        let progressObserver  = state.progress.asObservable()
        
        let detailObservable = state.data
        
        
        let artistNameObserver = detailObservable.map({ $0.first?.artistName }).asDriver(onErrorJustReturn: "")
        
        
        let amgDetailsObserver = detailObservable
            .map { r in
                [
                SearchDetailTableViewModel(title: "", items: r.map({ h in
                    SearchDetailCellViewModel(result: h)
                }))
                ]
            }
        
        let searchMediaType  =  Observable<SearchMediaType>.just(searchMediaType)
  
        return (
            progress :progressObserver,
            artistName: artistNameObserver,
            searchMediaType :searchMediaType,
            amgDetails:amgDetailsObserver
            
        )
        
    }
    
    
  private  func fetchLookup() {
        state.progress.accept(false)
        
        dependencies
            .service
            .searchDetail(id: String(dependencies.id))
            .map({ [weak self] stocks in
                self?.state.data.accept(stocks.results!)
                self?.state.progress.accept(true)

            })
            .subscribe()
            .disposed(by: bag)
        
     
    }
    
//  private  func lookupAmgArtistId(id:Int) {
//        state.progress.accept(false)
//      dependencies
//            .service
//            .lookupAmgArtistId(id: String(id))
//        .map({ [weak self] stocks in
//            self?.state.amgArtisDetail.accept(stocks.results!)
//            self?.state.progress.accept(true)
//        })
//        .subscribe()
//        .disposed(by: bag)
//
//
//    }
    
   
}
