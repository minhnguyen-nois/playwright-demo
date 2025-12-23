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
    Bash: `npm install -D @playwright/test@latest`
    Check playwright version: `npx playwright --version`

- Cài đặt Node.js (phiên bản 18 trở lên).
- Chạy lệnh: `npm install` để cài đặt thư viện.
- Cài đặt trình duyệt Playwright: `npx playwright install`.

## 3. Running tests

1. ** Running as headless mode (chế độ ẩn danh)
Dùng để chạy nhanh hoặc chạy trên server CI/CD
For example, we run file login-user.spec.ts
`npx playwright test tests/ui/login-user.spec.ts`
When running all test cases, we could use:
`npx playwright test`

Running with chromium: `npx playwright test --project=chromium`
Running with firefox: `npx playwright test --project=firefox`
Running with webkit: `npx playwright test --project=webkit`

2. ** Running as headed mode (hiển thị trình duyệt)
Dùng khi bạn muốn quan sát trực tiếp Playwright
For example, we run file login-user.spec.ts
`npx playwright test tests/ui/login-user.spec.ts --headed`
When running all test cases, we could use:
`npx playwright test --headed`

3. **Running and opening debug interface (UI mode)
`npx playwright test --ui`

4. **Viewing Report
`npx playwright show-report`

5. **Remove playwright-report, test-results after running
`rm -Recurse -Force playwright-report, test-results`
