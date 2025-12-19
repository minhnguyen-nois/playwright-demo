import { test, expect } from '@playwright/test';
// Nạp dữ liệu từ file JSON bạn đã tạo
import * as userData from '../../test_data/users.example.json';

test.describe('Authentication Suite', () => {
    
    test('successfully login with admin account', async ({ page }) => {
        const config = userData.environments.dev;
        const user = config.admin;

        // 1. Đi tới trang đăng nhập
        await page.goto(`${config.baseUrl}/auth/sign-in`);

        // 2. Điền thông tin (Playwright tự động chờ field xuất hiện)
        await page.fill('input[name="email"]', user.email);
        await page.fill('input[name="password"]', user.password);

        // 3. Click nút Sign In
        // Sử dụng locator mạnh mẽ hơn để tránh lỗi khi nút thay đổi nội dung thành "Signing in..."
        const signInButton = page.getByRole('button', { name: /Sign In/i });
        await signInButton.click();

        // 4. Xử lý trạng thái chờ (DoD: Đảm bảo chuyển trang thành công)
        // Playwright sẽ đợi cho đến khi URL thay đổi hoặc hết timeout
        await page.waitForURL('**/dashboard', { timeout: 30000 });

        // 5. Assert (Kiểm chứng)
        // Kiểm tra URL và kiểm tra một thành phần đặc trưng của Dashboard (ví dụ: Sidebar)
        await expect(page).toHaveURL(/.*dashboard/);
        
        // Ví dụ: Kiểm tra Dashboard có hiển thị chữ "Dashboard" không
        // await expect(page.getByText('Dashboard')).toBeVisible();
    });

//     test('Verify error when input the wrong password', async ({ page }) => {
//         const config = userData.environments.dev;
        
//         await page.goto(`${config.baseUrl}/auth/sign-in`);
//         await page.fill('input[name="email"]', 'minhnguyen@gmail.com');
//         await page.fill('input[name="password"]', '123456789');
//         await page.click('button:has-text("Sign In")');

//         // Kiểm tra thông báo lỗi xuất hiện (thay thế selector phù hợp với web của bạn)
//         // await expect(page.locator('.error-message')).toBeVisible();
//     });
});