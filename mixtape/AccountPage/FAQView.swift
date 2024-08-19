//
//  FAQView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/14/24.
//

import SwiftUI

struct FAQView: View {
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading, spacing:20) {
                    // TODO: Fetch FAQs from web
                    VStack(alignment:.leading) {
                        Text("Can I use a free Spotify account?")
                            .font(.title3)
                            .bold()
                        Text("Yes! Of course - free Spotify accounts will work just as well with Mixtape as paid accounts.")
                            .foregroundStyle(Color(UIColor.systemGray))
                    }
                    
                    VStack(alignment:.leading) {
                        Text("Can I connect to other music streaming services?")
                            .font(.title3)
                            .bold()
                        Text("Not yet - other streaming services will be supported for use with Mixtape in future updates.")
                            .foregroundStyle(Color(UIColor.systemGray))
                    }
                    
                    VStack(alignment:.leading) {
                        Text("Why aren't videos showing up in my Apple Photos library when I add media to a journal entry?")
                            .font(.title3)
                            .bold()
                        Text("Unfortunately, we are still working on support for videos. For now, journal entry media is limited to images and songs.")
                            .foregroundStyle(Color(UIColor.systemGray))
                    }
                    
                    VStack(alignment:.leading) {
                        Text("Can I share mixtapes and journal entries with friends?")
                            .font(.title3)
                            .bold()
                        Text("Soon! We're still developing collaborative and shareable mixtapes.")
                            .foregroundStyle(Color(UIColor.systemGray))
                    }
                    
                    VStack(alignment:.leading) {
                        Text("Will Mixtape still work when I'm offline?")
                            .font(.title3)
                            .bold()
                        Text("Somewhat - you'll still be able to create and edit mixtapes and journal entries, but you won't be able to add new tracks to either. Additionally, any songs that have been attached to journal entries will not be available without an internet connection, and neither will any of the album covers from songs that have been attached to mixtapes.")
                            .foregroundStyle(Color(UIColor.systemGray))
                    }
                    
                    HStack {
                        Spacer()
                        VStack(alignment:.center) {
                            Text("Still have unanswered questions?")
                                .foregroundStyle(Color(UIColor.systemGray))
                            Button(action: {
                                UIApplication.shared.open(URL(string:"mailto:help@themixtapeapp.com?subject=Question&body=What's your question?\n")!)

                            }) {
                                Text("We'd love to hear them.")
                                    .foregroundStyle(.blue)
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding(15)
                .navigationTitle("FAQs 📣")
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
}

//#Preview {
//    FAQView()
//}
