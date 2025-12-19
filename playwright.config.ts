import { defineConfig, devices } from '@playwright/test';

/**
 * Xem hướng dẫn cấu hình chi tiết tại:
 * https://playwright.dev/docs/test-configuration
 */
export default defineConfig({
  // Đường dẫn đến thư mục chứa các bài test của bạn
  testDir: './tests',
  
  // Chạy các test trong các file song song để tiết kiệm thời gian
  fullyParallel: true,
  
  // Ngăn chặn việc quên lệnh test.only khi đẩy code lên CI
  forbidOnly: !!process.env.CI,
  
  // Tự động chạy lại (retry) 2 lần trên CI nếu test bị lỗi (Flakiness Management)
  retries: process.env.CI ? 2 : 0,
  
  // Giới hạn số lượng worker trên CI để tránh quá tải hệ thống
  workers: process.env.CI ? 1 : undefined,
  
  // Sử dụng cả báo cáo HTML và JUnit (để hiển thị kết quả trên Azure DevOps Tab Test)
  reporter: [
    ['html'],
    ['junit', { outputFile: 'results.xml' }]
  ],

  /* Cấu hình chung cho các dự án bên dưới */
  use: {
    // Base URL giúp bạn viết page.goto('/') ngắn gọn hơn
    baseURL: 'https://dev.agentiqai.ai',

    // Chụp ảnh khi test thất bại (DoD: Bằng chứng lỗi)
    screenshot: 'only-on-failure',

    // Quay video khi test thất bại để dễ dàng debug
    video: 'retain-on-failure',

    // Lưu lại Trace khi có lỗi (Rất quan trọng để xem lại luồng đăng nhập)
    trace: 'retain-on-failure',
    
    // Tự động chờ các phần tử (Auto-wait) trong tối đa 10 giây
    actionTimeout: 10000,
  },

  /* Cấu hình chạy trên các trình duyệt khác nhau */
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },

    // {
    //   name: 'firefox',
    //   use: { ...devices['Desktop Firefox'] },
    // },

    // {
    //   name: 'webkit',
    //   use: { ...devices['Desktop Safari'] },
    // },

    // /* Giả lập thiết bị di động (Tùy chọn) */
    // {
    //   name: 'Mobile Chrome',
    //   use: { ...devices['Pixel 5'] },
    // },
  ],
});