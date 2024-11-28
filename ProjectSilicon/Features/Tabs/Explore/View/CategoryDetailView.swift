//
//  CategoryDetailView.swift
//  ProjectSilicon
//
//  Created by Caio França on 25/11/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @EnvironmentObject var viewModel: ExploreViewModel
    let category: LandmarkCategory
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: 0, content: {
                Label(category.rawValue, systemImage: category.icon)
                    .font(.system(size: 28, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16)
                
                ZStack(alignment: .bottom, content: {
                    
                    Color.init(.systemBackground)
                        .frame(height: 50)
                    
                    VStack(content: {
                        Spacer()
                            .frame(height: 24)
                        
                        ScrollView(content: {
                            VStack(spacing: 24) {
                                let landmarks = viewModel.landmarks.filter { $0.category == category }
                                
                                ForEach(landmarks, id: \.self) { landmark in
                                    Button(action: {
                                        viewModel.navigationPath.append(landmark)
                                    }) {
                                        LandmarkListCellView(screenSize: geometry.size, landmark: landmark)
                                    }
                                }
                            }
                            .background(Color.init(uiColor: .systemBackground))
                        })
                        
                    })
                    .background(Color.init(uiColor: .systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                })
            })
            .background(category.tintColor)
            .onAppear(perform: viewModel.loadLandmarks)
        })
    }
}

#Preview {
    NavigationStack(root: {
        CategoryDetailView(category: LandmarkCategory.nature)
    })
}

class LandmarkCategoryHostingController<Content: View>: UIHostingController<Content> {
    var backButtonColor: UIColor?
    var navbarBackgroundColor: UIColor?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationBar = navigationController?.navigationBar, let color = backButtonColor {

            // Ensure navigation bar style persists during scrolls
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navbarBackgroundColor
            appearance.shadowColor = nil
            navigationBar.tintColor = color
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance

        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            navigationBar.tintColor = .accent
            appearance.shadowColor = nil
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
}

struct LandmarkCategoryWrapper<Content: View>: UIViewControllerRepresentable {
    var content: Content
    var backButtonColor: UIColor
    var navbarBackgroundColor: UIColor

    func makeUIViewController(context: Context) -> LandmarkCategoryHostingController<Content> {
        let hostingController = LandmarkCategoryHostingController(rootView: content)
        hostingController.backButtonColor = backButtonColor
        hostingController.navbarBackgroundColor = navbarBackgroundColor
        return hostingController
    }

    func updateUIViewController(_ uiViewController: LandmarkCategoryHostingController<Content>, context: Context) {
        uiViewController.rootView = content
        uiViewController.backButtonColor = backButtonColor
        uiViewController.navbarBackgroundColor = navbarBackgroundColor
    }
}
