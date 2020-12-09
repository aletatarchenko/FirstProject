//
//  ProgramsResponse.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import Foundation

struct ProgramsResponse: Codable {
  let programs: [Program]
  let playlists: [Playlist]
  let type: String
}

// MARK: - Playlist
struct Playlist: Codable {
  let id: String
  let order: Int
  let title: String
  let cover: Cover
  let trackKeys: [String]
}

// MARK: - Cover
struct Cover: Codable {
  let url: String
  let thumbnail: String
  let resolutions: [CoverResolution]
}

// MARK: - CoverResolution
struct CoverResolution: Codable {
  let url: String
  let size: Int
}

// MARK: - Program
struct Program: Codable {
  let id, title: String
  let isAvailable, isFree, isFeatured: Bool
  let banner: Banner?
  let cover: Cover
  let headphones: Bool
  let descriptionHTML: String?
  let tracks: [Track]
}

// MARK: - Banner
struct Banner: Codable {
  let url: URL
  let thumbnail: String
  let resolutions: [BannerResolution]
}

// MARK: - BannerResolution
struct BannerResolution: Codable {
  let url: String
  let size: Size
}

// MARK: - Size
struct Size: Codable {
  let width, height: Int
}

// MARK: - Track
struct Track: Codable {
  let key, title: String
  let order: Int?
  let duration: Int
  let media: Media
  let isAvailable: Bool
}

// MARK: - Media
struct Media: Codable {
  let mp3: Mp3
}

// MARK: - Mp3
struct Mp3: Codable {
  let url, headURL: URL

  enum CodingKeys: String, CodingKey {
    case url
    case headURL = "headUrl"
  }
}
