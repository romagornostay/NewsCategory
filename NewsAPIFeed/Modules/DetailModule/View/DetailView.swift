//
//  DetailView.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 01.10.2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        PageViewController(pages: viewModel.articles.map { ArticleView(article: $0).environmentObject(viewModel) },
                           currentPage: $viewModel.newsIndex
        )
        .edgesIgnoringSafeArea(.all)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
