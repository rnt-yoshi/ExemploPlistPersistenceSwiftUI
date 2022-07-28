//
//  ContentView.swift
//  ExemploPlistPersistenceSwiftUI
//
//  Created by Renato Yoshinari on 28/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    InsertCarView()
                } header: {
                    Text("Cadastro")
                }
                
                Section {
                    GarageListView()
                    
                    ActionButtons()
                } header: {
                    Text("Cães")
                }
            }
            .environmentObject(viewModel)
            .navigationTitle("Garagem")
            .onAppear {
                viewModel.updateGarage()
            }
        }
    }
}

struct InsertCarView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        HStack {
            Label("Nome:", systemImage: "pawprint.fill")
                .foregroundColor(.black)
            TextField("Digite..", text: $viewModel.newDog.name)
                .foregroundColor(.gray)
        }
        HStack {
            Label("Raça:", systemImage: "pawprint.fill")
                .foregroundColor(.black)
            TextField("Digite..", text: $viewModel.newDog.breed)
                .foregroundColor(.gray)
            Spacer()
        }
        
        Button { viewModel.createCar() } label: {
            Label("Salvar", systemImage: "square.and.arrow.down")
                .foregroundColor(.white)
        }
        .disabled(viewModel.newDog.name.isEmpty || viewModel.newDog.breed.isEmpty)
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

struct GarageListView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        Group {
            ForEach(viewModel.dogList) { item in
                HStack {
                    Image(systemName: "pawprint.fill")
                    Text("\(item.name) - \(item.breed)")
                }
                .foregroundColor(.gray)
            }
        }
    }
}

struct ActionButtons: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        HStack{
            
            Button { viewModel.resetGarage() } label: {
                    Label("Apagar Lista", systemImage: "trash")
                        .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
            .tint(.black)
            .disabled(viewModel.dogList.isEmpty)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
