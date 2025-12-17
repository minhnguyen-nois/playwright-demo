Feature: Create a new role and a new user - E2E flow

Scenario: E2E - Create role, add users, and verify membership
  Given I am logged in to the dashboard
  When I click on the "Roles" menu item in the left sidebar
  And I click on the "Create new role" button in the action bar
  And I enter "Developer" in the "Role Name *" field
  And I enter "Software development team role" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Developer" should be created successfully
  When I click on the "Developer" role row
  Then I should see the role detail view for "Developer"
  When I click on the "Users" tab
  Then I should see the "Role Members" heading
  And I should see a search bar with placeholder "Search users..."
  And I should see an "Add users to role" button in the header
  And I should see the empty state message "This table is empty."
  When I click on the "Add users to role" button
  Then I should see a modal titled "Add users to role"
  And I should see a search input with placeholder "Search users by name or email..."
  When I type "john.doe" into the search input
  Then I should see matching user suggestions
  When I click on a suggested user "John Doe"
  Then the user should appear as a selected chip in the modal
  And the selection count should update to "1 user selected"
  When I type "jane.smith" into the search input
  And I click on a suggested user "Jane Smith"
  Then the selection count should update to "2 users selected"
  When I click the "Add Users" button
  Then the selected users should be added to the role
  And the modal should be closed
  And the Users tab list should reflect the new members
  And I should see "John Doe" and "Jane Smith" in the role members list
  When I navigate back to the roles list
  Then the "Developer" role should show "2 members" in the Members column

Scenario: E2E - Complete flow to add a new user to workspace
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  Then I should be redirected to the Users page
  And I should see the breadcrumbs "Pages / Users"
  And I should see the page title "Users"
  And I should see an "Add User" button
  When I click on the "Add User" button
  Then I should see a modal titled "Add users to workspace"
  And I should see a search input with placeholder "Search users by name or email, or type email addresses.."
  And I should see a "Selected Users" section showing "0 user" by default
  When I type "newuser@example.com" into the search input
  Then I should see a suggestion like "Add user by email" with "newuser@example.com" and an "Add" button
  When I click the "Add" button in the suggestion
  Then "newuser@example.com" should be added to the Selected Users list
  And the selected count should show "1 user"
  And I should see a remove "x" control for that entry
  And I should see the role dropdown with default "Admin" for that entry
  When I click on the "Add Users" button
  Then the selected user should be added successfully
  And the modal should be closed
  And I should see "newuser@example.com" in the users table
  And the user should show the joined date/time in the "Joined At" column

Scenario: E2E - Create role, add users to workspace, then assign users to role
  Given I am logged in to the dashboard
  When I click on the "Roles" menu item in the left sidebar
  And I click on the "Create new role" button in the action bar
  And I enter "Team Lead" in the "Role Name *" field
  And I enter "Leads team members" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Team Lead" should be created successfully
  When I click on the "Users" menu item in the left sidebar
  And I click on the "Add User" button
  And I type "teamlead1@example.com" into the search input
  And I click the "Add" button
  And I click on the "Add Users" button
  Then "teamlead1@example.com" should be added successfully
  When I click on the "Roles" menu item in the left sidebar
  And I click on the "Team Lead" role row
  And I click on the "Users" tab
  And I click on the "Add users to role" button
  And I type "teamlead1" into the search input
  And I click on the suggested user "teamlead1@example.com"
  And I click the "Add Users" button
  Then "teamlead1@example.com" should be added to the "Team Lead" role
  And the Users tab should show "teamlead1@example.com" as a member
  When I navigate back to the roles list
  Then the "Team Lead" role should show "1 member" in the Members column

Scenario: E2E - Create multiple roles, add users, and assign users to different roles
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  And I click on the "Add User" button
  And I type "user1@example.com" into the search input
  And I click the "Add" button
  And I type "user2@example.com" into the search input
  And I click the "Add" button
  And I click on the "Add Users" button
  Then both users should be added successfully
  When I click on the "Roles" menu item in the left sidebar
  And I click on the "Create new role" button in the action bar
  And I enter "Role 1" in the "Role Name *" field
  And I click on the "Create Role" button
  Then the role "Role 1" should be created successfully
  When I click on the "Create new role" button in the action bar
  And I enter "Role 2" in the "Role Name *" field
  And I click on the "Create Role" button
  Then the role "Role 2" should be created successfully
  When I click on the "Role 1" role row
  And I click on the "Users" tab
  And I click on the "Add users to role" button
  And I type "user1" into the search input
  And I click on "user1@example.com"
  And I click the "Add Users" button
  Then "user1@example.com" should be added to "Role 1"
  When I click on the "Role 2" role row
  And I click on the "Users" tab
  And I click on the "Add users to role" button
  And I type "user2" into the search input
  And I click on "user2@example.com"
  And I click the "Add Users" button
  Then "user2@example.com" should be added to "Role 2"
  When I navigate back to the roles list
  Then "Role 1" should show "1 member"
  And "Role 2" should show "1 member"

Scenario: E2E - Create role, add users to role, update role info, and verify all changes
  Given I am logged in to the dashboard
  When I click on the "Roles" menu item in the left sidebar
  And I click on the "Create new role" button in the action bar
  And I enter "Initial Role" in the "Role Name *" field
  And I enter "Initial description" in the "Description" field
  And I click on the "Create Role" button
  Then the role "Initial Role" should be created successfully
  When I click on the "Initial Role" role row
  And I click on the "Users" tab
  And I click on the "Add users to role" button
  And I type "member1@example.com" into the search input
  And I click the "Add" button
  And I click the "Add Users" button
  Then "member1@example.com" should be added to the role
  When I click on the "Info" tab
  And I update the "Name" field to "Updated Role"
  And I update the "Description" field to "Updated description with members"
  And I click on the "Save Changes" button
  Then the changes should be saved successfully
  When I click on the "Users" tab
  Then I should still see "member1@example.com" in the role members list
  When I navigate back to the roles list
  Then I should see "Updated Role" in the roles table
  And the description should show "Updated description with members"
  And the Members column should show "1 member"

Scenario: E2E - Create role, add multiple users, search users in role, and verify
  Given I am logged in to the dashboard
  When I click on the "Roles" menu item in the left sidebar
  And I click on the "Create new role" button in the action bar
  And I enter "Searchable Role" in the "Role Name *" field
  And I click on the "Create Role" button
  Then the role "Searchable Role" should be created successfully
  When I click on the "Searchable Role" role row
  And I click on the "Users" tab
  And I click on the "Add users to role" button
  And I type "alice@example.com" into the search input
  And I click the "Add" button
  And I type "bob@example.com" into the search input
  And I click the "Add" button
  And I type "charlie@example.com" into the search input
  And I click the "Add" button
  And I click the "Add Users" button
  Then all three users should be added to the role
  And I should see "alice@example.com", "bob@example.com", and "charlie@example.com" in the role members list
  When I enter "alice" in the search bar in the Users tab
  Then I should see "alice@example.com" in the filtered results
  And I should not see "bob@example.com" or "charlie@example.com"
  When I clear the search input
  Then all three users should be displayed again
