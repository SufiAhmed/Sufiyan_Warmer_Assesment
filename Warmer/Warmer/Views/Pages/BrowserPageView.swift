//
//  BrowserPageView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import SwiftUI

struct BrowserListPageView: View {
  var body: some View {
    NavigationStack() {
      BrowserListView()
        .navigationDestination(for: Category.self) { category in
          OfferingListPageView(offeringsHeader: category.name ?? "",offerings: category.offerings ?? [])
        }
    }
  }
}

struct BrowserListView: View {
  
  @StateObject private var viewModel = BrowserViewModel()
  
  @State private var searchText = ""
  @State private var isSearchActive = false
  @State private var showShareSheet = false
  
  @FocusState private var isSearchFieldFocused: Bool
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(String.browserListHeaderLabel)
          .font(.title2)
          .bold()
      }
      .padding(.top, 16)
      .padding(.leading, 20)
      
      // MARK: Search bar
      HStack {
        HStack {
          TextField(String.searchLabel, text: $searchText)
            .submitLabel(.search)
            .focused($isSearchFieldFocused)
            .onChange(of: isSearchFieldFocused) {
              withAnimation(.easeInOut) {
                if (!isSearchFieldFocused) {
                  isSearchActive = false
                } else {
                  isSearchActive = true
                }
              }
            }
            .onChange(of: searchText) {
              viewModel.updateSearchText(searchText)
            }
          if isSearchActive {
            Image(systemName: "xmark.circle.fill")
              .font(.title2)
              .foregroundStyle(Color.warmerLogoGreen)
              .onTapGesture {
                isSearchFieldFocused = false
                searchText = ""
                viewModel.updateSearchText("")
              }
          }
        } // End of Inner Search HStack
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.warmerLogoGreen, lineWidth: 1)
        )
        .padding(.leading, 20)
        .padding(.trailing, isSearchActive ? 0 : 20)
        if isSearchActive {
          Button {
            isSearchFieldFocused = false
          } label: {
            Text(String.cancelLabel)
              .font(.callout)
              .foregroundStyle(.blue)
              .padding(.trailing, 20)
          }
        }
      } // End of Search HStack
      
      Divider()
        .overlay(Color.mutedGray)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
      
      if !viewModel.isLoading && viewModel.filteredCategoriesList.isEmpty {
        VStack(alignment: .center) {
          Text(String.noBrowserCategoriesFoundErrorLabel)
            .font(.body)
            .foregroundStyle(Color.mutedGray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      }
      
      List {
        ForEach(viewModel.filteredCategoriesList, id: \.self) { category in
          NavigationLink(value: category) {
            HStack(alignment: .top) {
              VStack(alignment: .leading) {
                HStack {
                  Text(category.name ?? "")
                    .foregroundStyle(Color.black)
                    .font(.callout)
                    .fontWeight(.medium)
                    .lineLimit(1)
                  Spacer()
                } // End of title HStack
              } // End of Row VStack
            } // End of Row HStack
          }
        }
      }
      .listStyle(.plain)
      .onAppear() {
        Task {
          await viewModel.getBrowserCategories()
        }
      }
      .overlay {
        if viewModel.isLoading {
          LoadingView(loadingViewText: String.browserLoadLabel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.1))
            .transition(.opacity)
        }
      }
    } // End of view VStack
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .principal) {
        Image("WarmerLogo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 24)
      }
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          showShareSheet = true
        } label: {
          Image(systemName: "square.and.arrow.up")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 24)
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(Color.warmerLogoGreen)
        }
      }
    }
    .toolbarBackground(Color.warmerGradient2, for: .tabBar)
    .toolbarBackground(.visible, for: .tabBar)
    .toolbarColorScheme(.dark, for: .navigationBar)
    .toolbarBackground( LinearGradient(
      gradient: Gradient(colors: [
        Color.warmerGradient1,
        Color.warmerGradient2,
        Color.warmerGradient3
      ]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    ), for: .navigationBar)
    .toolbarBackground(.visible, for: .navigationBar)
    .sheet(isPresented: $showShareSheet) {
      ShareSheet(items: [
        String.shareAppTitle,
        String.shareAppDescription,
        String.shareAppCallToAction
      ])
      .presentationDetents([.medium])
    }
  }
}

