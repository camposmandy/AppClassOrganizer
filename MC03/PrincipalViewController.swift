//
//  PrincipalViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {

    @IBOutlet weak var labelDia: UILabel!
    @IBOutlet weak var labelMes: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func buttonNota(sender: AnyObject) {
    }
    
    @IBAction func buttonFalta(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var date = NSDate()
        
        var dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "dd"
        var dayString = dayFormatter.stringFromDate(date)
        
        var monthFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MMMM"
        var monthString = monthFormatter.stringFromDate(date)
        
        labelDia.text = dayString
        labelMes.text = monthString
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
}
