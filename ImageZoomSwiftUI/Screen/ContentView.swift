//
//  ContentView.swift
//  Pich
//
//  Created by Mac on 28.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    func resetImageState() {
        return withAnimation(.spring()) {
            
            imageScale = 1
            imageOffset = .zero
        }
    }
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
                
                  Image("night")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            
                        withAnimation(.spring()) {
                            imageScale = 5

                        }
                        }else {
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    }
                    .gesture(DragGesture()
                        .onChanged({ value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                            }
                        })
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    withAnimation(.spring()) {
                                        
                                        imageScale = 1
                                        imageOffset = .zero
                                    }
                                }
                                
                            }
                    )
                    .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            withAnimation(.linear(duration: 1)) {
                                
                                if imageScale >= 1 && imageScale <= 5 {
                                    
                                    imageScale = value
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        })
                        .onEnded({ _ in
                            resetImageState()
                        })
                    )
                }.navigationTitle("Yakınlaştır")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        withAnimation(.linear(duration: 1)) {
                            isAnimating = true
                        }
                    }
                    .overlay(
                        InfoPanelView(scale: imageScale, offset: imageOffset)
                            .padding(), alignment: .top)
                    .overlay(
                        Group{
                            
                            HStack{
                                Button {
                                    withAnimation(.spring()) {
                                        
                                        if imageScale > 1
                                        {
                                            imageScale -= 1
                                            
                                            if imageScale <= 1 {
                                                resetImageState()
                                            }
                                        }
                                    }
                                } label: {
                                    Image(systemName:   "minus.magnifyingglass")
                                        .font(.system(size: 36))
                                }
                                
                                Button {
                                    resetImageState()
                                } label: {
                                    Image(systemName:   "arrow.up.left.and.down.right.magnifyingglass")
                                        .font(.system(size: 36))
                                }
                                
                                Button {
                                    
                                    withAnimation(.spring()) {
                                        
                                        if imageScale <= 5 {
                                            imageScale += 1
                                        }
                                    }
                                } label: {
                                    Image(systemName:   "plus.magnifyingglass")
                                        .font(.system(size: 36))
                                }
                                

                            }
                            .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .opacity(isAnimating ? 1 : 0)
                            
                        }
                            .padding(),alignment: .bottom
                    
                    )
            
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            
        }
        .preferredColorScheme(.dark)
    }
}
