//
//  CategoriesTagsView.swift
//  Finances Helper
//
//  Created by Kendrick  on 10/05/24.
//

import SwiftUI

struct CategoriesTagsView: View {
    @ObservedObject var createVM: CreateTransactionViewModel
   
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Category")
                .font(.title3.bold())
            if let selectedCategory = createVM.selectedCategory{
                tagView(selectedCategory, isSubcategory: false)
                Text("Subcategory")
                    .font(.title3.bold())
                tagsList(Array(selectedCategory.wrappedSubcategories), isSubcategory: true)
            }else{
                tagsList(createVM.categories.filter({$0.wrappedCategoryType == createVM.transactionType}), isSubcategory: false)
            }
        }
        .hLeading()
    }
}

struct CategoryTagView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesTagsView(createVM: CreateTransactionViewModel(context: dev.viewContext, transactionType: .expense))
            .padding()
    }
}


extension CategoriesTagsView{
    
    private func tagView(_ category: CategoryEntity, isSubcategory: Bool) -> some View{
        Text(category.title ?? "")
            .foregroundColor(.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(category.wrappedColor, in: Capsule())
            .opacity(isSubcategory ? (category.id == createVM.selectedSubCategoryId ? 1 : 0.5) : 1)
            .onTapGesture {
                if isSubcategory{
                    createVM.toogleSelectSubcategory(category.id ?? "")
                }else{
                    createVM.toogleSelectCategory(category)
                }
            }
    }
    
    
    private func tagsList(_ categories: [CategoryEntity], isSubcategory: Bool) -> some View{
        TagLayout(alignment: .leading) {
            ForEach(categories) { category in
                tagView(category, isSubcategory: isSubcategory)
            }
            Button {
                createVM.createCategoryViewType = .new(isSub: isSubcategory)
            } label: {
                Label("New", systemImage: "plus")
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.secondary, in: Capsule())
            }
        }
    }
}
