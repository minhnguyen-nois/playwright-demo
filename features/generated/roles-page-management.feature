Feature: Roles page management

Background:
  Given I am logged in to the dashboard
  When I click on the "Roles" menu item in the left sidebar
  Then I should be redirected to the Roles page
  And I should see the breadcrumbs "Pages / Roles"
  And I should see the page title "Roles"
  And I should see the "Roles" menu item highlighted in the sidebar

Scenario: User views Roles page when no roles exist
  Then I should see a search bar with placeholder "Search roles"
  And I should see the "Create new role" button in the action bar
  And no roles have been created
  Then I should see the empty state message "This table is empty."
  And I should see the message "Get started by creating new items"
  And I should see a prominent "Create new role" button in the empty state

Scenario: User views Roles page when roles exist
  And there are existing roles in the Roles page
  Then I should see a table with columns "Name", "Description", "Members", and "Created Date"
  And I should see role rows displayed in the table
  And each role row should show the role name, role description, members value, and created date
  And each role row should have a delete icon

Scenario: User searches for roles
  When I enter text in the search bar with "Admin"
  Then I should see search results filtered based on the entered text

Scenario: User creates a new role from action bar
  When I click on the "Create new role" button in the action bar
  Then I should see a dialog or form to create a new role

Scenario: User creates a new role from empty state
  And no roles have been created
  When I click on the "Create new role" button in the empty state
  Then I should see a dialog or form to create a new role

Scenario: User deletes a role using delete icon
  And there are existing roles in the Roles page
  When I click on the red trash can delete icon for a role
  Then I should see a confirmation dialog
  When I confirm the deletion
  Then the role should be deleted successfully
  And the role should no longer appear in the Roles table

Scenario: User cancels deleting a role
  And there are existing roles in the Roles page
  When I click on the red trash can delete icon for a role
  Then I should see a confirmation dialog
  When I cancel the deletion
  Then the role should remain in the Roles table
