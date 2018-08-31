//
//  QuoteTableViewCell.swift
//  KanyeAndTrump
//
//  Created by DevMountain on 8/30/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

protocol QuoteTableViewCellDelegate: class{
    
    func toggleTrumpButton(cell: QuoteTableViewCell)
    
    func textFieldChanged(cell: QuoteTableViewCell, newAuthor: String)
}

class QuoteTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var trumpButton: UIButton!
    @IBOutlet weak var authorTextField: UITextField!
    
    weak var delegate: QuoteTableViewCellDelegate?
    
    var quote: Quote?{
        didSet{
            updateView()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newAuthor = textField.text else {return}
        delegate?.textFieldChanged(cell: self, newAuthor: newAuthor)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        authorTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateView(){
        
        guard let quote = quote else {return}
        
        quoteLabel.text = quote.text
        authorTextField.text = quote.author
        updateButton()
    }
    
    func updateButton(){
        guard  let quote = quote else {return}
        
        if quote.isKanyeQuote{
            trumpButton.setImage(#imageLiteral(resourceName: "Kanye"), for: .normal)
        }else if quote.isTrumpQuote{
            trumpButton.setImage(#imageLiteral(resourceName: "trump"), for: .normal)
        }else{
            trumpButton.setImage(#imageLiteral(resourceName: "emptyState"), for: .normal)
        }
    }
    
    
    @IBAction func trumpButtonTapped(_ sender: UIButton) {
        delegate?.toggleTrumpButton(cell: self)
    }
    
}


















