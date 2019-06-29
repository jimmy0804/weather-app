//
//  WeatherDetailTableViewCell.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/29/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftDescLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Update UI
    
    func config(leftTitle: String, leftDesc: String) {
        leftTitleLabel.text = leftTitle.uppercased()
        leftDescLabel.text = leftDesc
    }
}
