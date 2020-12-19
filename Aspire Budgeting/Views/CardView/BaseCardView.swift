//
//  BaseCardView.swift
//  Aspire Budgeting
//

import SwiftUI

struct BaseCardView<Content: View>: View {
  var minY: CGFloat = 0
  var curY: CGFloat = 0

  private let cornerRadius: CGFloat = 24
  private let height: CGFloat = 163

  private let shadowRadius: CGFloat = 14
  private let shadowYOffset: CGFloat = 4

  private var baseColor: Color
  private let content: Content

//  private var gradient: LinearGradient {
//    Color.fondGradientFrom(startColor: colorInfo.gradientStartColor,
//                           endColor: colorInfo.gradientEndColor)
//  }

  private var offsetY: CGFloat {
    curY < minY ? minY - curY : 0
  }

  init(minY: CGFloat = 0,
       curY: CGFloat = 0,
       baseColor: Color,
       @ViewBuilder content: () -> Content) {
    self.minY = minY
    self.curY = curY
    self.baseColor = baseColor
    self.content = content()
  }

  var body: some View {
    ZStack(alignment: .top) {
      containerBox
      content
    }
    .offset(y: offsetY)
  }
}

extension BaseCardView {
  private var containerBox: some View {
    Rectangle()
      .fill(baseColor)
      .cornerRadius(cornerRadius)
      .frame(height: height)
  }
}

// MARK: - Internal Types
extension BaseCardView {
  struct CardViewItem {
    let title: String
    let availableTotal: AspireNumber
    let budgetedTotal: AspireNumber
    let spentTotal: AspireNumber
    let progressFactor: Double
    let categories: [Category]
  }
}

// MARK: - Previews
struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Group {
        BaseCardView<Color>(baseColor: .materialBlue800) {Color.materialBlue800}

        BaseCardView<Color>(baseColor: .materialTeal800) {Color.materialTeal800}
      }
    }
  }
}