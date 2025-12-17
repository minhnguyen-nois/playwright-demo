Feature: Create a new role

Background:
  Given I am logged in to the dashboard
  When I click on the "Roles" menu item in the left sidebar
  And I click on the "Create new role" button in the action bar
  Then the "Create New Role" modal is open

Scenario: User views Create New Role modal elements
  Then I should see a close "X" button in the modal
  And I should see a "Role Name " input with placeholder "Enter role name"
  And I should see a "Description" text area with placeholder "Describe the purpose of this role"
  And I should see a "Cancel" button
  And I should see a "Create Role" button

Scenario: E2E - Create role from empty state
  When I click on the "Create new role" button in the empty state
  Then I should see a dialog or form to create a new role
  When I enter "Admin" in the "Role Name *" field
  And I enter "Administrator role with full access" in the "Description" field
  And I click on the "Create Role" button
  Then the role should be created successfully
  And the empty state should disappear
  And I should see "Admin" in the roles table
  And the table should display with columns "Name", "Description", "Members", and "Created Date"

Scenario: E2E - Create multiple roles and verify organization
  And I enter "Role A" in the "Role Name *" field
  And I enter "Description A" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Role A" should be created successfully
  When I click on the "Create new role" button in the action bar
  And I enter "Role B" in the "Role Name *" field
  And I enter "Description B" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Role B" should be created successfully
  When I click on the "Create new role" button in the action bar
  And I enter "Role C" in the "Role Name *" field
  And I enter "Description C" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Role C" should be created successfully
  When I view the roles table
  Then I should see all three roles: "Role A", "Role B", and "Role C"
  And each role should display in the table with their respective descriptions
  And each role should show "No members" in the Members column

Scenario: E2E - Create role, view details, and update information
  And I enter "Editor" in the "Role Name *" field
  And I enter "Can edit content" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Editor" should be created successfully
  When I click on the "Editor" role row
  Then I should see the role detail view for "Editor"
  And I should see tabs "Info", "Users", and "Settings" in the left panel
  And the selected role name "Editor" should be shown at the top of the left panel
  And the "Info" tab should be selected by default
  And I should see the "Role Information" heading
  And I should see "Editor" in the "Name" input field
  And I should see "Can edit content" in the "Description" text area
  When I update the "Name" field to "Content Editor"
  And I update the "Description" field to "Can edit and publish content"
  Then the "Save Changes" button should become enabled
  When I click on the "Save Changes" button
  Then the changes should be saved successfully
  And I should see a confirmation or success indication
  And the role name in the left panel should update to "Content Editor"
  When I navigate back to the roles list
  Then I should see "Content Editor" in the roles table
  And the description should show "Can edit and publish content"

Scenario: E2E - Create role, add multiple users, remove one, and verify
  And I enter "Tester" in the "Role Name *" field
  And I enter "Quality assurance team" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Tester" should be created successfully
  When I click on the "Tester" role row
  And I click on the "Users" tab
  And I click on the "Add users to role" button
  Then the "Add users to role" modal is open
  When I type "alice" into the search input
  And I click on a suggested user "Alice Brown"
  And I type "bob" into the search input
  And I click on a suggested user "Bob Wilson"
  And I type "charlie" into the search input
  And I click on a suggested user "Charlie Davis"
  Then the selection count should show "3 users selected"
  When I click the "x" on "Bob Wilson" chip
  Then "Bob Wilson" should be removed from the selection
  And the selection count should update to "2 users selected"
  When I click the "Add Users" button
  Then "Alice Brown" and "Charlie Davis" should be added to the role
  And the modal should be closed
  And I should see "Alice Brown" and "Charlie Davis" in the role members list
  And I should not see "Bob Wilson" in the list
  When I navigate back to the roles list
  Then the "Tester" role should show "2 members" in the Members column

Scenario: User cancels creating a new role
  When I click on the "Cancel" button in the modal
  Then the modal should be closed
  And no new role should be created

Scenario: User closes the create role modal with X
  When I click on the "X" close button in the modal
  Then the modal should be closed
  And no new role should be created

Scenario: Validate when role name is missing
  When I click on the "Create Role" button without entering a role name
  Then I should see a validation error ""Please fill in this fields."" for the required role name
  And the role should not be created
