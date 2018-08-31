//
//  QuoteTableViewController.swift
//  KanyeAndTrump
//
//  Created by DevMountain on 8/30/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit
import CoreData

class QuoteTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, QuoteTableViewCellDelegate{
    
    
    func textFieldChanged(cell: QuoteTableViewCell, newAuthor: String) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let quote = fetchedResultsController.fetchedObjects?[indexPath.row]
        quote?.author = newAuthor
    }
    
    
    var selectedIndexPath: IndexPath?
    
    func toggleTrumpButton(cell: QuoteTableViewCell) {
        
        guard let image = cell.trumpButton.imageView?.image,
            let indexPath = tableView.indexPath(for: cell),
            let quote = fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
        
        switch image{
        case #imageLiteral(resourceName: "Kanye"):
            quote.author = "Trump"
        case #imageLiteral(resourceName: "trump"):
            quote.author = "Kaden"
        case #imageLiteral(resourceName: "emptyState"):
            quote.author = "Kanye"
        default:
            print("Default")
        }
    }
    
    //MARK: Properties
    let fetchedResultsController: NSFetchedResultsController<Quote> = {
        
        let fetchRequest: NSFetchRequest<Quote> = Quote.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? QuoteTableViewCell
        let quote = fetchedResultsController.fetchedObjects?[indexPath.row]
        cell?.quote = quote
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let quote = fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            CoreDataStack.delete(quote: quote)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            guard let detailVC = segue.destination as? QuoteViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            let quote = fetchedResultsController.fetchedObjects?[indexPath.row]
            detailVC.quote = quote
        }
    }
    
    func presentAlertController(){
        let alertController = UIAlertController(title: "Enter a Quote", message: "We recommend it is from Kanye or Trump", preferredStyle: .alert)
        alertController.addTextField { (quoteTextField) in
            quoteTextField.placeholder = "Quote"
        }
        alertController.addTextField { (authorTextField) in
            authorTextField.placeholder = "Author"
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            
            guard let quoteText = alertController.textFields?[0].text,
                let authorText = alertController.textFields?[1].text else {return}
            
            Quote(text: quoteText, author: authorText)
            CoreDataStack.saveToPersistentStore()
            self.tableView.reloadData()
        }
        alertController.addAction(dismissAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true)
    }
    
    
    @IBAction func addQuoteButtonTapped(_ sender: UIBarButtonItem) {
        presentAlertController()
    }
    
}







