Feature: Feedback management

Background:
  Given I am logged in to the dashboard
  When I click on the "Feedbacks" menu item in the left sidebar
  Then I should be redirected to the Feedbacks page
  And I should see the breadcrumbs "Pages / Feedbacks"
  And I should see the page title "Feedbacks"
  And I should see the "Feedbacks" menu item highlighted in the sidebar

Scenario: User views Feedbacks page elements (Empty State)
  Then I should see a search bar with placeholder "Search feedbacks"
  And I should see a filter dropdown titled "Type"
  And I should see a filter dropdown titled "Status"
  And the table should show the empty state message "This table is empty."
  And the table should show the message "No items found"

Scenario: User searches for feedback
  When I enter text in the search bar "Search feedbacks"
  Then I should see feedback rows filtered based on the entered text

Scenario: User views Type filter options
  When I click on the "Type" filter dropdown
  Then I should see the option "Contribute"
  And I should see the option "Dislike"

Scenario: User views Status filter options
  When I click on the "Status" filter dropdown
  Then I should see the option "Pending"
  And I should see the option "Approved"
  And I should see the option "Rejected"

Scenario: User filters by Type
  When I select the "Contribute" option from the "Type" filter
  Then I should see feedback rows updated to show only "Contribute" types
  Then I clear the filter and select "Dislike" option from the "Type" filter
  And I should see feedback rows updated to show only "Dislike" types

Scenario: User filters by Status
  When I select the "Approved" option from the "Status" filter
  Then I should see feedback rows updated to show only "Approved" status

Scenario: User selects multiple Status filters
  And I am on the Feedbacks page
  When I click on the "Status" filter dropdown
  And I select the "Pending" option
  And I select the "Approved" option
  Then the "Status" filter label should reflect that multiple options are selected
  And I should see feedback rows filtered to show items that are either "Pending" or "Approved"
  And I should not see any items with the "Rejected" status in the results

Scenario: User uses multiple filters (Type and Status)
  And I am on the Feedbacks page
  When I select the "Contribute" option from the "Type" filter
  And I select the "Pending" option from the "Status" filter
  Then I should see feedback rows filtered to show only "Contribute" types that are "Pending"

Scenario: User uses multiple filters and searches simultaneously
  And I am on the Feedbacks page
  When I enter text in the search bar "Search feedbacks..."
  And I select the "Dislike" option from the "Type" filter
  And I select the "Approved" option from the "Status" filter
  Then I should see feedback rows that match the search text
  And the results should further be filtered to only show "Dislike" types that are "Approved"

Scenario: User clears one filter while another filter is active
  And the current feedback rows are filtered by "Type" (e.g., "Contribute")
  And the current feedback rows are also filtered by "Status" (e.g., "Pending")
  When I clear the selection in the "Status" filter (selecting "All" or unchecking the box)
  Then the feedback rows should only be filtered by the active "Type" filter ("Contribute")
  And I should see all statuses (Pending, Approved, Rejected) for the "Contribute" type

Scenario: User clears all filters
  And the search bar contains text
  And the "Type" filter is set to "Contribute"
  And the "Status" filter is set to "Pending"
  When I clear the text in the search bar
  And I reset the "Type" filter to "All"
  And I reset the "Status" filter to "All"
  Then I should see all feedback rows displayed in the table
