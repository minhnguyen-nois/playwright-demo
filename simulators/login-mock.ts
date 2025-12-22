import { Page, Route } from '@playwright/test'; 

export const mockLoginResponse = async (page: Page) => { 
  await page.route('**/api/auth/login', (route: Route) => route.fulfill({ 
    status: 200,
    contentType: 'application/json',
    body: JSON.stringify({ token: 'fake-token-123', user: 'Minh Nguyen' }),
  }));
};