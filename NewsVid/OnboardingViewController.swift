//
//  OnboardingViewController.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation
import UIKit
import Alamofire
import GoogleAPIClientForREST_YouTube

class OnboardingViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        request()
    }
    
    private func request() {
        let service = GTLRYouTubeService()
        service.apiKey = Config.instance.googleKey
        let query = GTLRYouTubeQuery_SearchList.query(withPart: ["snippet"])
        query.q = "ukraine"
        query.maxResults = 25
        service.executeQuery(query) { ticket, response, err in
            
        }
    }
}
