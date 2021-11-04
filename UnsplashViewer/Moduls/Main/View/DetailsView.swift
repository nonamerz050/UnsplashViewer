//
//  DetailsViewModel.swift
//  UnsplashViewer
//
//  Created by MacBook Pro on 4/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel = MainViewModel()
    var photo: Photo
    var body: some View {
        VStack {
                WebImage(url: URL(string: photo.url!))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .padding(.horizontal, 10.0)
                VStack {
                    HStack {
                        Text("Author: ")
                        Text(photo.username!)
                            .fontWeight(.semibold)
                    }
                    Text("Download: " + (photo.date ?? "no date"))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20.0)
                    Spacer()
            }            
        }
    }
}
