Feature: Users menu sidebar management

Background:
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  Then I should be redirected to the Users page
  And I should see the breadcrumbs "Pages / Users"
  And I should see the page title "Users"
  And I should see the "Users" menu item highlighted in the sidebar

Scenario: User views Users page elements with existing users
  Then I should see a search bar with placeholder "Search users..."
  And I should see an "Add User" button
  And I should see a table with columns "Email" and "Joined At"
  And I should see at least one user row displayed
  And each user row should show the email
  And each user row should show the joined date/time in the "Joined At" column

Scenario: Users page refreshes after successful addition
  And the "Add users to workspace" modal is open
  And one or more users are selected
  When I click on the "Add Users" button
  Then the selected users should be added successfully
  And the modal should be closed
  And I should see the newly added users' rows displayed in the Users table
  And the table should show the new users' "Email"
  And the table should show the new users' "Joined At" date/time

Scenario: User removes a user from the workspace
  And I am viewing the Users page
  And there is a user row with a delete icon
  When I hover on the delete icon in a user row
  And I should see the message "Remove user from workspace"
  When I click on the delete icon in a user row
  Then I should see a confirmation modal titled "Remove user from workspace"
  And I should see the question "Are you sure you want to remove this user from the workspace?"
  And I should see a "Cancel" button and a red "Remove" button
  When I click on the "Remove" button in the modal
  Then the user should be removed successfully
  And the Users page list should reflect the removal

Scenario: User searches for users
  When I enter text in the search bar "minhnguyen@gmail.com"
  Then I should see user rows filtered based on the entered text

Scenario: User clears search filter
  When I clear the text in the search bar
  Then I should see all user rows displayed in the table
  And the search bar should return to its original placeholder

Scenario: User opens Add User
  When I click on the "Add User" button
  Then I should see a dialog or form to add a new user

Scenario: User views Add users to workspace modal
  When I have clicked on the "Add User" button
  Then I should see a modal titled "Add users to workspace"
  And I should see a search input with placeholder "Search users by name or email, or type email addresses"
  And I should see a "Selected Users" section showing "0 user" by default
  And I should see "Cancel" and "Add Users" buttons

Scenario: User searches and selects users in Add users modal
  And the "Add users to workspace" modal is open
  When I type a name or email into the search input
  Then I should see matching user suggestions
  When I click on a suggested user
  Then the user should appear in the Selected Users list
  And the selected count should increment from "0 user" accordingly

Scenario: User adds a valid email directly
  And the "Add users to workspace" modal is open
  When I type a valid email address into the search input
  Then I should see a suggestion like "Add user by email" with the typed email and an "Add" button
  When I click the "Add" button in the suggestion
  Then the email should be added to the Selected Users list with a default role dropdown
  And the selected count should increase accordingly
  And I should see a remove "x" control for that entry
  And I should see the role dropdown (e.g., default "Admin") for that entry

Scenario: User removes a selected user from the list
  And the "Add users to workspace" modal is open
  And a user is already in the Selected Users list
  When I click the remove "x" control for that user
  Then the user should be removed from the Selected Users list
  And the selected count should decrement accordingly

Scenario: User sees validation for invalid email
  And the "Add users to workspace" modal is open
  When I type an invalid email format into the search input then enter
  Then I should see an error message "Please enter a valid email address"
  And no new user should be added to the Selected Users list

Scenario: User cancels Add users modal
  And the "Add users to workspace" modal is open
  When I click on the "Cancel" button
  Then the modal should be closed
  And no users should be added

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

Scenario: E2E - Add multiple users to workspace with different roles
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  And I click on the "Add User" button
  Then the "Add users to workspace" modal is open
  When I type "user1@example.com" into the search input
  And I click the "Add" button in the suggestion
  Then "user1@example.com" should be added to the Selected Users list
  And the selected count should show "1 user"
  When I change the role dropdown for "user1@example.com" to "Editor"
  And I type "user2@example.com" into the search input
  And I click the "Add" button in the suggestion
  Then "user2@example.com" should be added to the Selected Users list
  And the selected count should show "2 users"
  When I change the role dropdown for "user2@example.com" to "Viewer"
  And I type "user3@example.com" into the search input
  And I click the "Add" button in the suggestion
  Then "user3@example.com" should be added to the Selected Users list
  And the selected count should show "3 users"
  And "user3@example.com" should have the default "Admin" role
  When I click on the "Add Users" button
  Then all three users should be added successfully
  And the modal should be closed
  And I should see "user1@example.com", "user2@example.com", and "user3@example.com" in the users table

Scenario: E2E - Add user by searching existing user
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  And I click on the "Add User" button
  Then the "Add users to workspace" modal is open
  When I type "john" into the search input
  Then I should see matching user suggestions (e.g., "John Doe - john.doe@example.com")
  When I click on a suggested user "John Doe"
  Then "John Doe" should appear in the Selected Users list
  And the selected count should increment to "1 user"
  When I click on the "Add Users" button
  Then "John Doe" should be added successfully
  And the modal should be closed
  And I should see "john.doe@example.com" in the users table

Scenario: E2E - Add users, remove one, and verify final list
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  And I click on the "Add User" button
  Then the "Add users to workspace" modal is open
  When I type "alice@example.com" into the search input
  And I click the "Add" button
  And I type "bob@example.com" into the search input
  And I click the "Add" button
  And I type "charlie@example.com" into the search input
  And I click the "Add" button
  Then the selected count should show "3 users"
  When I click the remove "x" control for "bob@example.com"
  Then "bob@example.com" should be removed from the Selected Users list
  And the selected count should decrement to "2 users"
  When I click on the "Add Users" button
  Then "alice@example.com" and "charlie@example.com" should be added successfully
  And the modal should be closed
  And I should see "alice@example.com" and "charlie@example.com" in the users table
  And I should not see "bob@example.com" in the users table

Scenario: E2E - Attempt to add invalid email, then add valid email
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  And I click on the "Add User" button
  Then the "Add users to workspace" modal is open
  When I type "invalid-email" into the search input
  Then I should see an error message "Please enter a valid email address"
  And no new user should be added to the Selected Users list
  When I type "valid@example.com" into the search input
  Then I should see a suggestion like "Add user by email" with "valid@example.com"
  And the error message should disappear
  When I click the "Add" button in the suggestion
  Then "valid@example.com" should be added to the Selected Users list
  And the selected count should show "1 user"
  When I click on the "Add Users" button
  Then "valid@example.com" should be added successfully
  And I should see "valid@example.com" in the users table

Scenario: E2E - Cancel adding users and verify no changes
  Given I am logged in to the dashboard
  When I click on the "Users" menu item in the left sidebar
  And I note the current number of users in the table
  And I click on the "Add User" button
  Then the "Add users to workspace" modal is open
  When I type "cancelled@example.com" into the search input
  And I click the "Add" button
  Then "cancelled@example.com" should be in the Selected Users list
  When I click the "Cancel" button
  Then the modal should be closed
  And no users should be added
  And the number of users in the table should remain the same
  And "cancelled@example.com" should not appear in the users table
