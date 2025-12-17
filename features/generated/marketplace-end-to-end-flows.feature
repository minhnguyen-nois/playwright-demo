Feature: Marketplace - End-to-End Flows

Scenario: E2E - Browse marketplace and open add-to-workspace
  Given I am logged in to the dashboard
  When I click on the "Marketplace" menu item in the left sidebar
  Then I should see package cards listed
  When I click on "Add to Workspace" for "Imported Web Search Tool"
  Then I should see the "Add To Workspace" modal with Name prefilled as "Imported Web Search Tool"
  And I should see "Cancel" and "Confirm" buttons

Scenario: E2E - Confirm add-to-workspace and sucessfully install
  Given the "Add To Workspace" modal is open for "New Package test"
  When I click on "Confirm"
  Then I should see an installing state or spinner
  And the "Confirm" button should be disabled or show progress "Installing..."
  When the installation completes successfully
  Then I should see a toast "Package installed successfully"
  And I should see a warning toast "Before using this tool, please configure its credentials (e.g., username and password)."
  And the modal should close
  When I navigate to the "Integrations" menu item
  Then I should see an integration card named "New Package test"
  And the card should show type badge (e.g., TOOL), "Last Updated" text, and actions "View Details" and "Delete"

Scenario: E2E - Add and install package via filtered view
  Given I am on the Marketplace page
  When I click on the "Logistics" filter
  And I click on "Add to Workspace" for "New Package test"
  And I click "Confirm" in the "Add To Workspace" modal
  Then I should see an installing state
  When installation completes
  Then I should see "Package installed successfully" toast
  When I navigate to the "Integrations" menu item
  Then I should see an integration card named "New Package test"
  And the card should show type badge (e.g., TOOL), "Last Updated" text, and actions "View Details" and "Delete"

Scenario: E2E - Install package and verify it appears in Integrations
  Given I am on the Marketplace page
  When I click on "Add to Workspace" for "Web Search Tool 2"
  And I click "Confirm"
  Then installation should start
  When installation completes
  Then I should see "Package installed successfully" toast
  When I navigate to the "Integrations" menu item
  Then I should see an integration card named "Web Search Tool 2"
  And the card should show type badge (e.g., TOOL), "Last Updated" text, and actions "View Details" and "Delete"

Scenario: E2E - Install package and verify it appears in Agents
  Given I am on the Marketplace page
  When I click on "Add to Workspace" for "New Package test"
  And I click "Confirm"
  Then installation should start
  When installation completes
  Then I should see "Package installed successfully" toast
  When I click on the Agents menu on the side bar
  Then I should see an agent card named "New Package test"
  And the card should show type badge (e.g., Specialist), "Ready" status, "Last Updated" text, and "Chat with Agent" button
