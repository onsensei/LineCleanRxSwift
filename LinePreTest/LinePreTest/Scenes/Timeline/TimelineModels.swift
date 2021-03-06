//
//  TimelineModels.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 28/12/62 BE.
//  Copyright (c) 2562 Thanaphat Suwannikornkul. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

// MARK: - Response Json Object (NewsFeed)

struct ResponseAlbum: Codable {
    let meta: Meta
    let result: [ResultAlbum]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

struct Meta: Codable {
    let success: Bool
    let code: Int
    let message: String
    let totalCount, pageCount, currentPage, perPage: Int
    let rateLimit: RateLimit
}

struct RateLimit: Codable {
    let limit, remaining, reset: Int
}

struct ResultAlbum: Codable {
    let id, userID, title: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case links = "_links"
    }
}

struct Links: Codable {
    let linksSelf, edit: Edit

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case edit
    }
}

struct Edit: Codable {
    let href: String
}

struct ResponsePhoto: Codable {
    let meta: Meta
    let result: [ResultPhoto]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

struct ResultPhoto: Codable {
    let id, albumID, title: String
    let url, thumbnail: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case title, url, thumbnail
        case links = "_links"
    }
}

// MARK: - ViewModel Object (NewsFeed)

struct PostAlbum
{
  var title:String
  var photos:[PostPhoto]
}

struct PostPhoto
{
  var title:String
  var url:String
  var thumbnail:String
}

enum RequestNewsFeedType
{
  case first
  case refresh
//  case append
}

enum Timeline
{
  // MARK: Use cases
  
  enum NewsFeed
  {
    struct Request
    {
      var requestType:RequestNewsFeedType
    }
    struct Response
    {
      var resultAlbums:[ResultAlbum]
      var albumPhotosDict:[String:ResponsePhoto]
    }
    struct ViewModel
    {
      var postAlbums:[PostAlbum]
    }
  }
  
  enum FilteredNewsFeed
  {
    struct Request
    {
      var searchText:String
    }
    struct Response
    {
      var resultAlbums:[ResultAlbum]
      var albumPhotosDict:[String:ResponsePhoto]
    }
    struct ViewModel
    {
      var postAlbums:[PostAlbum]
    }
  }
}
