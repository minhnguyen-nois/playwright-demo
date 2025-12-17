Feature: Workflow folders management

Background:
  Given I am logged in to the dashboard
  When I click on the "Library" menu item in the left sidebar
  And I click on the "Workflows" folder card
  Then I should be navigated to the Workflows folder contents

Scenario: User views Workflows page elements
  Then I should see a search bar with placeholder "Search files/folders..."
  And I should see the "New Workflow" button
  And I should see the "Workflows" heading
  And I should see the "Name A-Z" sorting option with up/down arrow
  And I should see the "Size" sorting option with up/down arrow
  And I should see view toggle icons (list view and grid view)
  And I should see a table with headers "Name" and "Created At"
  And I should see a checkbox in the table header for selecting all items

Scenario: User views empty Workflows state
  And no workflows exist
  Then I should see the summary text "0 item � 0 folder � 0 file"

Scenario: User views Workflows page with existing workflows
  And there are existing workflows in the Workflows page
  Then I should see a table with columns "Name", "Size", "Type", and "Created At"
  And I should see workflow rows displayed in the table
  And each workflow row should display a workflow icon
  And each workflow row should display the workflow name
  And each workflow row should display "Workflow" in the Type column
  And each workflow row should display the creation date in "Created At" column
  And each workflow row should have a checkbox for selection
  And each workflow row should have a blue pencil icon for editing
  And each workflow row should have a red trash can icon for deleting
  And I should see the summary text showing the correct count of items, folders, and workflows

Scenario: User selects an individual workflow
  And there are existing workflows in the Workflows page
  When I click on the checkbox for a specific workflow
  Then that workflow should be selected
  And the workflow should be highlighted

Scenario: User edits workflow name
  And there are existing workflows in the Workflows page
  When I click on the edit icon for a workflow
  And I should see the current workflow name in the input field
  When I update the workflow name
  And I use the Enter keyboard to save
  Then the workflow name should be updated successfully
  And I should see the updated workflow name in the Workflows list

Scenario: User edits a workflow using edit icon
  And there are existing workflows in the Workflows page
  When I click on the stroke-linejoin icon for a workflow
  Then I should see an edit dialog open
  And I should see the current workflow name in the "Name" input field
  And I should see the current workflow description in the "Description" text area
  And I should see the current workflow steps in the Steps section
  When I update the workflow name
  And I update the workflow description
  And I click on the "Save" or "Update" button
  Then the workflow should be updated successfully
  And the modal should be closed
  And I should see the updated workflow name in the Workflows list

Scenario: User searches for workflows
  When I enter text in the search bar "Dxfact-Lab1"
  Then I should see search results filtered based on the entered text

Scenario: User clicks on New Workflow button
  When I click on the "New Workflow" button
  Then I should see a modal dialog titled "Create New Workflow" and the subtitle "Fill in the details below to create a new workflow."

Scenario: User opens Create New Workflow modal
  Given I am logged in to the dashboard
  When I click on the "Library" menu item in the left sidebar
  And I click on the "Workflows" folder card
  And I click on the "New Workflow" button
  Then the "Create New Workflow" modal is open

Scenario: User views workflow creation form elements
  Then I should see the "Name" input field with placeholder "Enter workflow name"
  And I should see the "Description" text area with placeholder "Enter workflow description"
  And I should see the "Steps" section
  And I should see at least one step input field
  And I should see a drag handle icon for each step
  And I should see a delete icon for each step
  And I should see the "Add Step" button
  And I should see a close "X" button in the modal

Scenario: User reorders steps in workflow
  And there are multiple steps in the workflow
  And I can see the current order of steps
  When I drag a step using the drag handle icon to a different position
  Then the steps should be reordered according to the new position
  And the step order should be updated correctly

Scenario: User adds a new step to workflow
  When I click on the "Add Step" button
  Then a new step input field should be added to the Steps section

Scenario: User removes a step from workflow
  And there are multiple steps in the workflow
  When I click on the delete icon for a step
  Then that step should be removed from the Steps section

Scenario: User creates a new workflow
  When I enter a workflow name in the "Name" input field
  And I enter a workflow description in the "Description" text area
  And I enter step details for each step
  And I click on the "Create" or "Save" button
  Then the workflow should be created successfully
  And the modal should be closed
  And I should see the new workflow in the Workflows list

Scenario: E2E - Complete flow to create a new workflow from scratch
  And I should see the sub-navigation "Library > Workflows" with "Workflows" highlighted
  And I should see the "New Workflow" button
  When I click on the "New Workflow" button
  Then I should see a modal dialog titled "Create New Workflow"
  And I should see the subtitle "Fill in the details below to create a new workflow."
  And I should see a "Name" input field with placeholder "Enter workflow name"
  And I should see a "Description" text area with placeholder "Enter workflow description"
  And I should see a "Steps" section
  When I enter "Customer Onboarding Process" in the "Name" input field
  And I enter "Automated workflow for new customer onboarding" in the "Description" text area
  And I enter "Send welcome email" in the first step input field
  And I click on the "Add Step" button
  And I enter "Create customer account" in the new step input field
  And I click on the "Add Step" button
  And I enter "Assign account manager" in the new step input field
  And I click on the "Create" button
  Then the workflow should be created successfully
  And the modal should be closed
  And I should see the new workflow "Customer Onboarding Process" in the Workflows list
  And the workflow should display a workflow icon
  And the workflow should display "Workflow" in the Type column
  And the summary count should be updated to include the new workflow

Scenario: E2E - Create workflow with multiple steps and reorder them
  When I click on the "New Workflow" button
  Then the "Create New Workflow" modal is open
  When I enter "Order Processing Workflow" in the "Name" input field
  And I enter "Handles order processing from receipt to delivery" in the "Description" text area
  And I enter "Receive order" in the first step input field
  And I click on the "+ Add Step" button
  And I enter "Process payment" in the new step input field
  And I click on the "+ Add Step" button
  And I enter "Ship order" in the new step input field
  And I click on the "+ Add Step" button
  And I enter "Send confirmation email" in the new step input field
  Then I should see four steps in the Steps section
  When I note the current order of steps
  And I drag the "Send confirmation email" step using its drag handle icon to the second position
  Then the steps should be reordered correctly
  And "Send confirmation email" should now be in the second position
  And "Process payment" should now be in the third position
  When I click on the "Create" button
  Then the workflow should be created successfully
  And I should see "Order Processing Workflow" in the Workflows list
  When I click on the blue pencil edit icon for "Order Processing Workflow"
  Then I should see the steps in the reordered sequence

Scenario: E2E - Create workflow, edit it, and verify updates
  When I click on the "New Workflow" button
  And I enter "Initial Workflow" in the "Name" input field
  And I enter "Initial description" in the "Description" text area
  And I enter "Step 1" in the first step input field
  And I click on the "Create" button
  Then the workflow "Initial Workflow" should be created successfully
  When I click on the blue pencil edit icon for "Initial Workflow"
  Then I should see an edit dialog or form open
  And I should see "Initial Workflow" in the "Name" input field
  And I should see "Initial description" in the "Description" text area
  When I update the workflow name to "Updated Workflow"
  And I update the workflow description to "Updated description with more details"
  And I click on the "+ Add Step" button
  And I enter "Step 2" in the new step input field
  And I click on the "Save" button
  Then the workflow should be updated successfully
  And the modal should be closed
  And I should see "Updated Workflow" in the Workflows list
  And "Initial Workflow" should no longer appear
  When I click on the blue pencil edit icon for "Updated Workflow"
  Then I should see "Updated description with more details" in the "Description" text area
  And I should see both "Step 1" and "Step 2" in the Steps section

Scenario: E2E - Create workflow, add and remove steps dynamically
  When I click on the "New Workflow" button
  And I enter "Dynamic Workflow" in the "Name" input field
  And I enter "Workflow with dynamic step management" in the "Description" text area
  And I enter "Initial step" in the first step input field
  And I click on the "Add Step" button
  And I enter "Second step" in the new step input field
  And I click on the "Add Step" button
  And I enter "Third step" in the new step input field
  Then I should see three steps in the Steps section
  When I click on the delete icon for "Second step"
  Then "Second step" should be removed from the Steps section
  And I should see only "Initial step" and "Third step"
  When I click on the "Add Step" button
  And I enter "New second step" in the new step input field
  Then I should see three steps again: "Initial step", "New second step", and "Third step"
  When I click on the "Create" button
  Then the workflow should be created successfully
  And I should see "Dynamic Workflow" in the Workflows list

Scenario: E2E - Create multiple workflows and verify organization
  When I click on the "New Workflow" button
  And I enter "Workflow A" in the "Name" input field
  And I enter "Description A" in the "Description" text area
  And I enter "Step A1" in the first step input field
  And I click on the "Create" button
  Then the workflow "Workflow A" should be created successfully
  When I click on the "New Workflow" button
  And I enter "Workflow B" in the "Name" input field
  And I enter "Description B" in the "Description" text area
  And I enter "Step B1" in the first step input field
  And I click on the "Create" button
  Then the workflow "Workflow B" should be created successfully
  When I click on the "New Workflow" button
  And I enter "Workflow C" in the "Name" input field
  And I enter "Description C" in the "Description" text area
  And I enter "Step C1" in the first step input field
  And I click on the "Create" button
  Then the workflow "Workflow C" should be created successfully
  When I view the Workflows list
  Then I should see all three workflows: "Workflow A", "Workflow B", and "Workflow C"
  And each workflow should display a workflow icon
  And the summary count should show the correct number of workflows
  When I click on the "Name A-Z" sorting option
  Then the workflows should be sorted alphabetically: "Workflow A", "Workflow B", "Workflow C"

Scenario: E2E - Create workflow, delete it, and verify removal
  When I click on the "New Workflow" button
  And I enter "Temporary Workflow" in the "Name" input field
  And I enter "This workflow will be deleted" in the "Description" text area
  And I enter "Temporary step" in the first step input field
  And I click on the "Create" button
  Then the workflow "Temporary Workflow" should be created successfully
  And I should see "Temporary Workflow" in the Workflows list
  When I note the current summary count
  And I click on the red trash can delete icon for "Temporary Workflow"
  Then I should see a confirmation dialog
  When I confirm the deletion
  Then the workflow should be deleted successfully
  And "Temporary Workflow" should no longer appear in the Workflows list
  And the summary count should be updated to reflect the deletion

Scenario: E2E - Create workflow with complex step structure
  When I click on the "New Workflow" button
  And I enter "Complex Multi-Step Workflow" in the "Name" input field
  And I enter "A comprehensive workflow with multiple sequential steps" in the "Description" text area
  And I enter "Initialize system" in the first step input field
  And I click on the "+ Add Step" button
  And I enter "Validate input data" in the new step input field
  And I click on the "+ Add Step" button
  And I enter "Process data transformation" in the new step input field
  And I click on the "+ Add Step" button
  And I enter "Generate report" in the new step input field
  And I click on the "+ Add Step" button
  And I enter "Send notifications" in the new step input field
  And I click on the "+ Add Step" button
  And I enter "Archive completed task" in the new step input field
  Then I should see six steps in the Steps section
  When I verify the order of steps
  Then the steps should be in the correct sequence
  When I click on the "Create" button
  Then the workflow should be created successfully
  And I should see "Complex Multi-Step Workflow" in the Workflows list
  When I click on the blue pencil edit icon for "Complex Multi-Step Workflow"
  Then I should see all six steps in the Steps section
  And the steps should be in the correct order

Scenario: User cancels creating a new workflow
  When I click on the "Cancel" button or close the modal
  Then the modal should be closed
  And no new workflow should be created

Scenario: User closes the create workflow modal
  When I click on the "X" close button in the modal
  Then the modal should be closed

Scenario: User sorts workflows by name
  When I click on the "Name A-Z" sorting option
  Then the workflows should be sorted by name in ascending order

Scenario: User sorts workflows by size
  When I click on the "Size" sorting option
  Then the workflows should be sorted by size

Scenario: User toggles between list and grid view in Workflows
  When I click on the grid view icon
  Then the workflows should be displayed in grid view
  When I click on the list view icon
  Then the workflows should be displayed in list view
