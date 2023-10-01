//
//  ArticleView.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 11.09.2023.
//

import SwiftUI

struct ArticleView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var article: Article
    @EnvironmentObject var viewModel: DetailViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    headerImageView(height: 400).frame(height: 400)
                    contentTextView.padding(.horizontal, 18)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onReceive(viewModel.$closePresenter) { close in
            if close { dismiss() }
        }
    }
}

// MARK: - Header View
extension ArticleView {
    
    private func headerImageView(height: CGFloat) -> some View {
        GeometryReader { geometry in
            ZStack {
                AsyncImage(url: article.urlToImage) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.1)
                }.frame(width: geometry.size.width, height: height).clipped()
                
                headerGradient
                    .frame(width: geometry.size.width, height: height)
                
                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark").resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 60)
                    
                    Spacer()
                    
                    headerDataView
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                    
                }.frame(width: geometry.size.width, height: height)
            }.frame(width: geometry.size.width, height: height)
        }
    }
    
    private var headerGradient: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LinearGradient(
                    gradient: Gradient(colors: [.black, .black.opacity(0)]),
                    startPoint: .bottom, endPoint: .top
                ).frame(height: (geometry.size.height / 100) * 50)
            }
        }
    }
    
    private var headerDataView: some View {
        VStack(spacing: 20) {
            Text(article.title ?? "").lineLimit(3)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
            
            HStack(alignment: .center) {
                Text(article.source.name ?? "_Unknown_").foregroundColor(.white)
                    .font(.subheadline)
                Spacer()
                HStack(alignment: .bottom, spacing: 8) {
                    Image(systemName: "calendar.badge.clock.rtl").resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 16, height: 16)
                    Text(article.publishedDate ?? "")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.bottom, -2)
                }
            }.padding(.horizontal, 4)
        }
    }
    
}

// MARK: - Content Text View
extension ArticleView {
    
    private var contentTextView: some View {
        VStack(spacing: 20) {
            authorView
            Text(article.content ?? "")
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(UIColor.label).opacity(0.75))
                .font(.callout)
                .frame(maxWidth: .infinity)
            Button(action: viewModel.openNewsUrl) {
                Text("READ MORE")
                    .padding()
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .background(Color.primary)
            }.padding(.vertical)
        }
    }
    
    private var authorView: some View {
        HStack {
            Text(article.author ?? "Unowned")
                .foregroundColor(Color(UIColor.label))
                .font(.system(.subheadline))
            Spacer()
            Button(action: viewModel.openNewsUrl) {
                Image(systemName: "chart.bar.doc.horizontal").resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(UIColor.label))
                    .frame(width: 20, height: 20)
            }
        }
    }
    
}


