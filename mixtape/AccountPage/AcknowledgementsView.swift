//
//  AcknowledgementsView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/19/24.
//

import SwiftUI
import AckGen

struct AcknowledgementsView: View {
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(Acknowledgement.all(), id:\.self.title) { ack in
                        Text(ack.title)
                    }
                } footer: {
                    HStack {
                        Spacer()
                        (
                        Text("We ")
                            .foregroundStyle(Color(UIColor.systemGray)) +
                        Text(Image(systemName: "heart.fill"))
                            .foregroundStyle(.pink) +
                        Text(" open source software")
                            .foregroundStyle(Color(UIColor.systemGray))
                        )
                        .font(.subheadline)
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            .toolbar {
                ToolbarItem(placement:.confirmationAction) {
                    Button(action:{dismiss()}) {
                        Text("Done")
                    }
                }
            }
            .navigationTitle("Acknowledgements")
        }
    }
}

//#Preview {
//    AcknowledgementsView()
//}
