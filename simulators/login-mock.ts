import { Page, Route } from '@playwright/test';

export const mockLoginResponse = async (page: Page) => {
  await page.route('**/api/v1/Token', async (route: Route) => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({
        userId: 132,
        username: "MINH",
        fullName: "Minh Nguyen Thanh (Qc)",
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI5MDkxMDE1Zi0zMjNiLTQwNmYtOWQ4NC01MmNkODQxNmE2MWMiLCJJZCI6IjEzMiIsIlVzZXJuYW1lIjoiTUlOSCIsIkZ1bGxOYW1lIjoiTWluaCBOZ3V5ZW4gVGhhbmggKFFjKSIsImV4cCI6MTc2NjYzMTc5NCwiaXNzIjoibm9pcy52biIsImF1ZCI6Im5vaXMudm4ifQ.LJZc51ylSwis4MlHjFl3wKgH7PMjAbvcnJP2E6dlDuE", 
        permissions: null,
        isFirstLogin: false,
        isSuperAdmin: false,
        refreshToken: "a0b76df9daea40bba1717b5936149043",
        tokenType: "bearer",
        userRoles: [], 
        timeoutExpired: 0.0,
        result: "Success", 
        message: null,
        errorMessages: []
      }),
    });
  });
};