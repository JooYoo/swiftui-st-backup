//
//  Home.swift
//  Todo
//
//  Created by Yu on 2022/2/12.
//

import SwiftUI
import RealmSwift

struct TaskRow: View{
    @ObservedRealmObject var task: TaskItem
    
    var body: some View{
        HStack(spacing: 15){
            
            // task status indicator
            Menu{
                // update task
                Button("Missed"){
                    $task.taskStatus.wrappedValue = .missed
                }
                
                Button("Completed"){
                    $task.taskStatus.wrappedValue = .completed
                }
                
            } label: {
                Circle()
                    .stroke(.gray)
                    .frame(width: 15, height: 15)
                    .overlay(
                        Circle()
                            .fill(task.taskStatus == .missed ? .red :
                                    (task.taskStatus == .pending ? .yellow : .green))
                    )
            }
            
            VStack{
                
                // task title
                TextField("input new task...", text: $task.taskTitle)
                
                // task date
                if task.taskTitle != ""{
                    Picker(selection: .constant("")) {
                        DatePicker(selection: $task.taskDate, displayedComponents: .date) {}
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .navigationTitle("Task Date")
                    } label: {
                        HStack{
                            Image(systemName: "calendar")
                            Text(task.taskDate.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                    
                }
                
            }
            
            
        }
    }
}

struct Home: View {
    @ObservedResults(TaskItem.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate", ascending: false)) var tasksFetched
    
    var body: some View {
        NavigationView{
            ZStack{
                
                if tasksFetched.isEmpty {
                    Text("add new task")
                }else{
                    List{
                        ForEach(tasksFetched){ task in
                            TaskRow(task: task)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive){
                                        // remove task
                                        $tasksFetched.remove(task)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                }
                
            }
            .navigationTitle("Task")
            .toolbar {
                Button{
                    // add task
                    let task = TaskItem()
                    $tasksFetched.append(task)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
