Feature: API Keys - End-to-End Flows

Scenario: E2E - Complete flow to create a new API key from empty state
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  Then I should be redirected to the API Keys page
  And I should see the breadcrumbs "Pages / API Keys"
  And I should see the page title "API Keys"
  And I should see the empty state message "This table is empty."
  And I should see the message "Get started by creating new items"
  When I click on the "+ Add API Key" button in the empty state
  Then I should see a modal dialog titled "Create New API Key"
  And I should see the subtitle "Create a new API key with specific permissions and restrictions"
  When I enter "Production API Key" in the "Name *" field
  And I select a future date "12/11/2026 06:05 PM" in the "Expires At *" field using the date picker
  And I select the "FULL CONTROL" permission option
  And I enter "google.com" in the "Allowed Domains" field
  And I enter "1.1.1.1" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And the modal should be closed
  And the empty state should disappear
  And I should see the new API key "Production API Key" in the API Keys table
  And the API key should show "FULL_CONTROL" in the Permissions column
  And the API key should show "google.com" in the Domains column
  And the API key should show "1.1.1.1" in the IP Addresses column
  And the API key should show "Active" status in a green pill-shaped label
  And the API key should show the created date in the Created Date column
  And the API key should show the expiration date in the Expires At column

Scenario: E2E - Create multiple API keys with different configurations
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "+ Add API Key" button
  And I enter "Production Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "production.com" in the "Allowed Domains" field
  And I enter "192.168.1.1" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then "Production Key" should be created successfully
  When I click on the "+ Add API Key" button
  And I enter "Staging Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "CHAT WITH AGENT" permission option
  And I leave the "Allowed Domains" field empty
  And I leave the "Allowed IP Addresses" field empty
  And I click on the "Create API Key" button
  Then "Staging Key" should be created successfully
  When I click on the "+ Add API Key" button
  And I enter "Development Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "dev.example.com" in the "Allowed Domains" field
  And I enter "10.0.0.0/24" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then "Development Key" should be created successfully
  When I view the API Keys table
  Then I should see all three API keys: "Production Key", "Staging Key", and "Development Key"
  And each API key should display with its respective configuration
  And "Production Key" should show "FULL_CONTROL" permission
  And "Staging Key" should show "CHAT WITH AGENT" or "CHAT_WITH_AGENT" permission
  And "Development Key" should show "FULL_CONTROL" permission

Scenario: E2E - Create API key, search for it, verify, then delete
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "+ Add API Key" button
  And I enter "Searchable Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "CHAT WITH AGENT" permission option
  And I click on the "Create API Key" button
  Then "Searchable Key" should be created successfully
  When I enter "Searchable" in the search bar
  Then I should see "Searchable Key" in the search results
  And I should not see other API keys that don't match
  When I clear the search input
  Then all API keys should be displayed again
  And I should see "Searchable Key" in the list
  When I click on the delete icon for "Searchable Key"
  And I click on the "Delete" button in the confirmation modal
  Then "Searchable Key" should be deleted successfully
  And it should no longer appear in the API Keys table

Scenario: E2E - Create API key with multiple domains and IPs, verify all displayed
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "+ Add API Key" button
  And I enter "Multi-Config Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "google.com, example.com, test.com" in the "Allowed Domains" field
  And I enter "192.168.1.1, 10.0.0.1, 172.16.0.0/16" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And I should see "Multi-Config Key" in the API Keys table
  And the Domains column should show all three domains in separate blue pill-shaped labels
  And the IP Addresses column should show all three IP addresses/CIDR in separate purple pill-shaped labels

Scenario: E2E - Create API key, attempt invalid input, correct it, and create
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "+ Add API Key" button
  Then the "Create New API Key" modal is open
  When I leave the "Name *" field empty
  And I select a future date in the "Expires At *" field
  And I select the "CHAT WITH AGENT" permission option
  And I click on the "Create API Key" button
  Then I should see a validation message for the name field
  And the API key should not be created
  When I enter "Valid Key Name" in the "Name *" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And I should see "Valid Key Name" in the API Keys table

Scenario: E2E - Create API key without restrictions, verify all domains and IPs allowed
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "+ Add API Key" button
  And I enter "Unrestricted Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I leave the "Allowed Domains" field empty
  And I leave the "Allowed IP Addresses" field empty
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And I should see "Unrestricted Key" in the API Keys table
  And the Domains column should indicate that all domains are allowed
  And the IP Addresses column should indicate that all IP addresses are allowed

Scenario: E2E - Create, verify, and delete multiple API keys in sequence
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I create an API key named "Key 1" with "CHAT WITH AGENT" permission
  Then "Key 1" should be created successfully
  When I create an API key named "Key 2" with "FULL CONTROL" permission
  Then "Key 2" should be created successfully
  When I create an API key named "Key 3" with "CHAT WITH AGENT" permission
  Then "Key 3" should be created successfully
  When I view the API Keys table
  Then I should see all three API keys in the table
  When I click on the delete icon for "Key 1"
  And I click on the "Delete" button
  Then "Key 1" should be deleted
  When I click on the delete icon for "Key 2"
  And I click on the "Delete" button
  Then "Key 2" should be deleted
  When I view the API Keys table
  Then I should only see "Key 3" in the table
  And "Key 1" and "Key 2" should not appear

Scenario: E2E - Complete workflow: Create, search, view details, and manage API keys
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "+ Add API Key" button
  And I enter "Workflow Test Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "workflow.com" in the "Allowed Domains" field
  And I enter "192.168.1.100" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then "Workflow Test Key" should be created successfully
  When I enter "Workflow" in the search bar
  Then I should see "Workflow Test Key" in the search results
  When I clear the search input
  Then all API keys should be displayed
  When I verify "Workflow Test Key" details in the table
  Then I should see "FULL_CONTROL" in the Permissions column
  And I should see "workflow.com" in the Domains column
  And I should see "192.168.1.100" in the IP Addresses column
  And I should see "Active" status
  When I click on the delete icon for "Workflow Test Key"
  And I click on the "Cancel" button in the confirmation modal
  Then "Workflow Test Key" should remain in the table
  When I click on the delete icon for "Workflow Test Key" again
  And I click on the "Delete" button
  Then "Workflow Test Key" should be deleted successfully

Scenario: E2E - Create API key, verify date format in table
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "+ Add API Key" button
  And I enter "Date Format Key" in the "Name *" field
  And I select a specific date "12/11/2026 06:05 PM" in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And I should see "Date Format Key" in the API Keys table
  And the Created Date column should show the date in format "MM/DD/YYYY HH:MM AM/PM"
  And the Expires At column should show "12/11/2026 06:05 PM"
  And the date format should be consistent and readable

Scenario: E2E - Complete flow to edit an API key
  Given I am logged in to the dashboard
  And there is an existing API key named "Azure example"
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "Azure example" API key row or edit button
  Then I should see the "Edit API Key" modal or page
  And I should see the subtitle "Update API key settings and restrictions"
  And I should see "Azure example" in the Name field
  And I should see "Active" in green text in the Status field
  And I should see the created date in the Created At field
  And I should see the masked API key value
  When I update the "Name" field to "Updated Azure Key"
  And I update the expiration date to "01/15/2027 12:00 PM"
  And I add a new domain "newdomain.com" to the Allowed Origins
  And I add a new IP address "10.0.0.1" to the Allowed IP Addresses
  And I click on the "Update API Key" button
  Then all changes should be saved successfully
  And I should see a success message
  And the modal should be closed
  When I view the API Keys table
  Then I should see "Updated Azure Key" in the Name column
  And I should see "01/15/2027 12:00 PM" in the Expires At column
  And I should see "newdomain.com" in the Domains column
  And I should see "10.0.0.1" in the IP Addresses column

Scenario: E2E - Edit API key, verify permission cannot be changed
  Given I am logged in to the dashboard
  And there is an existing API key with "FULL CONTROL" permission
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the API key row
  Then I should see the "Edit API Key" interface
  And I should see "FULL CONTROL" selected in the Permissions section
  And I should see a note "Permissions cannot be changed after API key creation"
  When I attempt to select "CHAT WITH AGENT" permission
  Then the permission selection should be disabled or prevented
  Or I should see a message indicating permissions cannot be changed
  And "FULL CONTROL" should remain selected

Scenario: E2E - Edit API key, update expiration date, and verify
  Given I am logged in to the dashboard
  And there is an existing API key with expiration date "12/11/2026 06:05 PM"
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the API key row
  Then I should see the "Edit API Key" interface
  And I should see "12/11/2026 06:05 PM" in the Expires At field
  When I click on the calendar icon
  And I select a new date "03/20/2027 10:00 AM"
  And I click on the "Update API Key" button
  Then the expiration date should be updated successfully
  And the modal should be closed
  When I view the API Keys table
  Then the API key should show "03/20/2027 10:00 AM" in the Expires At column

Scenario: E2E - Edit API key, set to never expire
  Given I am logged in to the dashboard
  And there is an existing API key with an expiration date
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the API key row
  Then I should see the "Edit API Key" interface
  When I clear the "Expires At *" field
  And I click on the "Update API Key" button
  Then the API key should be updated to have no expiration
  And I should see a success message
  When I view the API Keys table
  Then the Expires At column should show "Never" or indicate no expiration

Scenario: E2E - Edit API key, manage domain tags
  Given I am logged in to the dashboard
  And there is an existing API key with domain "google.com"
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the API key row
  Then I should see the "Edit API Key" interface
  And I should see "google.com" as a domain tag
  When I click on the "x" icon on the "google.com" tag
  Then the "google.com" tag should be removed
  When I enter "example.com" in the Allowed Origins (Domains) input field
  And I confirm the input
  Then "example.com" should appear as a new tag
  When I enter "test.com" in the Allowed Origins (Domains) input field
  And I confirm the input
  Then "test.com" should appear as a new tag
  When I click on the "Update API Key" button
  Then the changes should be saved successfully
  When I view the API Keys table
  Then I should see "example.com" and "test.com" in the Domains column
  And I should not see "google.com" in the Domains column

Scenario: E2E - Edit API key, manage IP address tags
  Given I am logged in to the dashboard
  And there is an existing API key with IP address "1.1.1.1"
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the API key row
  Then I should see the "Edit API Key" interface
  And I should see "1.1.1.1" as an IP address tag
  When I click on the "x" icon on the "1.1.1.1" tag
  Then the "1.1.1.1" tag should be removed
  When I enter "192.168.1.1" in the Allowed IP Addresses input field
  And I confirm the input
  Then "192.168.1.1" should appear as a new tag
  When I enter "192.168.1.0/24" in the Allowed IP Addresses input field
  And I confirm the input
  Then "192.168.1.0/24" should appear as a new tag
  When I click on the "Update API Key" button
  Then the changes should be saved successfully
  When I view the API Keys table
  Then I should see "192.168.1.1" and "192.168.1.0/24" in the IP Addresses column
  And I should not see "1.1.1.1" in the IP Addresses column

Scenario: E2E - Edit API key, update name, and verify changes
  Given I am logged in to the dashboard
  And there is an existing API key named "Old Key Name"
  When I click on the "API Keys" menu item in the left sidebar
  And I click on the "Old Key Name" API key row
  Then I should see the "Edit API Key" interface
  And I should see "Old Key Name" in the Name field
  When I update the "Name" field to "New Key Name"
  And I click on the "Update API Key" button
  Then the name should be updated successfully
  And the modal should be closed
  When I view the API Keys table
  Then I should see "New Key Name" in the Name column
  And "Old Key Name" should no longer appear
