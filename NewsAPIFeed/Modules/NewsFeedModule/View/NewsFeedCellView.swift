//
//  NewsFeedCellView.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 29.10.2023.
//

import SwiftUI

struct NewsFeedCellView: View {
    
    var newsViewModel: NewsViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            VStack(spacing: 4) {
                Text(newsViewModel.title)
                    .foregroundStyle(.primary)
                    .lineLimit(3)
                    .font(.system(.title3, weight: .medium).uppercaseSmallCaps())
                Text(newsViewModel.subtitle)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer()
            AsyncImage(url: newsViewModel.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 100, height: 120, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }
    }
}

struct NewsFeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NewsFeedCellView(newsViewModel: .defaultModel)
            NewsFeedCellView(newsViewModel: .defaultModel)
            NewsFeedCellView(newsViewModel: .defaultModel)
        }
    }
}

