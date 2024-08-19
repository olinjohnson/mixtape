//
//  AcknowledgementsView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/19/24.
//

import SwiftUI
import AcknowList

struct AcknowledgementsView: View {
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            ScrollView {
                AcknowListSwiftUIView(plistFileURL: URL(string: "Package.resolved")!)
            }
            .toolbar {
                ToolbarItem(placement:.confirmationAction) {
                    Button(action:{dismiss()}) {
                        Text("Done")
                    }
                }
            }
        }
    }
}

//#Preview {
//    AcknowledgementsView()
//}
