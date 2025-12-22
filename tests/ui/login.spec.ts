import { test, expect } from '@playwright/test';


import * as userData from '../../test_data/users.example.json';

test.describe('Login with valid credentials', () => {

  test('successfully login with admin account', async ({ page }) => {

    const config = userData.environments.stg;
    const user = config.admin;

    // 1. Go to login page
    await page.goto(config.baseUrl, { waitUntil: 'networkidle' });

    // Make sure login page is really rendered
    await expect(page
    .getByText('ĐĂNG NHẬP TÀI KHOẢN CỦA BẠN')).toBeVisible();

    // 2. Input login's information
    const emailInput = page
    .locator('input[autocomplete="username"]');
    const passwordInput = page
    .locator('input[autocomplete="current-password"]');
    await emailInput.fill(user.email);
    await passwordInput.fill(user.password);

    // 3. Click Sign in button
    await page.getByRole('button', { name: 'ĐĂNG NHẬP' }).click();

    //Verify after successfully sign in
    await page.waitForURL('**/portal**', { timeout: 15000 });
    await page.waitForLoadState('load');

    const factoryTitle = page.getByText(/KHATOCO KHANH HOA CIGARETTE FACTORY/i);
    await expect(factoryTitle).toBeVisible({ timeout: 10000 });

    const dxFactoryLink = page
    .getByRole('link', {name: /DxFACTORY Trang quản trị hệ thống/i});
    await expect(dxFactoryLink).toBeVisible({timeout: 10000});
    await dxFactoryLink.focus();
    await expect(dxFactoryLink).toBeFocused();

    const dxMPMLink = page
    .getByRole('link', {name: /DxMPM Trang quản lý sản xuất DxMPM/i});
    await expect(dxMPMLink).toBeVisible({timeout: 10000});
    await dxMPMLink.focus();
    await expect(dxMPMLink).toBeFocused();

  });

  test('Verify error when input the wrong username', async ({ page }) => {

    const config = userData.environments.stg;
    const user = config.admin;

    await page.goto(config.baseUrl, { waitUntil: 'networkidle' });

    await expect(page
    .getByText('ĐĂNG NHẬP TÀI KHOẢN CỦA BẠN')).toBeVisible();

    const emailInput = page
    .locator('input[autocomplete="username"]');
    const passwordInput = page
    .locator('input[autocomplete="current-password"]');
    await emailInput.fill("minhnguyen@gmail.com");
    await passwordInput.fill(user.password);

    await page.getByRole('button', { name: 'ĐĂNG NHẬP' }).click();

    const errorMessage = page.locator('.fuse-alert-message');
    await expect(errorMessage).toBeVisible();
    await expect(errorMessage).toContainText('Người dùng đăng nhập sai');

  });

  test('Verify error when inputing wrong password', async ({ page }) => {

    const config = userData.environments.stg;
    const user = config.admin;

    await page.goto(config.baseUrl, { waitUntil: 'networkidle' });

    await expect(page
    .getByText('ĐĂNG NHẬP TÀI KHOẢN CỦA BẠN')).toBeVisible();

    const emailInput = page
    .locator('input[autocomplete="username"]');
    const passwordInput = page
    .locator('input[autocomplete="current-password"]');
    await emailInput.fill("user.email");
    await passwordInput.fill('1234567789');

    await page.getByRole('button', { name: 'ĐĂNG NHẬP' }).click();

    const errorMessage = page.locator('.fuse-alert-message');
    await expect(errorMessage).toBeVisible();
    await expect(errorMessage).toContainText('Người dùng đăng nhập sai');

  });

});

