//
//  ContentView.swift
//  CombineNetworkmanager
//
//  Created by Victor Sebastin on 2023-09-18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(Array(viewModel.articles.enumerated()), id: \.element.id) { index, item in
                        NavigationLink(destination: DetailView(artWork: $viewModel.articles[index])) {
                            ArticleCellView(artWork: item)
                        }
                    }
                    
                    if viewModel.state == .loading {
                        ProgressView()
                    }
                }
                .navigationTitle("My Top 10")
                .frame( maxWidth: .infinity)
                .listStyle(GroupedListStyle())
            }
            .onAppear {
                viewModel.fetchAPI()
            }
        }
        
    }
}

struct ArticleCellView: View {
    var artWork: Artwork
    var body: some View {
        HStack {
            Image("banner")
                .resizable()
                .frame(width: 130, height: 80)
                .cornerRadius(4)
                .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(artWork.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                HStack(spacing: 3) {
                    Text("Published on:")
                    Text(artWork.formattedTimeStamp)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.blue)
                .font(.caption)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
