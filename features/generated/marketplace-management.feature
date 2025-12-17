Feature: Marketplace management

Background: User is logged in and navigates to Marketplace page
  Given I am logged in to the dashboard
  When I click on the "Marketplace" menu item in the left sidebar
  Then I should be redirected to the Marketplace page
  And I should see the breadcrumbs "Pages / Marketplace"
  And I should see the page title "Marketplace"
  And I should see the "Marketplace" menu item highlighted in the sidebar

Scenario: User views Marketplace page elements
  Then I should see a search bar with placeholder "Search packages..."
  And I should see category filters for "All", "AI", "Logistics", "Tool", "Websearch"
  And I should see package cards with name, type badge, visibility badge (e.g., Public), description, tags, and "Add to Workspace" button

Scenario: User views package card details
  And there is a package card named "Web Search Tool 3"
  Then I should see the package name on the card
  And I should see the type badge (e.g., TOOL or USECASE)
  And I should see visibility badge "Public"
  And I should see description text
  And I should see category tags (e.g., websearch)
  And I should see the "Add to Workspace" button

Scenario: User opens Add To Workspace modal
  When I click on the "Add to Workspace" button on a package card
  Then I should see a modal titled "Add To Workspace"
  And I should see an input labeled "Name" prefilled with the package name
  And I should see "Cancel" and "Confirm" buttons
  And I should see a close "X" button

Scenario: User cancels Add To Workspace
  And the "Add To Workspace" modal is open
  When I click on the "Cancel" button
  Then the modal should close
  And no installation should start

Scenario: User confirms Add To Workspace
  And the "Add To Workspace" modal is open
  When I click on the "Confirm" button
  Then installation should start (showing "Installing" state)
  And I should see progress or a spinner
  And the "Confirm" button should be disabled or replaced with progress

Scenario: User sees install success notification
  And installation completes successfully
  Then I should see a toast "Package installed successfully"
  And I should see a warning toast to configure credentials if required
  And the modal should close

Scenario: User filters by Logistics category
  When I click on the "Logistics" filter
  Then I should see only packages tagged "Logistics"
  And there are exist packages belongs to "Logistics", it should be visible
  And no non-Tool packages should be visible
  And if there are no cards packages, I should see "No packages found"

Scenario: User filters by Tool category
  When I click on the "Tool" filter
  Then I should see only packages tagged "Tool"
  And there are exist packages belongs to "Tool", it should be visible
  And no non-Tool packages should be visible
  And if there are no cards packages, I should see "No packages found"

Scenario: User filters by Websearch category
  When I click on the "Websearch" filter
  Then I should see only packages tagged "Websearch"
  And there are exist packages belongs to "Websearch", it should be visible
  And no non-Tool packages should be visible
  And if there are no cards packages, I should see "No packages found"

Scenario: User filters by All category
  When I click on the "All" filter
  Then all packages should be displayed regardless of category
  And previously applied category filters should be cleared

Scenario: User combines multiple filters sequentially
  When I click on the "Tool" filter
  And I click on the "Websearch" filter
  Then I should see packages that satisfy both Tool and Websearch tags if supported
  And if there are no packages match the selected filters, I should see the message "No packages found"

Scenario: User searches for packages
  When I type "Web Search" in the search bar
  Then I should see packages whose names or descriptions match "Web Search"
  And non-matching packages should be hidden

Scenario: User combines search and filter
  When I type "test" in the search bar
  And I click on the "Tool" filter
  Then I should see only packages tagged "Tool" whose name/description includes "test"
  And other packages should be hidden
