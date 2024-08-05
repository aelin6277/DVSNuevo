//
//  ChildProfileView.swift
//  DVSNuevo
//
//  Created by Elin.Andersson on 2024-06-27.


import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging

struct ChildProfileView: View {
    @Binding var selectedAvatar: Image?
    @Binding var selectedImage: Image?
    @State private var isImagePickerPresented = false
    @State private var isAvatarPickerPresented = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else if let avatar = selectedAvatar {
                avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Ladda upp foto")
                        .padding()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, selectedAvatar: $selectedAvatar)
                }

                Button(action: {
                    isAvatarPickerPresented.toggle()
                }) {
                    Text("Välj avatar")
                        .padding()
                }
                .sheet(isPresented: $isAvatarPickerPresented) {
                    AvatarPicker(selectedAvatar: $selectedAvatar, selectedImage: $selectedImage)
                }
            }
        }
        .navigationBarTitle("Barnprofil", displayMode: .inline)
        .onAppear {
            loadSelectedImageOrAvatar()
        }
    }

    private func loadSelectedImageOrAvatar() {
        if let avatarName = UserDefaults.standard.string(forKey: "selectedAvatar") {
            selectedAvatar = Image(avatarName)
        } else if let imageData = UserDefaults.standard.data(forKey: "selectedImage"), let uiImage = UIImage(data: imageData) {
            selectedImage = Image(uiImage: uiImage)
        }
    }
}

struct ChildProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProfileView(selectedAvatar: .constant(nil), selectedImage: .constant(nil))
    }
}

/*
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging

struct ChildProfileView: View {
    @Binding var selectedAvatar: Image?
    @Binding var selectedImage: Image?
    @State private var isImagePickerPresented = false
    @State private var isAvatarPickerPresented = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else if let avatar = selectedAvatar {
                avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Ladda upp foto")
                        .padding()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, selectedAvatar: $selectedAvatar)
                }

                Button(action: {
                    isAvatarPickerPresented.toggle()
                }) {
                    Text("Välj avatar")
                        .padding()
                }
                .sheet(isPresented: $isAvatarPickerPresented) {
                    AvatarPicker(selectedAvatar: $selectedAvatar, selectedImage: $selectedImage)
                }
            }
        }
        .navigationBarTitle("Barnprofil", displayMode: .inline)
        .onAppear {
            loadSelectedImageOrAvatar()
        }
    }

    private func loadSelectedImageOrAvatar() {
        if let avatarName = UserDefaults.standard.string(forKey: "selectedAvatar") {
            selectedAvatar = Image(avatarName)
        } else if let imageData = UserDefaults.standard.data(forKey: "selectedImage"), let uiImage = UIImage(data: imageData) {
            selectedImage = Image(uiImage: uiImage)
        }
    }
}

struct ChildProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProfileView(selectedAvatar: .constant(nil), selectedImage: .constant(nil))
    }
}
*/
/*
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging

struct ChildProfileView: View {
    @Binding var selectedAvatar: Image?
    @Binding var selectedImage: Image?
    @State private var isImagePickerPresented = false
    @State private var isAvatarPickerPresented = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else if let avatar = selectedAvatar {
                avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Ladda upp foto")
                        .padding()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, selectedAvatar: $selectedAvatar)
                }

                Button(action: {
                    isAvatarPickerPresented.toggle()
                }) {
                    Text("Välj avatar")
                        .padding()
                }
                .sheet(isPresented: $isAvatarPickerPresented) {
                    AvatarPicker(selectedAvatar: $selectedAvatar, selectedImage: $selectedImage)
                }
            }
        }
        .navigationTitle("Barnprofil")
        .onAppear {
            loadSelectedImageOrAvatar()
        }
    }

    private func loadSelectedImageOrAvatar() {
        if let avatarName = UserDefaults.standard.string(forKey: "selectedAvatar") {
            selectedAvatar = Image(avatarName)
        } else if let imageData = UserDefaults.standard.data(forKey: "selectedImage"), let uiImage = UIImage(data: imageData) {
            selectedImage = Image(uiImage: uiImage)
        }
    }
}

struct ChildProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProfileView(selectedAvatar: .constant(nil), selectedImage: .constant(nil))
    }
}
*/

/*
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging

struct ChildProfileView: View {
    @Binding var selectedAvatar: Image?
    @State private var selectedImage: Image?
    @State private var isImagePickerPresented = false
    @State private var isAvatarPickerPresented = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else if let avatar = selectedAvatar {
                avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Ladda upp foto")
                        .padding()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }

                Button(action: {
                    isAvatarPickerPresented.toggle()
                }) {
                    Text("Välj avatar")
                        .padding()
                }
                .sheet(isPresented: $isAvatarPickerPresented) {
                    AvatarPicker(selectedAvatar: $selectedAvatar, selectedImage: $selectedImage)
                }
            }
        }
        .navigationTitle("Barnprofil")
        .onAppear {
            loadSelectedImageOrAvatar()
        }
    }

    private func loadSelectedImageOrAvatar() {
        if let avatarName = UserDefaults.standard.string(forKey: "selectedAvatar") {
            selectedAvatar = Image(avatarName)
        } else if let imageData = UserDefaults.standard.data(forKey: "selectedImage"), let uiImage = UIImage(data: imageData) {
            selectedImage = Image(uiImage: uiImage)
        }
    }
}

struct ChildProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProfileView(selectedAvatar: .constant(nil))
    }
}
*/

/*
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging 
import SwiftUI

struct ChildProfileView: View {
    @Binding var selectedAvatar: Image?
    @State private var selectedImage: Image?

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else if let avatar = selectedAvatar {
                avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Ladda upp foto")
                        .padding()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }

                Button(action: {
                    isAvatarPickerPresented.toggle()
                }) {
                    Text("Välj avatar")
                        .padding()
                }
                .sheet(isPresented: $isAvatarPickerPresented) {
                    AvatarPicker(selectedAvatar: $selectedAvatar)
                }
            }
        }
        .navigationTitle("Barnprofil")
    }

    @State private var isImagePickerPresented = false
    @State private var isAvatarPickerPresented = false
}

struct ChildProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProfileView(selectedAvatar: .constant(nil))
    }
}
*/
/*import Foundation
import SwiftUI

struct ChildProfileView: View {
    @State private var selectedImage: Image?
    @State private var selectedAvatar: Image?

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else if let avatar = selectedAvatar {
                avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    // Öppna ImagePicker när användaren trycker på knappen
                    isImagePickerPresented.toggle()
                }) {
                    Text("Ladda upp foto")
                        .padding()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }

                Button(action: {
                    // Visa en lista av avatarer när användaren trycker på knappen
                    isAvatarPickerPresented.toggle()
                }) {
                    Text("Välj avatar")
                        .padding()
                }
                .sheet(isPresented: $isAvatarPickerPresented) {
                    AvatarPicker(selectedAvatar: $selectedAvatar)
                }
            }
        }
        .navigationTitle("Barnprofil")
    }

    @State private var isImagePickerPresented = false
    @State private var isAvatarPickerPresented = false
}

struct ChildProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProfileView()
    }
}

*/
