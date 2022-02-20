//
//  MenuBar.swift
//  MuesliSwapTick
//
//  Created by Jan Rajtr on 20.02.2022.
//

import SwiftUI

struct MenuBar: View {
    
    let titles: [String]
    @State var statusItem: NSStatusItem?
    
    var body: some View {
        Group {
            HStack {
                ForEach(titles) { item in
                    Text(item)
                }
            }
            
        }
        .onAppear {
            prepare(titles: ["123 ADA","123 MILK/ADA"])
        }
    }
    
    func prepare(titles: [String]) {
        let view = NSHostingView(rootView: body)

        // Don't forget to set the frame, otherwise it won't be shown.
        view.frame = NSRect(x: 0, y: 0, width: 200, height: 200)
                
        let menuItem = NSMenuItem()
        menuItem.view = view
                
        let menu = NSMenu()
        menu.addItem(menuItem)
                
        // StatusItem is stored as a class property.
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusItem?.menu = menu
        self.statusItem?.button?.title = titles.joined(separator: " | ")
    }
}
