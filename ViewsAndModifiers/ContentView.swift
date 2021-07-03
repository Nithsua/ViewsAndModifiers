//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Nivas Muthu M G on 27/06/21.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}


struct Watermark: ViewModifier {
    let text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .titleStyle()
                .padding()
                .background(Color.black)
        }
    }
}

extension View {
    func watermark(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct CapsuleView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .titleStyle()
    }
}

struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
//    @State private var useRedText = true
    
    var body: some View {
//        if useRedText {
//            return Text("Hello World")
//                .foregroundColor(.red)
//        } else {
//            return Text("Hello World")
//        }
//        Button("Hello World") {
//            self.useRedText = true
//        }
//        .foregroundColor(useRedText ? .red : .blue)
        
//        VStack {
//            Text("Black Bulls")
//            Text("Golden Dawn")
//            Text("BLue Rose")
//            Text("Crimson Lion")
//        }
//        .blur(radius: 1.0)
//        VStack {
//            CapsuleView(text: "Draco Dormiens")
//            CapsuleView(text: "nunquam titillandus")
//        }
        GridStack(rows:4, columns: 3) { row, column in
            Image(systemName: "\(row * 4 + column).circle")
            Text("R\(row) C\(column)")
        }
        .foregroundColor(.white)
        .frame(width: 300, height: 200)
        .background(Color.blue)
        .watermark(with: "100 days of SwiftUI")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
