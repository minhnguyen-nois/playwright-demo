import { test, expect } from '@playwright/test';
// Nạp dữ liệu từ file JSON bạn đã tạo
import * as userData from '../../test_data/users.example.json';

test.describe('Authentication Suite', () => {
    
    test('successfully login with admin account', async ({ page }) => {
        const config = userData.environments.dev;
        const user = config.admin;

        // 1. Đi tới trang đăng nhập
        await page.goto(`${config.baseUrl}/auth/sign-in`);

        // Email & password — use label-based or id/name-based locators
        await page.getByLabel('Email*').fill(user.email);
        await page.getByLabel('Password*').fill(user.password);

        // or, if you prefer CSS:
        await page.locator('#email').fill(user.email);
        await page.locator('#password').fill(user.password);
        // or:
        await page.locator('input[name="email"]').fill(user.email);
        await page.locator('input[name="password"]').fill(user.password);

        // Sign in button — your current selector is already good:
        await page.getByRole('button', { name: 'Sign In' }).click();


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