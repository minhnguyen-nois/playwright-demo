# Hướng dẫn vận hành (Run Guide)

## 1. Prerequisites
* **Node.js**: Phiên bản 18.x trở lên (Kiểm tra bằng lệnh: `node -v`)
* **Trình quản lý gói**: NPM (đi kèm với Node.js)
* **IDE**: Visual Studio Code hoặc IntelliJ IDEA (đã cài plugin Playwright)

---

## 2. Setup

1. **Install plugin
    Open Terminal, cd to the project-base then bash:
    `npm install`  //for installing plugin
2. **Install playwright
    Bash: `npx playwright install`



- Cài đặt Node.js (phiên bản 18 trở lên).
- Chạy lệnh: `npm install` để cài đặt thư viện.
- Cài đặt trình duyệt Playwright: `npx playwright install`.

## 3. Running tests

1. ** Running as headless mode (chế độ ẩn danh)
Dùng để chạy nhanh hoặc chạy trên server CI/CD
For example, we run file login-user.spec.ts
`npx playwright test tests/ui/login-user.spec.ts`

2. ** Running as headed mode (hiển thị trình duyệt)
Dùng khi bạn muốn quan sát trực tiếp Playwright
For example, we run file login-user.spec.ts
`npx playwright test tests/ui/login-user.spec.ts --headed`

3. **Running and opening debug interface (UI mode)
`npx playwright test --ui`

4. **Viewing Report
`npx playwright show-report`
