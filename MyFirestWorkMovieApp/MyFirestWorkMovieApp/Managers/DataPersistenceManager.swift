//
//  DataPersistenceManager.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 13.12.2022.
//

import Foundation
import UIKit
import CoreData


class DataPersistenceManager{
    
    enum DataBaseError: Error {
    case failedToSaveData
    case faildedToFetchData
    case faildedToDeleteData
        
    }
    
    static let shared = DataPersistenceManager()
    
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DataBaseError.failedToSaveData))
        }
    }
    func fetchingTitleFromDataBase(completion: @escaping (Result<[TitleItem], Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
            
            
        }catch{
            completion(.failure(DataBaseError.faildedToFetchData))
        }
    }
    func deleteTitleWith(model:TitleItem, completion: @escaping(Result<Void, Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DataBaseError.faildedToDeleteData))
        }
    }
}
