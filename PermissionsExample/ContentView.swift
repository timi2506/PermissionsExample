//
//  ContentView.swift
//  PermissionsExample
//
//  Created by Tim on 23.10.25.
//

import SwiftUI
import Permissions
import Combine
import CoreBluetooth
struct ContentView: View {
    var allPermissions: [PermissionType] {
        return PermissionType.allCases
    }
    @StateObject var permissionsManager = PermissionsManager.shared
    @State var permissionStates: [PermissionType: Bool] = [:]
    @State var selectedStates: Set<PermissionType> = []
    @State var showSheet = false
    @State var isRefreshing = false
    @AppStorage("skipGranted") var skipGranted = false
    @AppStorage("allowManualSkip") var allowManualSkip = true

    var body: some View {
        NavigationView {
            List {
                Section {
                    if selectedStates == Set(allPermissions) {
                        Button("Deselect All") {
                            withAnimation {
                                selectedStates = []
                            }
                        }
                    } else {
                        Button("Select All") {
                            withAnimation {
                                selectedStates = Set(allPermissions)
                            }
                        }
                    }
                    ForEach(allPermissions.sorted(by: { $0.rawValue.localizedCompare($1.rawValue) == .orderedAscending }), id: \.rawValue) { type in
                        Button(action: {
                            if selectedStates.contains(type) {
                                selectedStates.remove(type)
                            } else {
                                selectedStates.insert(type)
                            }
                        }) {
                            HStack {
                                Image(systemName: type.sfSymbol)
                                    .frame(width: 30)
                                    .foregroundStyle(Color(uiColor: .label))
                                VStack(alignment: .leading) {
                                    Text(type.localizedTitle)
                                        .bold()
                                        .foregroundStyle(Color(uiColor: .label))
                                    let granted = permissionStates[type] ?? false
                                    HStack(spacing: 5) {
                                        Image(systemName: granted ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        Text(granted ? permissionsManager.localizationProvider.grantedTitle : permissionsManager.localizationProvider.notGrantedTitle)
                                    }
                                    .font(.caption)
                                    .foregroundStyle(granted ? .green : .red)
                                }
                                Spacer()
                                if selectedStates.contains(type) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.tint)
                                }
                            }
                            .contentShape(.rect)
                        }
                        .tag(type)
                    }
                } header: {
                    HStack {
                        Text("Select Permission Types")
                        Spacer()
                        if isRefreshing {
                            ProgressView()
                        }
                    }
                } footer: {
                    Text("Select all Permission Types you want to Request, once you are Done selecting, press \"Open Sheet\" to open the Permission Sheet")
                }
                Toggle("Skip if already Granted", isOn: $skipGranted)
                Toggle("Allow User to Skip Permission", isOn: $allowManualSkip)
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    showSheet.toggle()
                }) {
                    HStack {
                        Spacer()
                        Text("Open Sheet")
                            .bold()
                        Spacer()
                    }
                    .padding(10)
                }
                .borderedProminent()
                .padding()
                .disabled(selectedStates.isEmpty)
            }
            .permissionsSheet(isPresented: $showSheet, skipAlreadyGranted: skipGranted, allowManualSkip: allowManualSkip, permissions: selectedStates)
        }
        .navigationViewStyle(.stack)
        .background(.ultraThinMaterial)
        .onChange(of: showSheet) { _ in
            Task { await reloadStates() }
        }
        .onAppear {
            refreshLoop()
        }
    }
    func reloadStates() async {
        if !showSheet {
            withAnimation {
                isRefreshing = true
            }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            permissionStates = await permissionsManager.getPermissionStates(for: Set(allPermissions))
            withAnimation {
                isRefreshing = false
            }
        }
    }
    func refreshLoop() {
        Task {
            await reloadStates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                refreshLoop()
            }
        }
    }
}

extension View {
    func borderedProminent() -> some View {
        if #available(iOS 26.0, *) {
            return self.buttonStyle(.glassProminent)
        } else {
            return self.buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
