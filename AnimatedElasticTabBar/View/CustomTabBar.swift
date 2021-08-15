//
//  CustomTabBar.swift
//  AnimatedElasticTabBar
//
//  Created by Eduardo Santos on 14/08/21.
//

import SwiftUI

struct CustomTabBar: View {
    var animation: Namespace.ID
    
    var size: CGSize
    var bottomEdge: CGFloat
    
    @State var startAnimation: Bool = false
    
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabButton(tab: tab, animation: animation, currentTab: $currentTab) { pressedTab in
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                        startAnimation = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            currentTab = pressedTab
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            startAnimation = false
                        }
                    }
                    
                }
            }
        }
        // Custom Elastic Shape
        .background(
            ZStack {
                let animationOffset: CGFloat = (startAnimation ? 18 : (bottomEdge == 0 ? 26 : 27))
                let offset: CGSize = bottomEdge == 0 ?
                    CGSize(width: animationOffset, height: 31) :
                    CGSize(width: animationOffset, height: 36)
                
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: 45, height: 45)
                    .offset(y: 40)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x: offset.width, y: offset.height)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x: -offset.width, y: offset.height)
            }
            .offset(x: getStartOffset())
            .offset(x: getOffset())
            , alignment: .leading
        )
        .padding(.horizontal, 15)
        .padding(.top, 7)
        .padding(.bottom, bottomEdge == 0 ? 23 : bottomEdge)
    }
    
    func getStartOffset() -> CGFloat {
        // padding
        let reduced = (size.width - 30) / 4
        // 45 = button size
        let center = (reduced - 45) / 2
        return center
    }
    
    func getOffset() -> CGFloat {
        let reduced = (size.width - 30) / 4
        let index = Tab.allCases.firstIndex { checkTab in
            return checkTab == currentTab
        } ?? 0
        
        return reduced * CGFloat(index)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TabButton: View {
    var tab: Tab
    var animation: Namespace.ID
    @Binding var currentTab: Tab
    var onTap: (Tab) -> Void
    
    var body: some View {
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
            .frame(width: 45, height: 45)
            .background(
                ZStack {
                    if currentTab == tab {
                        Circle()
                            .fill(Color.purple)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab != tab {
                    onTap(tab)
                }
            }
    }
}
