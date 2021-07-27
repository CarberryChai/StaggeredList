//
//  Post.swift
//  StaggeredGrid
//
//  Created by 柴长林 on 2021/7/27.
//

import Foundation

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageUrl: String
}
