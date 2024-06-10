//
//  CustomerCodeInputView.swift
//  IVS Real-time
//
//  Created by Uldis Zingis on 28/03/2023.
//

import SwiftUI

struct CustomerCodeInputView: View {
    @EnvironmentObject var appModel: AppModel

    @Binding var isPresent: Bool
    @Binding var inputText: String

    var submitAction: () -> Void

    @State private var isQRScannerPresent: Bool = false
    @State private var inputBorderColor: Color = Color("BackgroundGray")
    @State private var YOffset: CGFloat = 200
    @State private var backOpacity: CGFloat = 0.8

    func dismiss() {
        withAnimation(.easeOut(duration: 0.3)) {
            YOffset = 200
        }

        withAnimation(.easeInOut(duration: 0.3)) {
            backOpacity = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresent.toggle()
        }
    }

    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(backOpacity)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismiss()
                }

            VStack {
                ZStack(alignment: .top) {
                    Color("BackgroundWhite")
                        .cornerRadius(30)
                        .edgesIgnoringSafeArea(.bottom)
                        .allowsHitTesting(false)

                    VStack {
                        Text("Authentication code")
                            .font(Constants.fInterExtraBold22)
                            .foregroundColor(.black)
                            .padding(.top, 30)
                            .padding(.bottom, 20)

                        HStack {
                            CustomTextField(text: $inputText,
                                            background: .white) {
                                submitAction()
                            }
                                            .placeholder(when: inputText.isEmpty) {
                                                Text("Paste your code here...")
                                                    .foregroundColor(.gray)
                                            }
                                            .cornerRadius(100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(inputBorderColor, lineWidth: 2)
                                            )
                                            .padding(.vertical, 20)

                            Button(action: {
                                dismissKeyboard()
                                withAnimation {
                                    isQRScannerPresent.toggle()
                                }
                            }) {
                                Image("qr")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            }
                            .frame(width: 56, height: 46)
                            .background {
                                Rectangle()
                                    .fill(Color("BackgroundGray"))
                                    .cornerRadius(40)
                            }
                        }

                        Button(action: {
                            dismissKeyboard()
                            submitAction()
                        }) {
                            Text("Continue")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                        .modifier(PrimaryButton())
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(height: 200)
            }
            .offset(y: YOffset)
        }
        .transition(.opacity)
        .onAppear {
            isQRScannerPresent = false
            withAnimation(.easeOut(duration: 0.3)) {
                YOffset = 0
            }
        }
        .onDisappear {
            dismissKeyboard()
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .onChange(of: appModel.errorMessages) { _ in
            inputBorderColor = appModel.errorMessages.isEmpty ? Color("BackgroundGray") : Color("Red")
        }
    }
}
