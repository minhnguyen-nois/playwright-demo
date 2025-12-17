Feature: Workspace management

Background: User is logged in and viewing the Agents list
  Given I am viewing the Agents list page
  And I am logged in as "minhnguyen"

Scenario: Accessing Workspace Management from User Dropdown
  When I click on the User Profile "minhnguyen" in the header
  Then I should see the user dropdown menu
  And the dropdown menu should contain an item related to Workspace (e.g., the current workspace name)
  When I click on the item displaying the current workspace name (e.g., "minhnguyen")
  Then I should be redirected to the Workspace Management page
  And I should see the heading "Workspaces"

Scenario: Viewing statitic Workspace management site
  When I click on the User Profile "minhnguyen" in the header
  Then I should see the user dropdown menu
  And I click on the item displaying the current workspace name (e.g., "minhnguyen")
  Then I should be redirected to the Workspace Management page
  Then I should see the main heading "Workspaces"
  And I should see the "Create New Workspace" button
  And I should see a list or table structure displaying workspaces
  Then I should see the workspace name listed (e.g., "minhnguyen")
  And the workspace row should display a tag or indicator showing the status "Current"
  And the workspace row should have an "Edit" button
  And the current workspace name should be clickable, indicating navigation or selection

Scenario: Viewing the Edit Workspace Modal
  When I click the "Edit" button on the "minhnguyen" workspace row
  Then I should see the "Edit Workspace" modal
  And the modal should have the heading "Edit Workspace"
  And the modal should contain a field labeled "Name"
  And the "Name" field should be pre-populated with "minhnguyen"
  And I should see "Cancel" and "Save Changes" buttons

Scenario: Successfully Saving Workspace Name Changes
  When I click the "Edit" button on the "minhnguyen" workspace row
  Then the "Edit Workspace" modal is open
  When I change the text in the "Name" field to "minhnguyen_new"
  And I click the "Save Changes" button
  Then the "Edit Workspace" modal should be closed
  And I should see a success notification (e.g., "Workspace updated successfully")
  And the workspace name in the list should be updated to "minhnguyen_new"
  And the updated workspace "minhnguyen_new" should still display the "Current" tag

Scenario: Cancelling Workspace Name Changes
  Given the "Edit Workspace" modal is open
  When I modify the "Name" field (e.g., to "temporary_change")
  And I click the "Cancel" button
  Then the "Edit Workspace" modal should be closed
  And the workspace name in the list should remain "minhnguyen"

Scenario: Viewing the Create New Workspace Modal
  Given I am viewing the "Workspaces" page
  And the current workspace is "minhnguyen_new"
  When I click the "Create New Workspace" button
  Then I should see the "Create New Workspace" modal
  And the modal should have the heading "Create New Workspace"
  And the modal should contain a description: "Fill in the details below to create a new workspace."
  And the modal should contain a field labeled "Name" with placeholder "Enter workspace name"
  And I should see "Cancel" and "Create" buttons

Scenario: Successfully Creating a New Workspace
  Given I am viewing the "Workspaces" page
  And the current workspace is "minhnguyen_new"
  When I click the "Create New Workspace" button
  Then I should see the "Create New Workspace" modal
  When I enter a valid name "minhnguyen123" into the "Name" field
  And I click the "Create" button
  Then the "Create New Workspace" modal should be closed
  And I should see a success notification (e.g., "Workspace created successfully")
  And the new workspace "minhnguyen123" should be listed
  And the "minhnguyen123" row should display "Edit" and "Switch" buttons
  And the original workspace "minhnguyen_new" should still be marked as "Current"

Scenario: Cancelling New Workspace Creation
  Given I am viewing the "Workspaces" page
  And the current workspace is "minhnguyen_new"
  When I click the "Create New Workspace" button
  Then I should see the "Create New Workspace" modal
  When I enter a name (e.g., "temp_new_workspace")
  And I click the "Cancel" button
  Then the "Create New Workspace" modal should be closed
  And the workspace "temp_new_workspace" should NOT appear in the list

Scenario: New Workspace Requires Name
  Given I am viewing the "Workspaces" page
  And the current workspace is "minhnguyen_new"
  When I click the "Create New Workspace" button
  Then I should see the "Create New Workspace" modal
  When I leave the "Name" field empty
  And I click the "Create" button
  Then I should see an error message indicating the Name field is required
  And the modal should remain open

Scenario: Switching Workspace
  Given I am viewing the "Workspaces" page
  And the current workspace is "minhnguyen_new"
  And another workspace "minhnguyen123" exists
  Then the "minhnguyen_new" row should be marked as "Current"
  And the "minhnguyen123" row should display the "Switch" button
  When I click the "Switch" button on the "minhnguyen123" workspace row
  Then the page should redirect to the Agent List view
  And I should see the workspace name in the header is updated to "minhnguyen123"
  And I should see a success notification (e.g., "Switched to minhnguyen123 successfully")

Scenario: Verification on Workspace Management Page (Status Update)
  Given I am viewing the "Agents" list page
  And the current workspace is "minhnguyen123"
  When I click on the current workspace name "minhnguyen123" in the header
  Then I should see a dropdown menu listing available workspaces
  And the menu should contain the option "View All"
  When I click the "View All" option in the dropdown menu
  Then I should be redirected to the "Workspaces" page
  And I should see the main heading "Workspaces"
  And the workspace "minhnguyen123" should be listed
  And the workspace "minhnguyen123" should be marked as "Current"

Scenario: Verification UI of New Workspace Context
  Given the current workspace is "minhnguyen123"
  When I am viewing the "Agents" list page
  Then the workspace name in the header should clearly display "minhnguyen123"
  And the main heading of the page should be "Agents"
  And I should see the main content area indicating an absence of data
  And the empty state message should read: "No agents available. Click here to create your first agent."
  And I should see the "Create" button for creating a new Agent
  And I should see the "Import Agent" button
  And the search bar should be visible at the top of the Agent list area

Scenario: E2E - Successfully Creating and Switching to a New Workspace
  Given I am viewing the "Workspaces" page
  And the current workspace is "minhnguyen_new"
  When I click the "Create New Workspace" button
  Given the "Create New Workspace" modal is open
  When I enter the name "minhnguyen123" into the "Name" field
  And I click the "Create" button
  Then the "Create New Workspace" modal should be closed
  And I should see the success notification "Workspace created successfully"
  And the new workspace "minhnguyen123" should be listed next to "minhnguyen_new"
  When I click the "Switch" button on the "minhnguyen123" workspace row
  Then the page should redirect to the Agent List view
  And I should see a success notification (e.g., "Switched to minhnguyen123 successfully")
  And I should see the workspace name in the header is updated to "minhnguyen123"
  And I should see the main heading "Agents"
  And the Agent list area should display the empty state message: "No agents available. Click here to create your first agent."
  When I navigate back to the "Workspaces" page
  Then the workspace "minhnguyen123" should now be marked as "Current"
  And the original workspace "minhnguyen_new" should no longer display the "Current" tag
