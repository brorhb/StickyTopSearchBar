//
//  ContentView.swift
//  TopSearchBar
//
//  Created by Bror Hammer Brurberg on 03/09/2024.
//

import SwiftUI
import SwiftUIScrollOffset

struct ContentView: View {
    @State private var searchBarOpacity: Double = 1.0
	@ScrollOffset(.top, id: "overscroll") private var scrollOffset
	@State private var isRefreshing = false
	@State private var searchBarOffset = 0.0

    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(destination: Text("Detail View 4")) {
                        Text("Row 4")
                    }
                    NavigationLink(destination: Text("Detail View 5")) {
                        Text("Row 5")
                    }
                    NavigationLink(destination: Text("Detail View 6")) {
                        Text("Row 6")
                    }
                    NavigationLink(destination: Text("Detail View 4")) {
                        Text("Row 4")
                    }
                    NavigationLink(destination: Text("Detail View 5")) {
                        Text("Row 5")
                    }
                    NavigationLink(destination: Text("Detail View 6")) {
                        Text("Row 6")
                    }
                    NavigationLink(destination: Text("Detail View 4")) {
                        Text("Row 4")
                    }
                    NavigationLink(destination: Text("Detail View 5")) {
                        Text("Row 5")
                    }
                    NavigationLink(destination: Text("Detail View 6")) {
                        Text("Row 6")
                    }
                }
				.scrollOffsetID("overscroll")
				.onChange(of: scrollOffset) { oldVal, newVal in
					print("Scroll offset \(newVal)")
					searchBarOffset = newVal
					if newVal > 5 {
						withAnimation {
							searchBarOpacity = 0.0
						}
					} else {
						if !isRefreshing {
							withAnimation {
								searchBarOpacity = 1.0
							}
						}
					}
				}
				.refreshable {
					// delay 2 seconds
					isRefreshing = true
					await Task.sleep(2 * 1_000_000_000)
					isRefreshing = false
				}
				.safeAreaInset(edge: .top) {
					// Create a SearchBar
					SearchBar(text: .constant(""))
						.padding(.horizontal)
						//.opacity(searchBarOpacity)
						.offset(y: searchBarOffset)
				}
            }
            // Set the title of the NavigationView
            .navigationTitle("Navigation")
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            // Create a TextField
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            // Create a Button
            Button(action: {
                // Clear the text
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
