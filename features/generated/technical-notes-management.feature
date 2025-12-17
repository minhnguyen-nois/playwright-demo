Feature: Technical Notes Management

Background:
  Given I am logged in to the dashboard
  When I click on the "Technical Notes" menu item in the left sidebar
  Then I should be redirected to the Technical Notes page
  And I should see the breadcrumbs "Pages / Technical Notes"
  And I should see the page title "Technical Notes"
  And I should see the "Technical Notes" menu item highlighted in the sidebar

Scenario: User views Technical Notes page elements (Empty State)
  Then I should see a search bar with placeholder "Search technical notes..."
  And I should see a filter dropdown titled "Status"
  And I should see the table with the empty state message "This table is empty."
  And I should see the message "No items found"

Scenario: User views Status filter when no options are available
  When I click on the "Status" filter dropdown
  Then I should see the text "No options available" in the dropdown

Scenario: User views Technical Notes list elements when notes exist
  And at least one Technical Note exists (e.g., has just been created via Agent Detail)
  Then I should see the search bar with placeholder "Search technical notes..."
  And I should see the "Status" filter dropdown
  And I should see a table with columns: "Question", "Answer", "Status", "Agent", "Created By", "Created Date", "Updated Date", and "Actions"

Scenario: User views newly created Technical Note details
  And a Technical Note exists in the list (e.g., the one created in Agent Expertise)
  Then I should see the Technical Note row displayed in the table
  And the row should show the "Question" (e.g., "HOW")
  And the row should show the "Answer" (e.g., "This is because")
  And the row should show the "Status" as "PENDING"
  And the row should show the "Agent" ID
  And the row should show the "Created By" ID
  And the row should show the "Created Date"
  And the row should show the "Updated Date"
  And the row should have an action control (e.g., a delete icon) under the "Actions" column

Scenario: User searches for a technical note
  When I enter text in the search bar "Search technical notes..."
  Then I should see technical note rows filtered based on the entered text

Scenario: User interacts with Status filter (No options)
  And I am on the Technical Notes page
  When I click on the "Status" filter dropdown
  Then I should see the text "No options available" in the dropdown
  And the list of technical notes should not be filtered
  When I click outside the "Status" filter dropdown
  Then the dropdown should be closed
  And the filter label should remain "All"

Scenario: User filters by Status (is available)
  And I am on the Feedbacks page
  When I select an option from the "Status" filter (e.g., "Approved")
  Then the "Status" filter label should display "Approved"
  And I should see feedback rows filtered to show only items with "Approved" status

Scenario: User clears Status filter on Feedbacks page
  And the current feedback rows are filtered by "Status" (e.g., "Approved")
  When I reset the "Status" filter to "All"
  Then the "Status" filter label should display "All"
  And the feedback rows should no longer be filtered by status

Scenario: User opens Technical Note Details modal for review
  And a Technical Note exists in the list
  When I click on the Technical notes row
  Then I should see the "Technical Note Details" modal
  And the modal title should be "Technical Note Details"
  And the modal should display the note's metadata: "Agent", "Status" (PENDING), "Created By", "Created Date", and "Updated Date"
  And the modal should display the "Question" and "Answer" fields (view-only or editable)
  And I should see the action buttons: "Approve" (Green) and "Reject" (Red)

Scenario: User approves a Technical Note
  And a Technical Note exists in the list
  And the "Technical Note Details" modal is open
  When I click the "Approve" button
  Then the Technical Note should be updated successfully
  And the modal should be closed
  And the Technical Notes list should update
  And the Status of that note in the list should change from "PENDING" to "APPROVED"

Scenario: User rejects a Technical Note
  And a Technical Note exists in the list
  And the "Technical Note Details" modal is open
  When I click the "Reject" button
  Then the Technical Note should be updated successfully
  And the modal should be closed
  And the Technical Notes list should update
  And the Status of that note in the list should change from "PENDING" to "REJECTED"

Scenario: User closes the Technical Note Details modal
  And the "Technical Note Details" modal is open
  When I click the close "x" button on the modal
  Then the modal should be closed
  And the Technical Note status should remain unchanged
