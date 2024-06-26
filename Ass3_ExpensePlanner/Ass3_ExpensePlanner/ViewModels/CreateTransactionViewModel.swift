//
//  CreateTransactionViewModel.swift
//  Finances Helper
//
//  Created by Kendrick  on 10/05/24.
//

import Foundation
import Combine
import CoreData
import SwiftUI

class CreateTransactionViewModel: ObservableObject{
    
    @Published var transactionType: TransactionType = .expense
    @Published var note: String = ""
    @Published var amount: Double = 0
    @Published var date: Date = Date.now
    @Published var selectedSubCategoryId: String?
    @Published var selectedCategory: CategoryEntity?
    @Published var categories = [CategoryEntity]()

    @Published var createCategoryViewType: CreateCategoryViewType?
    @Published var categoryColor: Color = .blue
    @Published var categoryTitle: String = ""
    
    private let categoriesStore: ResourceStore<CategoryEntity>
    private var cancelBag = CancelBag()
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, transactionType: TransactionType){
        self.context = context
        self.transactionType = transactionType
        categoriesStore = ResourceStore(context: context)
        
        startSubsCategories()
        
        fetchCategories()
        
    }
    
    deinit{
        cancelBag.cancel()
    }
    
    var disabledSave: Bool{
        amount == 0 || selectedCategory == nil
    }
    
    private func fetchCategories(){
        let request = CategoryEntity.request()
        categoriesStore.fetch(request)
    }
    
    private func startSubsCategories(){
        categoriesStore.resources
            .sink { categories in
                self.categories = categories
            }
            .store(in: cancelBag)
    }
    
    
    func toogleSelectCategory(_ category: CategoryEntity){
        selectedCategory = category.objectID == selectedCategory?.objectID ? nil : category
    }
    
    func toogleSelectSubcategory(_ categoryId: String){
        selectedSubCategoryId = categoryId == selectedSubCategoryId ? nil : categoryId
    }
    
    func create(type: TransactionType, date: Date, forAccount: AccountEntity?, created: UserEntity?){
        guard let selectedCategory, let forAccount, let created else { return }
        TransactionEntity.create(amount: amount, createAt: date, type: type, created: created, account: forAccount, category: selectedCategory, subcategoryId: selectedSubCategoryId, note: note, context: context)
    }

    func addCategory(){
        let category = CategoryEntity.create(context: context, title: categoryTitle, color: categoryColor.toHex(), subcategories: nil, isParent: true, type: transactionType)
        context.saveContext()
        createCategoryViewType = nil
        categoryTitle = ""
        selectedCategory = category
    }
    
    func addSubcategory(){
        if let selectedCategory{
            let subcategory = CategoryEntity.create(context: context, title: categoryTitle, color: categoryColor.toHex(), subcategories: nil, isParent: false, type: transactionType)
            selectedCategory.wrappedSubcategories = [subcategory]
            context.saveContext()
            createCategoryViewType = nil
            categoryTitle = ""
            selectedSubCategoryId = subcategory.id
        }
    }
}
