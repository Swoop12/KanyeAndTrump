//
//  Quote+Convenience.swift
//  KanyeAndTrump
//
//  Created by DevMountain on 8/30/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation
import CoreData

extension Quote{
    
    @discardableResult
    convenience init(text: String, author: String, context: NSManagedObjectContext = CoreDataStack.context){
        
        self.init(context: context)
        
        self.text = text
        self.author = author
    }
    
    var isKanyeQuote: Bool{
        get{
            if self.author == "Kanye" {
                return true
            }else{
                return false
            }
        }
        set{
            self.author = "Kanye"
        }
    }
    
    var isTrumpQuote: Bool{
        get{
            if self.author == "Trump" {
                return true
            }else{
                return false
            }
        }
        set{
            self.author = "Trump"
        }
    }
    
}
