//
//  Album.swift
//  Albums-AdvancedDecoding
//
//  Created by Andrew Dhan on 10/8/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

struct Album: Decodable {
    //MARK: - ENUM
    enum CodingKeys:String, CodingKey {
        case name
        case artist
        case id
        case genres
        case coverArt
        case songs
        
        enum ArtKeys: String, CodingKey{
            case url
        }
    }
    
    //MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        self.name = try container.decode(String.self, forKey: .name)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.id = try container.decode(String.self, forKey: .id)
        
        let genreArray = try container.decode([String].self, forKey: .genres)
        self.genres = genreArray.joined(separator: ", ")
        
        self.songs = try container.decode([Song].self, forKey: .songs)
        
        //create unkeyed nested container
        var urlContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var urls = [String]()
        //go through each dictionary in nested container and create container for each element
        while !urlContainer.isAtEnd {
            let urlContainer = try urlContainer.nestedContainer(keyedBy: CodingKeys.ArtKeys.self)
            let url = try urlContainer.decode(String.self, forKey: .url)
            urls.append(url)
        }
        
        //Although I'm only using the first url of the url array, I'm keeping the code to build it since more URLS may be used in the future.
        self.coverArtURL = urls.first ?? ""
    }
    
    
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(artist, forKey: .artist)
        try container.encode(songs, forKey: .songs)
        
        //encode for genres
        var genreContainer = container.nestedUnkeyedContainer(forKey: .genres)
        let genreArray = self.genres.split(separator: ",")
        let genres: [String] = genreArray.compactMap{
            let genre = $0.trimmingCharacters(in: CharacterSet.whitespaces)
            return String(genre)
        }
        try genreContainer.encode(genres)

        //encode for coverArtURL
        var artContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var urlContainer = artContainer.nestedContainer(keyedBy: CodingKeys.ArtKeys.self)
        try urlContainer.encode(coverArtURL, forKey: .url)
        
    }
    //MARK: - Properties
    var name: String
    var artist: String
    var id: String
    var genres: String
    var coverArtURL: String
    var songs: [Song]
}
