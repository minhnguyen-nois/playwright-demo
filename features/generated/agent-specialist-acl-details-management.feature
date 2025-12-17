Feature: Agent Specialist ACL details management

Background: User is on ACL tab for a specific agent
  Given I am logged in to the dashboard
  And I navigate to the Agents page
  And I open the agent detail "New Package test"
  And I click the "ACL" tab

Scenario: User views ACL tabs
  Then I should see "Role" and "User" tabs in ACL
  And the default selected tab should be "Role"
  And I should see a search bar with placeholder "Search roles..."
  And I should see the message "This table is empty."
  And I should see the "Add role" button

Scenario: Role tab shows existing roles
  Given there is at least one role assigned
  When I view the Role table
  Then I should see rows listing role name and permissions
  And each row should show actions to edit or delete (if available)

Scenario: User tab shows empty state
  When I click the "User" tab
  Then I should see a search bar with placeholder "Search users..."
  And I should see the message "This table is empty."
  And I should see the "Add user" button

Scenario: User tab shows existing users
  Given there is at least one user assigned
  When I view the User table
  Then I should see rows with user avatar, name, email, and description
  And each row should show edit and delete icons

Scenario: Open Add Role modal
  When I click the "Add role" button
  Then I should see the "Add Role" modal
  And I should see dropdown "Select Role" with placeholder "Choose a role..."
  And I should see permission dropdowns for "Chat with Agent", "Update Agent Info", "SUBMIT_TECHNICAL_NOTE" defaulting to "Not set"
  And I should see buttons "Cancel" and "Add role"

Scenario: Validate Add Role requires selection
  And the "Add Role" modal is open
  When I click "Add role" without selecting a role
  Then I should see a validation message indicating role selection is required
  And the modal should remain open

Scenario: Add Role with all permissions Allow
  And the "Add Role" modal is open
  When I choose role "Guidance user"
  And I set "Chat with Agent" to "Allow"
  And I set "Update Agent Info" to "Allow"
  And I set "SUBMIT_TECHNICAL_NOTE" to "Allow"
  And I click "Add role"
  Then the role should be added to the Role table
  And I should see the new role row with permissions reflected

Scenario: Close Add Role modal with X
  And the "Add Role" modal is open
  When I click the close "X" button
  Then the modal should close
  And no role should be added

Scenario: E2E - Add a role to an agent
  Given I am logged in to the dashboard
  And I navigate to agent "New Package test"
  And I open the "ACL" tab and stay on "Role"
  When I click "Add role"
  And I choose role "Guidance user"
  And I set all permissions to "Allow"
  And I click "Add role"
  Then I should see the new role listed in the Role table
  And the permissions should display as allowed

Scenario: Open Add User modal
  When I click the "User" tab
  And I click the "Add user" button
  Then I should see the "Add User" modal
  And I should see dropdown "Select User" with placeholder "Choose a user..."
  And I should see permission dropdowns for "Chat with Agent", "Update Agent Info", "SUBMIT_TECHNICAL_NOTE" defaulting to "Not set"
  And I should see buttons "Cancel" and "Add user"

Scenario: Add User with mixed permissions
  And the "Add User" modal is open
  When I select user "minhnguyen"
  And I set "Chat with Agent" to "Allow"
  And I set "Update Agent Info" to "Deny"
  And I set "SUBMIT_TECHNICAL_NOTE" to "Deny"
  And I click "Add user"
  Then the user should appear in the User table
  And the row should show description "User can chat with agent"

Scenario: Close Add User modal with Cancel
  And the "Add User" modal is open
  When I click the "Cancel" button
  Then the modal should close
  And no user should be added

Scenario: Edit User permissions
  Given a user row for "minhnguyen@agentiqai.ai" exists
  When I click the edit icon on that row
  Then I should see the "Edit User's Permissions" modal
  And the dropdowns for "Chat with Agent", "Update Agent Info", "SUBMIT_TECHNICAL_NOTE" should reflect current values
  When I change "SUBMIT_TECHNICAL_NOTE" to "Allow"
  And I click "Save Changes"
  Then the user row should reflect the updated permissions

Scenario: Delete User entry
  Given a user row exists
  When I click the delete icon on that row
  Then I should see a confirmation prompt
  When I confirm delete
  Then the user row should be removed from the table

Scenario: E2E - Add a user to an agent
  Given I am on the agent "New Package test" ACL tab
  When I click the "User" tab
  And I click "Add user"
  And I select user "minhnguyen"
  And I set "Chat with Agent" to "Allow"
  And I set "Update Agent Info" to "Deny"
  And I set "SUBMIT_TECHNICAL_NOTE" to "Deny"
  And I click "Add user"
  Then I should see the user in the User table with description "User can chat with agent"
