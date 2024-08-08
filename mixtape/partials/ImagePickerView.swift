//
//  ImagePickerView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/20/24.
//

import SwiftUI
import PhotosUI
import UIKit

struct ImagePickerView: View {
    
    let gr: GeometryProxy
    
    @State var selectedPhoto: PhotosPickerItem?
    @Binding var imageData: Data?
    @State var uiCover = UIImage(named: "no_select")!
    
    var body: some View {
        ZStack(alignment:.center){
            Image(uiImage: uiCover)
                .resizable()
                .scaledToFill()
                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y))//, alignment:.bottom)
                .clipped()
                .offset(y: -gr.frame(in: .global).origin.y)
            
            PhotosPicker(selection:$selectedPhoto, matching:.images) {
                VStack(alignment: .center) {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(18)
                        .foregroundColor(.black)
                }
                .background(.white.opacity(0.5))
                .frame(width:60, height:60)
                .cornerRadius(100)
            }
            .offset(y: -gr.frame(in: .global).origin.y)
        }
        .task(id: selectedPhoto) {
            imageData = try? await selectedPhoto?.loadTransferable(type: Data.self) ?? (imageData ?? UIImage(named: "no_select")?.pngData())
            uiCover = UIImage(data: imageData!)!
        }
    }
}

//#Preview {
//    GeometryReader { gr in
//        ImagePickerView(gr:gr)
//    }
//    .frame(height:150)
//}
