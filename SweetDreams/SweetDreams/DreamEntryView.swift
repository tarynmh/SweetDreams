//
//  DreamEntryView.swift
//  DreamJournal
//
//  Created by CUBS Customer on 11/28/22.
//

import SwiftUI

struct DreamEntryView: View {
    let card: Card
    let dreamIcon: String
    let dreamColor: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(CustomColor.neutralDream)
//                .padding([.leading, .trailing], 5)

            VStack {
                Image(systemName: dreamIcon)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(dreamColor)
                    .font(.system(size: 18))
                    .padding(3)
                Text(card.title)
                    .font(.largeTitle)
                    .foregroundColor(CustomColor.titleColor)
                    .padding([.leading, .trailing], 5)
                
                Divider()
                    .overlay(.white)

                Text(card.topic)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 5)
                
//                Button("Delete Entry", role: .destructive) {
//               deleteFunc()
//                    print("delete WIP")
//                }
//                .padding(.top)
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 350, height: 250)
    }
}

//struct DreamEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        DreamEntryView(card: Card.example, deleteFunc: Void)
//    }
//}
