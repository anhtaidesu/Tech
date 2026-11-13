import SwiftUI

/// A fictional banking demo screen. It intentionally contains no credential fields
/// or banking integrations.
struct ContentView: View {
    @State private var notice: DemoNotice?

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                DemoBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        demoMark
                            .padding(.top, 8)

                        Spacer(minLength: 86)

                        greeting

                        Spacer(minLength: 76)

                        actionPanel
                        utilityBar
                    }
                    .frame(minHeight: proxy.size.height)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 16)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .preferredColorScheme(.light)
        .alert(item: $notice) { notice in
            Alert(
                title: Text(notice.title),
                message: Text(notice.message),
                dismissButton: .default(Text("Đã hiểu"))
            )
        }
    }

    private var demoMark: some View {
        HStack {
            Spacer()
            Text("LUMI DEMO")
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .tracking(1.2)
                .foregroundStyle(Color.black.opacity(0.52))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.white.opacity(0.38))
                .clipShape(Capsule())
        }
    }

    private var greeting: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Chào buổi tối,")
                .font(.system(size: 35, weight: .regular, design: .rounded))

            Text("TON THAT ANH TAI")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .tracking(-1.2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.black)
    }

    private var actionPanel: some View {
        VStack(spacing: 24) {
            HStack(spacing: 8) {
                QuickAction(icon: "arrow.left.arrow.right.circle", title: "Chuyển tiền\n& Thanh toán") {
                    notice = .transfer
                }
                QuickAction(icon: "qrcode", title: "Quét mã\nQR") {
                    notice = .qr
                }
                QuickAction(icon: "gift", title: "Lumi Demo\nƯu đãi") {
                    notice = .offers
                }
            }

            VStack(spacing: 12) {
                Button {
                    notice = .login
                } label: {
                    Text("Đăng nhập (demo)")
                        .font(.system(size: 21, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .foregroundStyle(.white)
                        .background(Color(red: 0.10, green: 0.10, blue: 0.11))
                        .clipShape(Capsule())
                }
                .accessibilityHint("Mở thông báo về bản demo")

                Button {
                    notice = .personalQR
                } label: {
                    Text("Mã QR cá nhân (demo)")
                        .font(.system(size: 19, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .foregroundStyle(.black)
                        .overlay {
                            Capsule().stroke(Color.black, lineWidth: 1.6)
                        }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 25)
        .padding(.bottom, 22)
        .background(.white.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 38, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .stroke(.white.opacity(0.55), lineWidth: 1)
        }
    }

    private var utilityBar: some View {
        HStack(spacing: 4) {
            UtilityAction(icon: "calendar", title: "Đặt lịch hẹn") { notice = .appointment }
            UtilityAction(icon: "mappin.and.ellipse", title: "Chi nhánh\n& ATM") { notice = .locations }
            UtilityAction(icon: "phone", title: "Tổng đài") { notice = .phone }
            UtilityAction(icon: "headphones", title: "Hỗ trợ") { notice = .help }
        }
        .padding(.top, 25)
        .foregroundStyle(.black.opacity(0.9))
    }
}

private struct QuickAction: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 32, weight: .regular))
                    .frame(height: 38)
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineSpacing(1)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.black.opacity(0.9))
        }
        .buttonStyle(.plain)
    }
}

private struct UtilityAction: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 29, weight: .regular))
                    .frame(height: 34)
                Text(title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineSpacing(1)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

private struct DemoBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.54, green: 0.73, blue: 0.91),
                    Color(red: 0.82, green: 0.85, blue: 0.92),
                    Color(red: 1.0, green: 0.82, blue: 0.67),
                    Color(red: 0.63, green: 0.78, blue: 0.94)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RibbonShape()
                .fill(
                    LinearGradient(
                        colors: [Color(red: 1.0, green: 0.28, blue: 0.14), Color(red: 0.96, green: 0.11, blue: 0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 520, height: 570)
                .rotationEffect(.degrees(-4))
                .offset(x: -185, y: -205)

            ForEach([CGPoint(x: 0.62, y: 0.19), CGPoint(x: 0.82, y: 0.31), CGPoint(x: 0.62, y: 0.46)], id: \.self) { point in
                BirdShape()
                    .fill(Color.white.opacity(0.62))
                    .frame(width: 46, height: 25)
                    .position(x: UIScreen.main.bounds.width * point.x, y: UIScreen.main.bounds.height * point.y)
            }

            Circle()
                .fill(Color.white.opacity(0.42))
                .frame(width: 230, height: 230)
                .offset(x: -195, y: 495)
        }
    }
}

private struct RibbonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addCurve(to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.2), control1: CGPoint(x: rect.width * 0.12, y: rect.height * 0.1), control2: CGPoint(x: rect.width * 0.38, y: rect.height * 0.08))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addCurve(to: CGPoint(x: rect.width * 0.26, y: rect.height * 0.78), control1: CGPoint(x: rect.width * 0.73, y: rect.height * 0.94), control2: CGPoint(x: rect.width * 0.42, y: rect.height * 0.75))
        path.addCurve(to: CGPoint(x: 0, y: rect.height * 0.56), control1: CGPoint(x: rect.width * 0.15, y: rect.height * 0.73), control2: CGPoint(x: rect.width * 0.04, y: rect.height * 0.64))
        path.closeSubpath()
        return path
    }
}

private struct BirdShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height * 0.42))
        path.addCurve(to: CGPoint(x: rect.width * 0.45, y: rect.height * 0.6), control1: CGPoint(x: rect.width * 0.2, y: rect.height * 0.78), control2: CGPoint(x: rect.width * 0.34, y: rect.height * 0.78))
        path.addCurve(to: CGPoint(x: rect.width, y: 0), control1: CGPoint(x: rect.width * 0.72, y: rect.height * 0.56), control2: CGPoint(x: rect.width * 0.78, y: rect.height * 0.18))
        path.addCurve(to: CGPoint(x: rect.width * 0.52, y: rect.height * 0.3), control1: CGPoint(x: rect.width * 0.76, y: rect.height * 0.08), control2: CGPoint(x: rect.width * 0.64, y: rect.height * 0.2))
        path.addCurve(to: CGPoint(x: 0, y: rect.height * 0.42), control1: CGPoint(x: rect.width * 0.2, y: rect.height * 0.1), control2: CGPoint(x: rect.width * 0.1, y: rect.height * 0.38))
        path.closeSubpath()
        return path
    }
}

private enum DemoNotice: Identifiable {
    case login, personalQR, transfer, qr, offers, appointment, locations, phone, help

    var id: String { title }

    var title: String {
        switch self {
        case .login: return "Lumi Bank · Bản demo"
        case .personalQR: return "Mã QR cá nhân"
        case .transfer: return "Chuyển tiền & thanh toán"
        case .qr: return "Quét mã QR"
        case .offers: return "Ưu đãi Lumi"
        case .appointment: return "Đặt lịch hẹn"
        case .locations: return "Chi nhánh & ATM"
        case .phone: return "Tổng đài"
        case .help: return "Trợ giúp"
        }
    }

    var message: String {
        switch self {
        case .login: return "Đây là giao diện minh hoạ. Không có đăng nhập thật, không thu thập mật khẩu hoặc mã OTP."
        case .personalQR: return "Mã QR cá nhân chưa được kết nối trong prototype này."
        case .transfer: return "Tính năng giao dịch chỉ được mô phỏng trong bản demo."
        case .qr: return "Trình quét QR chưa được kết nối trong prototype này."
        case .offers: return "Khu vực ưu đãi mẫu đang được phát triển."
        case .appointment: return "Đặt lịch hẹn là tính năng minh hoạ."
        case .locations: return "Bản demo không truy cập vị trí hoặc dữ liệu ATM thật."
        case .phone: return "Không có tổng đài thật trong prototype này."
        case .help: return "Đây là bản demo Lumi Bank, không phải ứng dụng ngân hàng thật."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
