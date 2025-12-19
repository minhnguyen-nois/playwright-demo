// Dùng để giả lập phản hồi từ server khi login
export const mockLoginResponse = async (page) => {
    await page.route('**/api/auth/login', route => route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({ token: 'fake-token-123', user: 'Minh Nguyen' }),
    }));
  };