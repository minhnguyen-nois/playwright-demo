import { test, expect } from '@playwright/test';
import { mockLoginResponse } from '@simulators/login-mock';

test.describe('Integration Test - Login Flow', () => {

    test('Successfully login with valid credential with mock API', async ({ page }) => {
        // 1. Setup Mock API before navigation
        await mockLoginResponse(page);
    
        // 2. Go to login page and wait for network to be idle
        await page.goto('/sign-in', { waitUntil: 'networkidle' });
    
        // 3. Ensure the form is visible before interacting
        const emailInput = page.locator('#email');
        await expect(emailInput).toBeVisible({ timeout: 5000 });

        const passwordInput = page.locator ('#password');
        await expect(passwordInput).toBeVisible({timeout: 5000});
    
        const loginBtn = page.getByRole('button', { name: 'ĐĂNG NHẬP' });
        await expect(loginBtn).toBeVisible({timeout: 5000});
    
        // 4. Fill in credentials
        await emailInput.fill('MINH');
        await page.locator('#password').fill('Khatoco@123');
    
        // 5. Catch the response and click simultaneously
        // IMPORTANT: Note the [response] destructuring to fix your "response is not defined" error
        const [response] = await Promise.all([
            page.waitForResponse(res => res.url()
            .includes('/api/v1/Token') && res.status() === 200),
            loginBtn.click()
        ]);
    
        // 6. Verify data returned from your Mock API
        const responseBody = await response.json();
        expect(responseBody.result).toBe('Success');
        expect(responseBody.username).toBe('MINH');

        // Verify specific dashboard text appears
        const dashboardText = page
        .getByText('KHATOCO KHANH HOA CIGARETTE FACTORY');
        await expect(dashboardText)
        .toBeVisible({ timeout: 20000 });
                
        // 7. Verify navigation to Portal
        await page.waitForURL('**/portal**');
        await expect(page).toHaveURL(/.*portal/);
        

    });

});