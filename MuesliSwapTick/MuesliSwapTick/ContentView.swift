//
//  ContentView.swift
//  MuesliSwapTick
//
//  Created by Jan Rajtr on 20.02.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State var searchName: String = ""
    @State var showingFavourites: Bool = false
    
    var body: some View {
        Group {
            HStack {
                TextField("", text: $searchName)
                Button {
                    Task(priority: .medium) { await viewModel.filterPairs(by: searchName) }
                } label: {
                    Image(systemName: "magnifyingglass.circle")
                }
                Button {
                    searchName = ""
                    Task(priority: .medium) { await viewModel.filterPairs(by: searchName) }
                } label: {
                    Image(systemName: "multiply.circle.fill")
                }
            }
            HStack {
                Button {
                    showingFavourites.toggle()
                    Task(priority: .medium) { await viewModel.show(favourites: showingFavourites) }
                } label: {
                    Text(verbatim: showingFavourites ? "Show all" : "Show favourites only")
                }
                Button {
                    viewModel.updateCurrentTitles()
                } label: {
                    Text(verbatim: "Start tick tock")
                }
            }
            
            List {
                ForEach(viewModel.tradingPairs) { item in
                    HStack {
                        Button {
                            viewModel.setPair(key: item.trading_pairs)
                        } label: {
                            viewModel.isListeningFor(pair: item.trading_pairs) ? Image(systemName: "star.fill") : Image(systemName: "star")
                        }

                        HStack {
                            Text(verbatim: item.pairName)
                        }
                        VStack {
                            
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchSettings()
            await viewModel.fetchSummary()
        }
        .background {
            MenuBar(titles: viewModel.currentTitles)
        }
        .padding()
    }
    
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var tradingPairs: [TradingPair] = []
        @AppStorage(AppSettingsKeys.favouritePairs.rawValue) private var favouritePairs: [String] = []
        @Published var error: Error?
        @Published var currentTitles: [String] = []
        
        func setPair(key: String) {
            favouritePairs.contains(key) ? favouritePairs = favouritePairs.filter { $0 != key } : favouritePairs.append(key)
            UserDefaults.standard.set(favouritePairs, forKey: AppSettingsKeys.favouritePairs.rawValue)
        }
        
        func isListeningFor(pair: String) -> Bool {
            self.favouritePairs.contains(pair)
        }
        
        func filterPairs(by key: String) async {
            guard !key.isEmpty else {
                await fetchSummary()
                return
            }
            tradingPairs = tradingPairs.filter { $0.pairName.contains(key) }
            return
        }
        
        func show(favourites: Bool) async {
            favourites ? tradingPairs = tradingPairs.filter { favouritePairs.contains($0.trading_pairs) } : await fetchSummary()
        }
        
        func fetchSummary() async {
            self.error = nil
            let result = await NetworkFetcher.performFetch(
                type: [TradingPair](),
                endpoint: .summary)
            
            switch result {
            case .success(let data):
                self.tradingPairs = data
                updateCurrentTitles()
            case .failure(let error):
                self.error = error
            }
        }
        
        func fetchSettings() async {
            favouritePairs = UserDefaults.standard.value(forKey: AppSettingsKeys.favouritePairs.rawValue) as? [String] ?? []
        }
        
        func updateCurrentTitles() {
            self.currentTitles = tradingPairs
                .filter { favouritePairs.contains($0.trading_pairs) }
                .map {
                    $0.last_price + " " + $0.pairName
                }
        }
        
        
        func start() {
            
            /*
            cancellable = Timer.publish(every: 1, on: .main, in: .default)
                    .autoconnect()
                    .receive(on: DispatchQueue.global(qos: .background))
                    .assign(to: \.lastUpdated, on: myDataModel)
             */
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
