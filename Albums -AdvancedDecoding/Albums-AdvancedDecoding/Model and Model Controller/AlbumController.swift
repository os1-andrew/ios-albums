//
//  AlbumController.swift
//  Albums-AdvancedDecoding
//
//  Created by Andrew Dhan on 10/8/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

/*
 Create a function in the AlbumController called testDecodingExampleAlbum(). This should:
 Get the JSON data from the "exampleAlbum.json" file. (Data(contentsOf: URL))
 Try to decode the JSON using JSONDecoder just like you would if you got this data from an API.
 Check for errors. This is important because it will help you make sure you've correctly implemented the init(from decoder: Decoder) throws initializer in your model objects by giving you an error about what you have potentially done wrong
 */

class AlbumController {
    func testDecodingExampleAlbum(){
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {return}
        
        var albums = [Album]()
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            albums.append(album)
            
        } catch  {
            NSLog("error decoding: \(error)")
        }
        print(albums.count)
    }
    
    func testEncodingExampleAlbum(){
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {return}
        
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            _ = try JSONEncoder().encode(album)
            
        } catch  {
            NSLog("error decoding: \(error)")
        }
        print("Succes!")
    }
}
