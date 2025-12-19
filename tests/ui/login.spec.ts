import { test, expect } from '@playwright/test';

// Nạp dữ liệu từ file JSON bạn đã tạo

import * as userData from '../../test_data/users.example.json';

test.describe('Authentication Suite', () => {

  test('successfully login with admin account', async ({ page }) => {

    const config = userData.environments.stg;

    const user = config.admin;

    // 1. Đi tới trang đăng nhập

    await page.goto(config.baseUrl, { waitUntil: 'networkidle' });

    // Đảm bảo trang login thực sự được render

    await expect(page.getByText('ĐĂNG NHẬP TÀI KHOẢN CỦA BẠN')).toBeVisible();

    // 2. Điền thông tin đăng nhập bằng các input có autocomplete

    const emailInput = page.locator('input[autocomplete="username"]');
    const passwordInput = page.locator('input[autocomplete="current-password"]');
    await emailInput.fill(user.email);
    await passwordInput.fill(user.password);

    // 3. Click nút ĐĂNG NHẬP

    await page.getByRole('button', { name: 'ĐĂNG NHẬP' }).click();

    // (Tuỳ bạn: thêm assert sau khi đăng nhập thành công)

  });

  // test('Verify error when input the wrong password', async ({ page }) => {

  //   const config = userData.environments.dev;

  //   await page.goto(`${config.baseUrl}/auth/sign-in`);

  //   await page.fill('input[name="email"]', 'minhnguyen@gmail.com');

  //   await page.fill('input[name="password"]', '123456789');

  //   await page.click('button:has-text("Sign In")');

  //   // await expect(page.locator('.error-message')).toBeVisible();

  // });

});

