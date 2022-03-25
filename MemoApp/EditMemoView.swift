//
//  InputView.swift
//  MemoApp
//
//

import SwiftUI

struct EditMemoView: View {
    private var memo: Memo
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String
    @State private var content: String
    init(memo: Memo) {
        self.memo = memo
        self.title = memo.title ?? ""
        self.content = memo.content ?? ""
    }
    var body: some View {
        VStack {
            TextField("タイトル", text: $title)
                .font(.title)
            TextEditor(text: $content)
                .font(.body)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {saveMemo()}) {
                    Text("保存")
                }
            }
        }
    }
    private func saveMemo() {
        memo.title = title
        memo.content = content
        memo.updatedAt = Date()

        try? viewContext.save()
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(memo: Memo())
    }
}
