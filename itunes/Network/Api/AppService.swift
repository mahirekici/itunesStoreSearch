import RxSwift
import Alamofire
import SwiftyJSON

final class AppService {
    
    private let httpService: RequestService = RequestService()
    
    private init() {}
    
    static let shared: AppService = AppService()
}

extension AppService: AppAPI {
    func search(term: String, limit: Int,offset: Int,searchMediaType:SearchMediaType) -> Single<SearchDto> {
        
        Single.create { [httpService] single -> Disposable in
            
            
            httpService.search(term: term,limit: limit, offset: offset, searchMediaType: searchMediaType) { model in
                single(.success(model))
            } failure: { error in
                single(.failure(NetworkError.custom(description: "Error while handshake")))
            }

            
            return Disposables.create()
        }
    }
    
    func searchDetail(id: String) -> Single<DetailsDto> {
        
        Single.create { [httpService] single -> Disposable in
            
            
            httpService.lookupArtistId(id: id) { model in
                single(.success(model))
            } failure: { error in
                single(.failure(NetworkError.custom(description: "Error while handshake")))
            }

            
            
            return Disposables.create()
        }
    }
    

}
