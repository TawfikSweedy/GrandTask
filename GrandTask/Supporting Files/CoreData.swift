//
//  CoreData.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/17/23.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    // MARK: - public valriables
    func addToMatches(id : String , status: String, result: String, homeTeam : String, date: String, awayTeam : String) {
        var cartProducts : [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MatchesEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            cartProducts = try managedContext.fetch(fetchRequest)
                let entity = NSEntityDescription.entity(forEntityName: "MatchesEntity", in: managedContext)!
                let product = NSManagedObject(entity: entity, insertInto: managedContext)
                product.setValue(id, forKeyPath: "id")
                product.setValue(status, forKeyPath: "status")
                product.setValue(result, forKeyPath: "result")
                product.setValue(homeTeam, forKeyPath: "homeTeam")
                product.setValue(date, forKeyPath: "date")
                product.setValue(awayTeam, forKeyPath: "awayTeam")
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    // MARK: - public valriables
    func getMatches() -> [NSManagedObject] {
        var cartProducts: [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MatchesEntity")
        do {
            cartProducts = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return cartProducts
    }
    func emptyMatches() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MatchesEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
