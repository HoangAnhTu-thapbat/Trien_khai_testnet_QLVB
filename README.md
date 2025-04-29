# DiplomaManager Smart Contract

## 1. Cài đặt Yêu Cầu

### Trình duyệt
- Chrome, Edge hoặc Brave

### Plugin MetaMask
- Tải từ: [MetaMask](https://metamask.io/)
- Tạo ví mới hoặc import ví cũ (có backup phrase)

### Remix IDE
- Truy cập: [Remix IDE](https://remix.ethereum.org)
- Không cần cài đặt, chạy ngay trên trình duyệt

### Nhận ETH Test (Sepolia)
- Vào faucet: [Sepolia Faucet](https://sepoliafaucet.com/) hoặc [Quicknode Faucet](https://faucet.quicknode.com/) hoặc [Quicknode Faucet](https://faucet.quicknode.com/) nếu bạn chưa có tiền thật trong ví.
- Paste địa chỉ ví để nhận ETH test

## 2. Copy Mã Hợp Đồng

- Tạo file mới trong Remix IDE với tên `QLVB.sol`
- Copy toàn bộ mã nguồn từ file `QLVB.sol` vào file vừa tạo

## 3. Compile Hợp Đồng

- Chuyển sang tab **Solidity Compiler** (biểu tượng hình tam giác)
- Bấm **Compile QLVB.sol**

## 4. Triển khai Hợp Đồng (Deploy)

- Chuyển sang tab **Deploy & Run Transactions** (hình điện)
- Ở mục **ENVIRONMENT** chọn **Sepolia  - MetaMask** (nếu bạn chưa có tiền sepolia thì không cần chọn và có thể dùng tiền mặc định của remix)
- Chọn tài khoản MetaMask có ETH testnet
- Chọn contract `DiplomaManager` trong danh sách contract
- Bấm **Deploy**
- MetaMask sẽ hiện ra, bấm **Xác nhận (Confirm)**
- Sau khi triển khai thành công, xem mục **Deployed Contracts** bên dưới

## 5. Sử dụng Các Hàm Trong Hợp Đồng

- `issueDiploma(...)`  : nhập thông tin sinh viên và gửi với VALUE là >= 0.001 ETH
- `getDiplomaIds()`    : xem danh sách các `diplomaId`
- `getDiploma(id)`     : xem chi tiết văn bằng với ID
- `withdraw()`         : admin rút tiền về ví

## 6. Lưu ý

- Phải chọn đúng **Sepolia** trong MetaMask trước khi deploy.
- Khi deploy xong, không thấy contract hiện ra thì do bạn đang ở sai network hoặc chưa Confirm giao dịch.
- Phí gas sẽ do mạng quy định (không cố định), không liên quan đến phí cấp bằng.
