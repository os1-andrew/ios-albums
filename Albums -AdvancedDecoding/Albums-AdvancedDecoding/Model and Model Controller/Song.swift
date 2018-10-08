//
//  Song.swift
//  Albums-AdvancedDecoding
//
//  Created by Andrew Dhan on 10/8/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

struct Song: Decodable {
    
    //MARK: - ENUM
    
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case id
        enum DurationKey: String, CodingKey {
            case duration
        }
        enum TitleKey: String, CodingKey {
            case title
        }
    }
    
    //MARK: - Initializers
    init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let titleContainer = try container.nestedContainer(keyedBy: CodingKeys.TitleKey.self, forKey: .name)
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationKey.self, forKey: .duration)
        
        
        self.name = try titleContainer.decode(String.self, forKey: .title)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    
    
    //MARK: -Properties
    var name: String
    var duration: String
    var id: String
    
}
