//
//  DetailView.swift
//  NetworkManager
//
//  Created by Victor Sebastin on 2023-09-17.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @Binding var artWork: Artwork
    
    var body: some View {
        VStack(spacing: 10) {
            Image("banner")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
            Text(artWork.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            VStack {
                Text("Published on")
                    .font(.headline)
                Text(artWork.formattedTimeStamp)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Button {
                print(artWork.api_link)
            } label: {
                Text("Go To Article")
                    .padding(20)
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: 200)
                    .background(content: {
                        Color.black
                    })
                    .cornerRadius(30)
            }
        }
        .padding(10)
    }
    
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(artWork: .constant(Artwork.mock()))
    }
}
