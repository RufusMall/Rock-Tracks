// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rockTrackResponse = try? newJSONDecoder().decode(RockTrackResponse.self, from: jsonData)

import Foundation

// MARK: - RockTrackResponse
public struct TrackListResponse: Codable {
    public let resultCount: Int
    public let results: [Track]

    public init(resultCount: Int, results: [Track]) {
        self.resultCount = resultCount
        self.results = results
    }
}

// MARK: - Result
public struct Track: Codable {
    public let artistID: Int
    public let artistName: String
    public let artistViewURL: String
    public let artworkUrl100, artworkUrl30, artworkUrl60: String
    public let collectionArtistID: Int?
    public let collectionArtistName: String?
    public let collectionArtistViewURL: String?
    public let collectionCensoredName, collectionExplicitness: String
    public let collectionID: Int
    public let collectionName: String
    public let collectionPrice: Double
    public let collectionViewURL: String
    public let country, currency: String
    public let discCount, discNumber: Int
    public let isStreamable: Bool
    public let kind: String
    public let previewURL: String
    public let primaryGenreName, releaseDate, trackCensoredName: String
    public let trackCount: Int
    public let trackExplicitness: String
    public let trackID: Int
    public let trackName: String
    public let trackNumber: Int
    public let trackPrice: Double
    public let trackTimeMillis: Int
    public let trackViewURL: String
    public let wrapperType: String
    public let contentAdvisoryRating: String?

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case artistName
        case artistViewURL = "artistViewUrl"
        case artworkUrl100, artworkUrl30, artworkUrl60
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case collectionCensoredName, collectionExplicitness
        case collectionID = "collectionId"
        case collectionName, collectionPrice
        case collectionViewURL = "collectionViewUrl"
        case country, currency, discCount, discNumber, isStreamable, kind
        case previewURL = "previewUrl"
        case primaryGenreName, releaseDate, trackCensoredName, trackCount, trackExplicitness
        case trackID = "trackId"
        case trackName, trackNumber, trackPrice, trackTimeMillis
        case trackViewURL = "trackViewUrl"
        case wrapperType, contentAdvisoryRating
    }

    public init(artistID: Int, artistName: String, artistViewURL: String, artworkUrl100: String, artworkUrl30: String, artworkUrl60: String, collectionArtistID: Int?, collectionArtistName: String?, collectionArtistViewURL: String?, collectionCensoredName: String, collectionExplicitness: String, collectionID: Int, collectionName: String, collectionPrice: Double, collectionViewURL: String, country: String, currency: String, discCount: Int, discNumber: Int, isStreamable: Bool, kind: String, previewURL: String, primaryGenreName: String, releaseDate: String, trackCensoredName: String, trackCount: Int, trackExplicitness: String, trackID: Int, trackName: String, trackNumber: Int, trackPrice: Double, trackTimeMillis: Int, trackViewURL: String, wrapperType: String, contentAdvisoryRating: String?) {
        self.artistID = artistID
        self.artistName = artistName
        self.artistViewURL = artistViewURL
        self.artworkUrl100 = artworkUrl100
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.collectionArtistID = collectionArtistID
        self.collectionArtistName = collectionArtistName
        self.collectionArtistViewURL = collectionArtistViewURL
        self.collectionCensoredName = collectionCensoredName
        self.collectionExplicitness = collectionExplicitness
        self.collectionID = collectionID
        self.collectionName = collectionName
        self.collectionPrice = collectionPrice
        self.collectionViewURL = collectionViewURL
        self.country = country
        self.currency = currency
        self.discCount = discCount
        self.discNumber = discNumber
        self.isStreamable = isStreamable
        self.kind = kind
        self.previewURL = previewURL
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
        self.trackCensoredName = trackCensoredName
        self.trackCount = trackCount
        self.trackExplicitness = trackExplicitness
        self.trackID = trackID
        self.trackName = trackName
        self.trackNumber = trackNumber
        self.trackPrice = trackPrice
        self.trackTimeMillis = trackTimeMillis
        self.trackViewURL = trackViewURL
        self.wrapperType = wrapperType
        self.contentAdvisoryRating = contentAdvisoryRating
    }
}
