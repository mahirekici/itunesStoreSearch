//
//  RequestService.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation
import Foundation
import Alamofire



struct RequestService {
    
    func search(term: String?, limit: Int, offset:Int, searchMediaType:SearchMediaType, success: @escaping (SearchDto) -> Void, failure: @escaping (ErrorModel) -> Void) {
      
        let url = "\(Constants.iTunes.baseURL)\("search")"
        let parameters: [String: String] = [
            "term": term!,
            "limit": String(limit),
            "offset": String(offset),
            "media":searchMediaType.rawValue
            ]
    
        AF.request(url, parameters: parameters)
          .validate()
          .responseDecodable(of: SearchDto.self) { response in
           
            if ((response.error) != nil){
                failure(.network(string: "search netwok error"))
            } else {
                guard let respondeModel = response.value else { return }
                success(respondeModel)
            }
        
           
            
        }
        
    }
    
    func lookupArtistId(id: String, success: @escaping (DetailsDto) -> Void, failure: @escaping (ErrorModel) -> Void) {
    
       let url = "\(Constants.iTunes.baseURL)\("lookup")"
       let parameters: [String: String] = ["id": id,"entity":"album"]
        
       AF.request(url, parameters: parameters)
         .validate()
         .responseDecodable(of: DetailsDto.self) { response in
            if ((response.error) != nil){
                failure(.network(string: "lookupArtistId netwok error"))
            } else {
                guard let respondeModel = response.value else { return }
                success(respondeModel)
            }
       }
       
   }
    
}




