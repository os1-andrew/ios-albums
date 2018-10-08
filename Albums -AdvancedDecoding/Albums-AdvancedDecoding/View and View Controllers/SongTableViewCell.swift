//
//  SongTableViewCell.swift
//  Albums-AdvancedDecoding
//
//  Created by Andrew Liao on 10/8/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBAction func addSong(_ sender: Any) {
    }
    //MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
}
