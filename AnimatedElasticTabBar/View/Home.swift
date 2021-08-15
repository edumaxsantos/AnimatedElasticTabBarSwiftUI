//
//  Home.swift
//  AnimatedElasticTabBar
//
//  Created by Eduardo Santos on 14/08/21.
//

import SwiftUI

struct Home: View {
    @State var currentTab: Tab = .Home
    
    init(size: CGSize, bottomEdge: CGFloat) {
        UITabBar.appearance().isHidden = true
        self.size = size
        self.bottomEdge = bottomEdge
    }
    
    // Matched Geometry Effect
    @Namespace var animation
    var size: CGSize
    var bottomEdge: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04))
                    .tag(Tab.Home)
                
                Text("Settings")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04))
                    .tag(Tab.Settings)
                
                Text("Liked")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04))
                    .tag(Tab.Liked)
                
                Text("Search")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04))
                    .tag(Tab.Search)
            }
            CustomTabBar(animation: animation, size: size, bottomEdge: bottomEdge, currentTab: $currentTab)
                .background(Color.white)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Tab: String, CaseIterable {
    case Home = "house.fill"
    case Search = "magnifyingglass"
    case Liked = "suit.heart.fill"
    case Settings = "gearshape"
}
