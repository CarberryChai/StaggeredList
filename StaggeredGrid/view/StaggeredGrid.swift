//
//  StaggeredGrid.swift
//  StaggeredGrid
//
//  Created by 柴长林 on 2021/7/27.
//

import SwiftUI

struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    var content: (T) -> Content
    var list: [T]
    var columns:Int
    
    init(columns: Int,list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.list = list
        self.content = content
        self.columns = columns
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                ForEach(setupList(), id: \.self) { obj in
                    LazyVStack {
                        ForEach(obj) { item in
                            content(item)
                        }
                    }
                }
            }
        }
    }
    
    func setupList() -> [[T]] {
        var multiArray: [[T]] = Array(repeating: [], count: columns)
        var cur = 0
        for item in list {
            multiArray[cur].append(item)
            if  cur == columns - 1 {
                cur = 0
            } else {
                cur += 1
            }
        }
        return multiArray
    }
}

struct Staggered_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
