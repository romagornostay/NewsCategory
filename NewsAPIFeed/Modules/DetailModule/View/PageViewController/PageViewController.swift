//
//  PageViewController.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 27.09.2023.
//

import SwiftUI

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    
    var pages: [Page]
    @Binding var currentPage: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        page.dataSource = context.coordinator
        page.delegate = context.coordinator
        return page
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers([context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    class Coordinator: NSObject , UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        let parent: PageViewController
        var controllers = [UIViewController]()

        init(_ parent: PageViewController) {
            self.parent = parent
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            return index == .zero ? controllers.last : controllers[index - 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            return index == controllers.count - 1 ? controllers.first : controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            guard completed, let currentController = pageViewController.viewControllers?.first,
                             let index = controllers.firstIndex(of: currentController)  else { return }
            parent.currentPage = index
        }
    }
    
}
