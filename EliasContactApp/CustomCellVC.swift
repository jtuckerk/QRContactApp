//
//  CustomCellVC.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/11/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit

class CustomCellVC: UITableViewCell {

    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var sublabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
