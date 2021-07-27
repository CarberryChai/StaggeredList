//
//  Home.swift
//  StaggeredGrid
//
//  Created by 柴长林 on 2021/7/16.
//

import SwiftUI

struct Home: View {
    @State var posts: [Post] = []
    @State var columns = 2
    @Namespace var nspace
    var body: some View {
        NavigationView {
            StaggeredGrid(columns: columns, list: posts) { post in
                PostCard(post: post)
                    .matchedGeometryEffect(id: post.id, in: nspace)
            }
            .padding(.horizontal)
            .navigationTitle("Staggered Grid")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        columns += 1
                    }){
                        Image(systemName: "plus")
                    }
                    Button(action: {
                        columns = max(columns - 1 , 1)
                    }){
                        Image(systemName: "minus")
                    }
                }
            }
            .animation(.spring(), value: columns)
            .onAppear {
                for idx in 1...13 {
                    self.posts.append(Post(imageUrl: "hao\(idx)"))
                }
            }
        }
    }
}



struct PostCard: View {
    var post: Post
    var body: some View {
        Image(post.imageUrl)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}


struct PolygonShape: Shape {
    var slides: Int
    
    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        
        for i in 0..<slides {
            let angle = (Double(i) * (360.0 / Double(slides))) * Double.pi / 180
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            i == 0 ? path.move(to: pt) : path.addLine(to: pt)
        }
        path.closeSubpath()
        return path
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
