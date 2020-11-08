//
//  ContentView.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {
    
    @ObservedObject var mGroceryViewModel = GroceryViewModel()
    
    private var gridLayout = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView{
                ZStack(alignment: .center) {
                    
                    if (!mGroceryViewModel.hideIndicator) {
                        ProgressView("Loading")
                            .zIndex(10)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .accessibility(hidden: mGroceryViewModel.hideIndicator)
                        
                    } else {
                        Text("")
                    }
                   
                    if (mGroceryViewModel.listStyle == 0) {
                        LazyVGrid(columns: [GridItem(.flexible())]){
                            //List{
                                ForEach(mGroceryViewModel.groceries, id: \.name){ grocery in
                                    return HStack(){
                                        
                                        WebImage(url: URL(string: grocery.image ?? ""))
                                            .resizable()
                                            .indicator(.activity)
                                            .transition(.fade(duration: 0.5))
                                            .scaledToFit()
                                            .frame(width: 120, height: 120, alignment: .center)
                                        
                                        VStack(alignment: .leading){
                                            Text(grocery.name ?? "")
                                                .fontWeight(.bold)
                                                .font(.title)
                                            
                                            Text(grocery.description ?? "")
                                                .fontWeight(.regular)
                                                .foregroundColor(.secondary)
                                                .padding(.top, 20)
                                            
                                        }
                                        Spacer()
                                        VStack{
                                            HStack {
                                                Button(action:{
                                                    self.mGroceryViewModel.isUpdatePopOverShown = true
                                                    self.mGroceryViewModel.showImageloading = true
                                                    self.mGroceryViewModel.onTapEditGrocery(groceryName: grocery.name ?? "", groceryDescription: grocery.description ?? "", groceryAmount: String(grocery.amount ?? 0), imageURL: grocery.image ?? "")
                                                }){
                                                    Image(systemName: "pencil")
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                .sheet(isPresented: self.$mGroceryViewModel.isUpdatePopOverShown){
                                                    VStack(spacing: 24){
                                                        ZStack {
                                                            ActivityIndicator(self.$mGroceryViewModel.showImageloading)
                                                            Image(uiImage: self.mGroceryViewModel.image)
                                                                .resizable()
                                                                .foregroundColor(Color.gray)
                                                                .scaledToFit()
                                                                .frame(width: 150, height: 150)
                                                                .cornerRadius(8)
                                                                .font(.system(size: 10, weight: .regular))
                                                                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 32, trailing: 0))
                                                        }
                                                        
                                                        
                                                        Button(action:{
                                                            self.mGroceryViewModel.isShowingImage = true
                                                        }){
                                                            Image.init(systemName: "pencil")
                                                        }
                                                        .buttonStyle(PlainButtonStyle())
                                                        .sheet(isPresented: self.$mGroceryViewModel.isShowingImage) {
                                                            ImagePicker(isPresented: self.$mGroceryViewModel.isShowingImage, onImageChosen: { image in
                                                                self.mGroceryViewModel.onRegisterImage(image: image)
                                                            })
                                                        }
                                                        
                                                        TextField("Grocery Name", text: self.$mGroceryViewModel.groceryName )
                                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        TextField("Grocery Desription", text: self.$mGroceryViewModel.groceryDescription)
                                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        TextField("Grocery Amount" , text:
                                                                    self.$mGroceryViewModel.groceryAmount)
                                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        Button(action:{
                                                            self.mGroceryViewModel.onTapAddGrocery()
                                                            self.mGroceryViewModel.isUpdatePopOverShown = false
                                                            
                                                        }){
                                                            Text("Update Grocery")
                                                        }
                                                    }.padding()
                                                }
                                                
                                                Button(action:{
                                                    self.mGroceryViewModel.isShowingImage = true
                                                    self.mGroceryViewModel.onGroceryItemChosen(grocery: grocery)
                                                }){
                                                    Image.init(systemName: "icloud.and.arrow.up")
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                .sheet(isPresented: self.$mGroceryViewModel.isShowingImage) {
                                                    ImagePicker(isPresented: self.$mGroceryViewModel.isShowingImage, onImageChosen: { image in
                                                        self.mGroceryViewModel.onImageChosen(image: image)
                                                    })
                                                }
                                                
                                            }
                                            
                                            
                                            Spacer()
                                            //Text("x5")
                                            Text(String(grocery.amount ?? 0))
                                                .font(.headline)
                                            
                                        }
                                    }.padding()
                                    
                                }
        //                        .onDelete(perform: deleteItems)
        //                    }
                        }
                        
                    } else {
                        //GeometryReader { geometry in
                        LazyVGrid(columns: [GridItem(.fixed(200)),GridItem(.fixed(200))], alignment : .center, spacing : 5){
                                //List{
                                    ForEach(mGroceryViewModel.groceries, id: \.name){ grocery in
                                        
                                        return VStack(alignment: .leading){
                                            
                                            WebImage(url: URL(string: grocery.image ?? ""))
                                                .resizable()
                                                .indicator(.activity)
                                                .padding()
                                                .transition(.fade(duration: 0.5))
                                                .scaledToFit()
                                                .frame(width: (geometry.size.width/2)-15, height: 120, alignment: .center)
                                            
                                            VStack(alignment: .leading){
                                                Text(grocery.name ?? "")
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                    .padding(5)
                                                    .frame(width: (geometry.size.width/2)-15)
                                                    .multilineTextAlignment(.leading)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                
                                                Text(grocery.description ?? "")
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.secondary)
                                                    .padding(5)
                                                    .frame(width: (geometry.size.width/2)-15)
                                                    .multilineTextAlignment(.leading)
                                                    .fixedSize(horizontal: false, vertical: true)
                                            }
                                            //Spacer()
                                            VStack{
                                                HStack {
                                                    Text(String(grocery.amount ?? 0))
                                                        .font(.headline)
                                                    
                                                    Button(action:{
                                                        self.mGroceryViewModel.isUpdatePopOverShown = true
                                                        self.mGroceryViewModel.showImageloading = true
                                                        self.mGroceryViewModel.onTapEditGrocery(groceryName: grocery.name ?? "", groceryDescription: grocery.description ?? "", groceryAmount: String(grocery.amount ?? 0), imageURL: grocery.image ?? "")
                                                    }){
                                                        Image(systemName: "pencil")
                                                    }
                                                    .buttonStyle(PlainButtonStyle())
                                                    .sheet(isPresented: self.$mGroceryViewModel.isUpdatePopOverShown){
                                                        VStack(spacing: 24){
                                                            ZStack {
                                                                ActivityIndicator(self.$mGroceryViewModel.showImageloading)
                                                                Image(uiImage: self.mGroceryViewModel.image)
                                                                    .resizable()
                                                                    .foregroundColor(Color.gray)
                                                                    .scaledToFit()
                                                                    .frame(width: 150, height: 150)
                                                                    .cornerRadius(8)
                                                                    .font(.system(size: 10, weight: .regular))
                                                                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 32, trailing: 0))
                                                            }
                                                            
                                                            
                                                            Button(action:{
                                                                self.mGroceryViewModel.isShowingImage = true
                                                            }){
                                                                Image.init(systemName: "pencil")
                                                            }
                                                            .buttonStyle(PlainButtonStyle())
                                                            .sheet(isPresented: self.$mGroceryViewModel.isShowingImage) {
                                                                ImagePicker(isPresented: self.$mGroceryViewModel.isShowingImage, onImageChosen: { image in
                                                                    self.mGroceryViewModel.onRegisterImage(image: image)
                                                                })
                                                            }
                                                            
                                                            TextField("Grocery Name", text: self.$mGroceryViewModel.groceryName )
                                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                            TextField("Grocery Desription", text: self.$mGroceryViewModel.groceryDescription)
                                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                            TextField("Grocery Amount" , text:
                                                                        self.$mGroceryViewModel.groceryAmount)
                                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                            Button(action:{
                                                                self.mGroceryViewModel.onTapAddGrocery()
                                                                self.mGroceryViewModel.isUpdatePopOverShown = false
                                                                
                                                            }){
                                                                Text("Update Grocery")
                                                            }
                                                        }
                                                    }.padding(.leading, 10)
                                                    
                                                    Button(action:{
                                                        self.mGroceryViewModel.isShowingImage = true
                                                        self.mGroceryViewModel.onGroceryItemChosen(grocery: grocery)
                                                    }){
                                                        Image.init(systemName: "icloud.and.arrow.up")
                                                    }
                                                    .buttonStyle(PlainButtonStyle())
                                                    .sheet(isPresented: self.$mGroceryViewModel.isShowingImage) {
                                                        ImagePicker(isPresented: self.$mGroceryViewModel.isShowingImage, onImageChosen: { image in
                                                            self.mGroceryViewModel.onImageChosen(image: image)
                                                        })
                                                    }
                                                    
                                                }
                                                
                                                Spacer()
                                                //Text("x5")
                                               
                                            }
                                            .padding(10)
                                        }
                                        //.padding()
                                        .background(Color("bgcolor"))
                                        .cornerRadius(15)
                                    
                                    }
            //                        .onDelete(perform: deleteItems)
            //                    }
                            }
                        //}
                    }
                }
            }
        }
        .allowsHitTesting(self.mGroceryViewModel.hideIndicator)
        .navigationBarTitle(Text("\(self.mGroceryViewModel.appBarName)"))
        .navigationBarColor(UIColor.init(named: "grocery-color"))
        .navigationBarItems(trailing: Button("Add New"){
            self.mGroceryViewModel.refreshView()
            self.mGroceryViewModel.isAddPopOverShown = true
            
        }.sheet(isPresented: $mGroceryViewModel.isAddPopOverShown){
            VStack(spacing: 24){
                
                Image(uiImage: self.mGroceryViewModel.image)
                    .resizable()
                    .foregroundColor(Color.gray)
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
                    .font(.system(size: 10, weight: .regular))
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 32, trailing: 0))
                
                Button(action:{
                    self.mGroceryViewModel.isShowingImage = true
                }){
                    Image.init(systemName: "plus.square")
                }
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: self.$mGroceryViewModel.isShowingImage) {
                    ImagePicker(isPresented: self.$mGroceryViewModel.isShowingImage, onImageChosen: { image in
                        self.mGroceryViewModel.onRegisterImage(image: image)
                    })
                }
                
                TextField("Grocery Name", text: self.$mGroceryViewModel.groceryName )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Grocery Desription", text: self.$mGroceryViewModel.groceryDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Grocery Amount" , text:
                            self.$mGroceryViewModel.groceryAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action:{
                    self.mGroceryViewModel.onTapAddGrocery()
                    self.mGroceryViewModel.isAddPopOverShown = false
                }){
                    Text("Add Grocery")
                }
            }.padding()
        })
        
        //.navigationBarHidden(true)
        
    }
    
    func deleteItems(at offsets: IndexSet) {
        //groceries.remove(atOffsets: offsets)
        let selectedIndex = offsets.map{$0}.first ?? 0
        let selcectedGrocery = mGroceryViewModel.groceries[selectedIndex]
        mGroceryViewModel.onDeleteGrocery(grocery: selcectedGrocery)
    }
}

struct ImagePicker : UIViewControllerRepresentable{
    
    @Binding var isPresented : Bool
    var onImageChosen : (UIImage) -> Void = { _ in}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        let parent : ImagePicker
        init(parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage{
                parent.onImageChosen(selectedImage)
            }
            parent.isPresented.toggle()
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePicker.UIViewControllerType, context: Context) {
        
    }
}

struct DummyView : UIViewRepresentable{
    func updateUIView(_ uiView: DummyView.UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let button = UIButton()
        button.setTitle("Dummy", for: .normal)
        button.backgroundColor = .red
        return button
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
}

struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}


