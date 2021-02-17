//
//  ContentView.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import SwiftUI

struct ContentView: View {
   var body: some View {
       VStack {
           ForEach(0..<3) { row in
               HStack {
                   ForEach(0..<2) { column in
                       let flip = ((column == 0 && row == 0)
                                       || (column == 1 && row == 2))
                       CardView(isFlipped: flip)
                   }
               }
           }
       }
       .padding()
       .foregroundColor(Color.blue)
   }
}

struct CardView: View{
   var isFlipped: Bool

   var body: some View {
       GeometryReader { geometry in
           ZStack {
               if isFlipped {
                   RoundedRectangle(cornerRadius: 10.0)
                       .stroke()
                   RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.gray.opacity(0.25))
                   Text("🇪🇸")
                       .font(Font.system(size: min(geometry.size.height, geometry.size.width) - 20))
               } else {
                   RoundedRectangle(cornerRadius: 10.0)
               }
           }
       }
   }
}









































struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
    Group {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
   }
}
