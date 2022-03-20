//
//  ContentView.swift
//  MemoApp
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
        animation: .default
    ) var fetchedMemoList: FetchedResults<Memo>

    var body: some View {
        NavigationView {
            List {
                ForEach(fetchedMemoList) { memo in
                    NavigationLink(destination: EditMemoView(memo: memo)) {
                        VStack {
                            Text(memo.title ?? "")
                               .font(.title)
                               .frame(maxWidth: .infinity,alignment: .leading)
                               .lineLimit(1)
                           HStack {
                               Text (memo.stringUpdatedAt)
                                   .font(.caption)
                                   .lineLimit(1)
                               Text(memo.content ?? "")
                                   .font(.caption)
                                   .lineLimit(1)
                               Spacer()
                           }
                        }
                    }
                }
                .onDelete(perform: deleteMemo)
            }
            .navigationTitle("メモ")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddMemoView()) {
                        Text("新規作成")
                       
                    }
                }
            }
        }
    }
    
    private func deleteMemo(offsets: IndexSet) {
        offsets.forEach { index in
            viewContext.delete(fetchedMemoList[index])
        }
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
