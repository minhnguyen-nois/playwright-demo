import { test, expect } from '@playwright/test';
import path from 'node:path';

test('Login successful into Agents', async ({ page }) => {
    await page.goto('https://dev.agentiqai.ai/auth/sign-in');
    await expect(page.getByText('Sign In', { exact: false })).toBeVisible();
    // fill the email and password
    //await expect(page.getByLabel('textbox', {name: 'Email'})).toBeVisible();
    await page.getByRole('textbox', { name: 'Email' }).fill('minhnguyen@agentiqai.ai');
    //await expect(page.getByLabel('textbox',{name: 'Password'})).toBeVisible();
    await page.getByRole('textbox', { name: 'Password' }).fill('minhnguyen');
    await page.getByRole('button', { name: 'Sign in' }).click();
    // Verify then click on the create button.
    await expect(page.getByRole('link', { name: 'Agents' }).nth(2)).toBeVisible();
    });
// test('Verify Specialist, Orchestrator, and Functional options', async ({ page }) => {
//     await page.getByRole('button', { name: 'Create' }).click();
//     // Verify Specialist option.
//     const SpecialistOptions = page.getByRole('button', {name: 'Specialist'});
//     await expect(SpecialistOptions).toBeVisible();
//     // Verify Orchestrator option.    
//     const OrchestratorOptions = page.getByRole('button', {name: 'Orchestrator'});
//     await expect(OrchestratorOptions).toBeVisible();
//     // Verify then click on the Functional option.
//     const FunctionalOptions = page.getByRole('button', {name: 'Functional'});
//     await expect(FunctionalOptions).toBeVisible();
//     await FunctionalOptions.click();
//     });

// test('successfully create functional agent', async ({ page }) => {
//     //Verify i am in Agent Details page.
//     const Agentdetails = page.getByRole('textbox', {name: 'Agent details'});
//     await expect(page.getByText('Agent details')).toBeVisible();
//     //Fill in the Agent details.
//     const agentNameInput = page.getByLabel('Agent Name');
//     await agentNameInput.fill('Second Functional Agent');
//     //Fill in the Agent description.
//     const agentDescriptionInput = page.getByLabel('Agent Description');
//     await agentDescriptionInput.fill('This is a test description for the second functional agent.');
//     //Open the Agent type dropdown.
//     const typeDropdown = page.getByText('Select Type');
//     await typeDropdown.click();
//     const autonomousOption = page.getByRole('option', {name: 'Autonomous'});
//     await autonomousOption.click();
//     //verify the Agent type is Autonomous.
//     await expect(page.getByAltText('Autonomous', {exact: true})).toBeVisible();
//     //Upload the Agent icon.
//     const fileChooserPromise = page.waitForEvent('filechooser');
//     await page.getByRole('button',{name: 'Choose file'}).click();

//     const fileChooser = await fileChooserPromise;
//     await fileChooser.setFiles(path.join(__dirname, 'agent-icon.png'));
    
//     //Click on the next button
//     const nextButton = page.getByRole('button', {name: 'Next'});
//     await nextButton.click();
//     //Verify Trigger step is redirected
//     await expect(page.getByRole('heading', {name: 'Trigger'})).toBeVisible();

//     //Choose API Trigger
//     await expect(page.getByText('Trigger', {exact: true})).toBeVisible();
//     //Open trigger type dropdown
//     await page.locator('div').filter({hasText: /^Select Trigger Type$/}).click();
//     //verify options exist and visible
//     const scheduleoption = page.getByRole('option',{name: 'Schedule'});
//     await expect(scheduleoption).toBeVisible();
//     const apiTriggerOption = page.getByRole('option', {name: 'API Trigger'});
//     await expect(apiTriggerOption).toBeVisible();

//     //pick apiTriggerOption
//     await apiTriggerOption.click();
//     //verify selection and proceed to pipeline
//     await expect(page.locator('div').filter({hasText: /^API Trigger4/})).toBeVisible();
//     //Verify Pre button
//     const prevButton = page.getByRole('button', {name: 'Prev'});
//     await expect(prevButton).toBeVisible();
//     //Click next button
//     await page.getByRole('button', {name:'Next'}).click();

//     //Verify user is navigated to Pipeline step
//     await expect(page.getByAltText('Pipeline')).toBeVisible();
    
    
    // });

  