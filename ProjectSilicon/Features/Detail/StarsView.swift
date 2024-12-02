//
//  StarsView.swift
//  ProjectSilicon
//
//  Created by Caio França on 23/11/24.
//

import SwiftUI

class Star: Identifiable {
    let id = UUID()
    let value: String
    
    init(value: String) {
        self.value = value
    }
}

extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}

struct StarsView: View {
    
    let fontSize: CGFloat
    let voteAverage: Double
    let voteCount: Int

    var body: some View {
        
        HStack(alignment: .center, spacing: 2, content: {
            
            ForEach(getStarRatingArray(rating: voteAverage), id: \.id) { i in
                switch i.value {
                case "f":
                    Image(systemName: "star.fill")
                        .font(.system(size: fontSize, weight: .medium))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.siliconYellow)
                case "h":
                    Image(systemName: "star.leadinghalf.filled")
                        .font(.system(size: fontSize, weight: .medium))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.siliconYellow)
                default:
                    Image(systemName: "star")
                        .font(.system(size: fontSize, weight: .medium))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.siliconYellow)
                }
            }
            
            Text(getVoteCount(count: voteCount))
                .font(.system(size: fontSize - 2, weight: .regular))
                .fontDesign(.rounded)
                .foregroundColor(.secondary)
                .padding(.leading, 5)
            
        })
    }
    
    func getStarRatingArray(rating: Double) -> [Star] {
        var starRatingArray: [Star] = []
        
        let fullStar = "f"
        let halfStar = "h"
        let emptyStar = "e"
        
        var remainingRating = rating.round(nearest: 0.5)
        
        for _ in 1...5 {
            if remainingRating >= 1.0 {
                starRatingArray.append(Star(value: fullStar))
            } else if remainingRating >= 0.5 {
                starRatingArray.append(Star(value: halfStar))
            } else {
                starRatingArray.append(Star(value: emptyStar))
            }
            
            remainingRating -= 1.0
        }
        
        return starRatingArray
    }
    
    func getVoteCount(count: Int) -> String {
        if voteCount >= 0 && voteCount <= 999 {
            return "\(voteCount)"
        } else if count < 1000000 {
            let votes = Float(voteCount)/1000
            return String(format: "%.1f", votes) + "k"
        } else {
            let votes = Float(voteCount)/1000000
            return String(format: "%.1f", votes) + "M"
        }
    }

}

struct MovieStarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView(fontSize: 15, voteAverage: 2, voteCount: 13000)
    }
}
