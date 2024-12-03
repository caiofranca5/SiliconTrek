//
//  CategoryDetailView.swift
//  ProjectSilicon
//
//  Created by Caio França on 25/11/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ExploreViewModel.self) private var viewModel
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
                    
                    Color(.siliconBackground)
                        .frame(height: 150)
                        .offset(y: +100)
                    
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
                            .background(Color(.siliconBackground))
                        })
                        
                    })
                    .background(Color(.siliconBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                })
            })
            .navigationBarBackButtonHidden()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 17, weight: .regular))
                                .padding(.trailing, 32)
                        }
                    }
                }
            })
            .tint(.white)
            .background(category.tintColor)
            .onAppear(perform: viewModel.loadLandmarks)
        })
    }
}

#Preview {
    NavigationStack(root: {
        CategoryDetailView(category: LandmarkCategory.nature)
            .environment(ExploreViewModel())
    })
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
