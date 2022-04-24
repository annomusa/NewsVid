//
//  YoutubeService.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation
import GoogleAPIClientForREST_YouTube

class YoutubeService {
    
    private let key: String
    private let service: GTLRYouTubeService
    private var nextPageToken: String?
    
    init() {
        key = Config.instance.googleKey
        service = GTLRYouTubeService()
        service.apiKey = Config.instance.googleKey
    }
    
    func searchVideoWith(query: String) async throws -> [VideoSearchResult] {
        return try await withCheckedThrowingContinuation { continuation in
            let videoQuery = GTLRYouTubeQuery_SearchList.query(withPart: ["snippet"])
            videoQuery.q = query
            videoQuery.maxResults = 25
            if let nextPageToken = nextPageToken {
                videoQuery.pageToken = nextPageToken
            }
            service.executeQuery(videoQuery) { ticket, response, err in
                let res = response as? GTLRYouTube_SearchListResponse
                self.nextPageToken = res?.nextPageToken
                guard let res = res else {
                    continuation.resume(throwing: NSError(domain: "com.progrsv.NewsVid", code: 1001))
                    return
                }
                let items = self.convertToVideoResult(response: res)
                
                continuation.resume(returning: items)
            }
        }
    }
    
    private func convertToVideoResult(response: GTLRYouTube_SearchListResponse) -> [VideoSearchResult] {
        guard let items = response.items else { return [] }
        
        var result: [VideoSearchResult] = []
        
        for item in items where item.snippet != nil {
            guard let id = item.identifier,
                  let snippet = item.snippet,
                  let title = snippet.title,
                  let desc = snippet.descriptionProperty,
                  let videoID = id.videoId,
                  let thumbnailObj = snippet.thumbnails?.medium,
                  let thumbnailString = thumbnailObj.url,
                  let thumbnailURL = URL(string: thumbnailString)
            else {
                continue
            }
            
            result.append(
                VideoSearchResult(
                    videoID: videoID,
                    channelID: id.channelId,
                    thumbnails: thumbnailURL,
                    thumbnailsWidth: UInt(truncating: thumbnailObj.width ?? 0),
                    title: title,
                    desc: desc
                )
            )
        }
        return result
    }
    
}

struct VideoSearchResult: Identifiable, Hashable {
    
    var id: String { videoID }
    let videoID: String
    let channelID: String?
    let thumbnails: URL
    let thumbnailsWidth: UInt?
    let title: String
    let desc: String
    
}
