//
//  GridView.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import SwiftUI

struct GridView<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    let items:[Item]
    let itemViewGenerator: (Item)->ItemView

    init(_ items: [Item], itemViewGenerator: @escaping (Item)->ItemView) {
        self.items = items
        self.itemViewGenerator = itemViewGenerator
    }

    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                view(for: item, in: geometry.size)
            }
        }
    }

    func view(for item:Item, in size:CGSize) -> some View {
        let layout = GridLayout(itemCount: items.count, in: size)
        let index = items.firstIndex { $0.id == item.id } ?? 0

        return itemViewGenerator(item)
            .padding(5)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}
