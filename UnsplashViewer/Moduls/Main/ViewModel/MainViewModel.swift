//
//  MainViewModel.swift
//  UnsplashViewer
//
//  Created by MacBook Pro on 4/11/21.
//

import Foundation
import SwiftUI
import CoreData

class MainViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.timestamp, ascending: true)],
        animation: .default)
    var photos: FetchedResults<Photo>
    @State var photoArray: [PhotoElement] = []
    let network = NetworkManager()
    var pageNumber = 1
    
    //форматирование даты
    private func getDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: now)
        return dateString
    }
    //загрузка даты из сети
    func loadData() {
            network.request(page: pageNumber) { (data, error) in
                guard let data = data else {
                    print("URLSession data error:", error ?? "nil")
                    return
                }
                do {
                    let json =  try JSONDecoder().decode([PhotoElement].self, from: data)
                    for item in json {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.photoArray.append(item)
                        }
                        self.addToCoreData(item: item)
                    }
                } catch {
                    print(error)
                }
            }
        pageNumber += 1
    }
    //добавление в CoreData
    func addToCoreData(item:PhotoElement) {
        var isEqual = false
        
        for photo in photos {
            if photo.id == item.id {
                isEqual = true
            }
        }
        if !isEqual {
            let viewContext = PersistenceController.shared.container.viewContext
            let photo = Photo(context: viewContext)
            photo.id = item.id
            photo.username = item.user.name ?? "No author"
            photo.url = item.urls.small
            photo.date = getDate()
            do {
              try viewContext.save()
            } catch {
                print("Error saving managed object context: \(error)")
            }
        }
    }
}
