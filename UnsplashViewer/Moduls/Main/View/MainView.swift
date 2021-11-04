//
//  MainView.swift
//  UnsplashViewer
//
//  Created by MacBook Pro on 4/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.timestamp, ascending: true)],
        animation: .default)
    var photos: FetchedResults<Photo>
    @State var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !photos.isEmpty {
                    LazyVStack {
                        ForEach(photos) { photo in
                            NavigationLink(destination: DetailsView(photo: photo), label: {
                                WebImage(url: URL(string: photo.url ?? ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: .center)
                                    .cornerRadius(15)
                            })
                                .onAppear {
                                    if photo.id == photos.last?.id {
                                        viewModel.loadData()
                                    }
                                }
                            Text("Author: " + (photo.username ?? ""))
                        }
                    }
                }
            }
            .navigationTitle("Unsplash Viewer")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView()
            .environment(\.managedObjectContext, viewContext)
    }
}
