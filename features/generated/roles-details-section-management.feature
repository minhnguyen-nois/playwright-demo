Feature: Roles details section management

Background:
  Given I am logged in to the dashboard
  When I click on the "Roles" menu item in the left sidebar
  Then I should be redirected to the Roles page
  And there are existing roles in the Roles page
  When I click on a role row (e.g., "Admin")
  And a page of Admin role opens with "Info" tab is default

Scenario: User views roles details page
  Then I should see the role detail view for Admin role
  And I should see tabs "Info", "Users", and "Settings" in the left panel
  And the selected role name should be shown at the top of the left panel
  Then I should see the "Role Information" heading
  And I should see a "Name" input with the current role name
  And I should see a "Description" text area with the current description (or empty)
  And I should see a "Save Changes" button (disabled when nothing changed)

Scenario: User collapses and expands role detail side panel
  And I am viewing a role detail page
  When I click the collapse toggle on the side panel
  Then the side panel should collapse to show only the tab icons
  And the Info, Users, and Settings icons should remain visible
  When I click the expand toggle on the side panel
  Then the side panel should expand to show the role name and tab labels

Scenario: User updates role info
  When I edit the "Name" field or the "Description" field
  Then the "Save Changes" button should become enabled
  When I click on the "Save Changes" button
  Then the changes should be saved successfully
  And I should see a success message indication "Group updated successfully"

Scenario: User views Settings tab of role
  And I am viewing a role detail
  When I click on the "Settings" tab
  Then I should see the "Role Settings" heading
  And I should see a card titled "Deactivate this role"
  And I should see a "Deactivate Role" button

Scenario: User deactivates a role
  And I am viewing a role detail
  And the "Settings" tab is selected
  When I click on the "Deactivate Role" button
  Then I should see a confirmation modal titled "Deactivate Role"
  And I should see the question "Are you sure you want to deactivate this role?"
  And I should see a "Cancel" button and a red "Deactivate" button
  When I click on the "Deactivate" button in the modal
  Then the role should be deactivated successfully
  And I should see a success message indication "Group deactivated successfully"

Scenario: User cancels deactivation of a role
  And I am viewing a role detail
  And the "Settings" tab is selected
  When I click on the "Deactivate Role" button
  Then I should see the deactivation confirmation modal
  When I click on the "Cancel" button in the modal
  Then the modal should be closed
  And the role should remain active

Scenario: Activate a role
  And I am viewing a role detail
  And the "Settings" tab is selected
  When the selected role is deactivate
  Then I click on the "Activate Role" button
  Then I should see a confirmation modal titled "Activate Role"
  And I should see the question "Are you sure you want to activate this role?"
  And I should see a "Cancel" button and a red "Activate" button
  When I click on the "Activate" button in the modal
  Then the role should be activated successfully
  And I should see a success message indication "Group activated successfully"

Scenario: User cancels activation of a role
  And I am viewing a role detail
  And the "Settings" tab is selected
  When the selected role is deactivate
  Then I click on the "Activate Role" button
  Then I should see the activation confirmation modal
  When I click on the "Cancel" button in the modal
  Then the modal should be closed
  And the role should remain deactivate

Scenario: User views Users tab of role (empty state)
  And I am viewing a role detail
  When I click on the "Users" tab
  Then I should see the "Role Members" heading
  And I should see a search bar with placeholder "Search users"
  And I should see an "Add users to role" button in the header
  And if no users exist, I should see the empty state message "This table is empty."
  And I should see an empty-state button labeled "Add users to role"

Scenario: User opens Add users to role modal
  And I am viewing a role detail
  And I am on the "Users" tab
  When I click on the "Add users to role" button
  Then I should see a modal titled "Add users to role"
  And I should see a search input with placeholder "Search users..."
  And I should see "Cancel" and "Add Users" buttons

Scenario: User searches and selects a user in the Add users modal
  And the "Add users to role" modal is open
  When I type a name or email into the search input
  Then I should see matching user suggestions
  When I click on a suggested user
  Then the user should appear as a selected chip in the modal
  And the selection count should update (e.g., "1 user selected")

Scenario: User removes a selected user chip in the Add users modal
  And the "Add users to role" modal is open
  And a user is selected and shown as a chip
  When I click the "x" on the user chip
  Then the user should be removed from the selection
  And the selection count should update accordingly

Scenario: User adds selected users to the role
  And the "Add users to role" modal is open
  And one or more users are selected
  When I click the "Add Users" button
  Then the selected users should be added to the role
  And the modal should be closed
  And the Users tab list should reflect the new members

Scenario: User cancels adding users to role
  And the "Add users to role" modal is open
  When I click the "Cancel" button
  Then the modal should be closed
  And no users should be added to the role
