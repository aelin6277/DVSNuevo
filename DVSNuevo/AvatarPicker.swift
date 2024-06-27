//
//  AvatarPicker.swift
//  DVSNuevo
//
//  Created by Elin.Andersson on 2024-06-27.
//
import SwiftUI

struct AvatarPicker: View {
    @Binding var selectedAvatar: Image?

    struct AvatarItem: Identifiable {
        var id = UUID()
        var image: Image
    }

    let avatars: [AvatarItem] = [
        AvatarItem(image: Image("babygirl")),
        AvatarItem(image: Image("toddlergirl")),
        AvatarItem(image: Image("babyboy")),
        AvatarItem(image: Image("toddlerboy"))
    ]

    var body: some View {
        VStack {
            Text("Välj en avatar")
                .font(.title)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(avatars) { avatar in
                        avatar.image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .padding()
                            .onTapGesture {
                                selectedAvatar = avatar.image
                            }
                    }
                }
                .padding()
            }
        }
    }
}

struct AvatarPicker_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPicker(selectedAvatar: .constant(nil))
    }
}

/*
import Foundation
import SwiftUI

struct AvatarPicker: View {
    @Binding var selectedAvatar: Image?

    struct AvatarItem: Identifiable {
        var id = UUID()
        var image: Image
    }

    let avatars: [AvatarItem] = [
        AvatarItem(image: Image("babygirl")),
        AvatarItem(image: Image("toddlergirl")),
        AvatarItem(image: Image("babyboy")),
        AvatarItem(image: Image("toddlerboy"))
        // Lägg till fler avatarer här om det behövs
    ]

    var body: some View {
        VStack {
            Text("Välj en avatar")
                .font(.title)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(avatars) { avatar in
                        avatar.image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .padding()
                            .onTapGesture {
                                selectedAvatar = avatar.image
                            }
                    }
                }
                .padding()
            }
        }
    }
}

struct AvatarPicker_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPicker(selectedAvatar: .constant(nil))
    }
}

*/
