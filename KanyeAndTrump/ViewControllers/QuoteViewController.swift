//
//  QuoteViewController.swift
//  KanyeAndTrump
//
//  Created by DevMountain on 8/30/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    
    var quote: Quote?{
        didSet{
            loadViewIfNeeded()
            updateView()
        }
    }
    
    var authorPhoto: UIImage{
        
        guard  let quote = quote else {return #imageLiteral(resourceName: "emptyState")}
        
        if quote.isKanyeQuote{
            return #imageLiteral(resourceName: "Kanye")
        }else if quote.isTrumpQuote{
            return #imageLiteral(resourceName: "trump")
        }else{
            return #imageLiteral(resourceName: "emptyState")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateView(){
        photoImageView.image = authorPhoto
        quoteLabel.text = quote?.text
    }
    

}



















