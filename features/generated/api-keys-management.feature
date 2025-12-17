Feature: API Keys management

Background: User is logged in and navigates to API Keys page
  Given I am logged in to the dashboard
  When I click on the "API Keys" menu item in the left sidebar
  Then I should be redirected to the API Keys page
  And I should see the breadcrumbs "Pages / API Keys"
  And I should see the page title "API Keys"
  And I should see the "API Keys" menu item highlighted in the sidebar

Scenario: User views API Keys page elements
  Then I should see a search bar with placeholder "Search..."
  And I should see the "Add API Key" button in the action bar

Scenario: User views empty state when no API keys exist
  And no API keys have been created
  Then I should see the empty state message "This table is empty."
  And I should see the message "Get started by creating new items"
  And I should see a prominent "Add API Key" button in the empty stat

Scenario: User views API Keys page when API keys exist
  And there are existing API keys in the API Keys page
  Then I should see a table with columns "Name", "Created Date", "Expires At", "Status", "Domains", "IP Addresses", "Permissions", and "Actions"
  And I should see API key rows displayed in the table
  And each API key row should show the API key name
  And each API key row should show the created date
  And each API key row should show the expiration date
  And each API key row should show the status (e.g., "Active")
  And each API key row should show the allowed domains
  And each API key row should show the allowed IP addresses
  And each API key row should show the permissions
  And each API key row should have a delete icon in the Actions column

Scenario: User searches for API keys
  When I enter text in the search bar "Search..."
  Then I should see search results filtered based on the entered text

Scenario: User opens Create New API Key modal from action bar
  When I click on the "Add API Key" button in the action bar
  Then I should see a modal dialog titled "Create New API Key"
  And I should see the subtitle "Create a new API key with specific permissions and restrictions"
  And I should see a close "X" button in the top right corner of the modal

Scenario: User opens Create New API Key modal from empty state
  And no API keys have been created
  When I click on the "+ Add API Key" button in the empty state
  Then I should see a modal dialog titled "Create New API Key"
  And I should see the subtitle "Create a new API key with specific permissions and restrictions"

Scenario: User views Create New API Key modal elements
  And the "Create New API Key" modal is open
  Then I should see a "Name *" input field with placeholder "e.g., Production API Key, Development Key, etc."
  And I should see helper text "Give your API key a descriptive name to easily identify it later" below the Name field
  And I should see an "Expires At *" input field with placeholder "mm/dd/yyyy --:--"
  And I should see a calendar icon on the right side of the Expires At field
  And I should see helper text "Select when this API key should expire" below the Expires At field
  And I should see a "Permission *" section with radio button options
  And I should see the "CHAT WITH AGENT" radio option with description "Permission * chat with agent"
  And I should see the "FULL CONTROL" radio option with description "Permission * full control"
  And I should see helper text "Select one permission for this API key" below the Permission section
  And I should see an "Allowed Domains" input field with placeholder "e.g., example.com (optional)"
  And I should see helper text about domain format below the Allowed Domains field
  And I should see an "Allowed IP Addresses" input field with placeholder "e.g., 192.168.1.1 or 192.168.1.0/24 (optional)"
  And I should see helper text about IP address format below the Allowed IP Addresses field
  And I should see a "Cancel" button
  And I should see a "Create API Key" button

Scenario: User creates a new API key with minimal required fields
  And the "Create New API Key" modal is open
  When I enter "Production API Key" in the "Name *" field
  And I select a future date in the "Expires At *" field using the date picker
  And I select the "CHAT WITH AGENT" permission option
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And the modal should be closed
  And I should see the new API key "Production API Key" in the API Keys table
  And the empty state should disappear if it was visible

Scenario: User creates a new API key with all fields
  And the "Create New API Key" modal is open
  When I enter "Development Key" in the "Name *" field
  And I select a future date in the "Expires At *" field using the date picker
  And I select the "FULL CONTROL" permission option
  And I enter "example.com" in the "Allowed Domains" field
  And I enter "192.168.1.1" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And the modal should be closed
  And I should see the new API key "Development Key" in the API Keys table
  And the API key should show "FULL_CONTROL" in the Permissions column
  And the API key should show "example.com" in the Domains column
  And the API key should show "192.168.1.1" in the IP Addresses column

Scenario: User validation when API key name is missing
  And the "Create New API Key" modal is open
  And the "Name *" field is empty
  When I select a date in the "Expires At *" field
  And I select a permission option
  And I click on the "Create API Key" button
  Then I should see a validation message for the name field
  And the API key should not be created
  And the modal should remain open

Scenario: User validation when expiration date is missing
  And the "Create New API Key" modal is open
  When I enter "Test Key" in the "Name *" field
  And I leave the "Expires At *" field empty
  And I select a permission option
  And I click on the "Create API Key" button
  Then I should see a validation message for the expiration date field
  And the API key should not be created
  And the modal should remain open

Scenario: User validation when permission is not selected
  And the "Create New API Key" modal is open
  When I enter "Test Key" in the "Name *" field
  And I select a date in the "Expires At *" field
  And I do not select any permission option
  And I click on the "Create API Key" button
  Then I should see a validation message for the permission field
  And the API key should not be created
  And the modal should remain open

Scenario: User cancels creating a new API key
  And the "Create New API Key" modal is open
  When I enter "Cancelled Key" in the "Name *" field
  And I click on the "Cancel" button
  Then the modal should be closed
  And no API key should be created

Scenario: User closes Create New API Key modal using X button
  And the "Create New API Key" modal is open
  When I click on the "X" close button in the modal
  Then the modal should be closed
  And no API key should be created

Scenario: User creates API key with multiple domains
  And the "Create New API Key" modal is open
  When I enter "Multi-Domain Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "google.com, example.com, test.com" in the "Allowed Domains" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And I should see the API key with multiple domains displayed in the Domains colum

Scenario: User creates API key with CIDR notation IP address
  And the "Create New API Key" modal is open
  When I enter "CIDR Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "CHAT WITH AGENT" permission option
  And I enter "192.168.1.0/24" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And I should see "192.168.1.0/24" in the IP Addresses column

Scenario: User creates API key with IPv6 address
  And the "Create New API Key" modal is open
  When I enter "IPv6 Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "2001:0db8:85a3:0000:0000:8a2e:0370:7334" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And I should see the IPv6 address in the IP Addresses column

Scenario: User creates API key without optional fields
  And the "Create New API Key" modal is open
  When I enter "Simple Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "CHAT WITH AGENT" permission option
  And I leave the "Allowed Domains" field empty
  And I leave the "Allowed IP Addresses" field empty
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And the API key should show that all domains and IP addresses are allowed

Scenario: User views created API key details in table
  And there is an existing API key named "Azure example"
  When I view the API Keys table
  Then I should see "Azure example" in the Name column
  And I should see the created date in format "MM/DD/YYYY HH:MM AM/PM" in the Created Date column
  And I should see the expiration date in format "MM/DD/YYYY HH:MM AM/PM" in the Expires At column
  And I should see "Active" status displayed in a green pill-shaped label in the Status column
  And I should see domains displayed in blue pill-shaped labels in the Domains column
  And I should see IP addresses displayed in purple pill-shaped labels in the IP Addresses column
  And I should see permissions displayed in grey pill-shaped labels in the Permissions column
  And I should see a red trash can icon in the Actions column

Scenario: User deletes an API key
  And there are existing API keys in the API Keys page
  When I click on the delete icon (trash can) for an API key
  Then I should see a confirmation modal titled "Delete API Key"
  And I should see a warning icon (red triangle with exclamation mark)
  And I should see the message "Are you sure you want to delete this API key? This action cannot be undone."
  And I should see a "Cancel" button with white background
  And I should see a red "Delete" button
  And I should see a close "X" button in the top right corner of the modal
  When I click on the "Delete" button
  Then the API key should be deleted successfully
  And the modal should be closed
  And the API key should no longer appear in the API Keys table

Scenario: User cancels deleting an API key
  And there are existing API keys in the API Keys page
  When I click on the delete icon (trash can) for an API key
  Then I should see the delete confirmation modal
  When I click on the "Cancel" button
  Then the modal should be closed
  And the API key should remain in the API Keys table
  And no deletion should occur

Scenario: User closes delete confirmation modal using X button
  And there are existing API keys in the API Keys page
  When I click on the delete icon (trash can) for an API key
  Then I should see the delete confirmation modal
  When I click on the "X" close button in the modal
  Then the modal should be closed
  And the API key should remain in the API Keys table
  And no deletion should occur

Scenario: User views expired API key status
  And there is an API key that has passed its expiration date
  When I view the API Keys table
  Then I should see the expired API key with "Expired" status
  And the status should be displayed in an appropriate status label (not green)

Scenario: User searches for specific API key
  And there are multiple API keys in the API Keys page
  When I enter "Azure" in the search bar
  Then I should see only API keys matching "Azure" in the search results
  And I should not see other API keys that don't match

Scenario: User creates API key with www prefix in domain and verifies it's removed
  And the "Create New API Key" modal is open
  When I enter "WWW Test Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "www.example.com" in the "Allowed Domains" field
  And I click on the "Create API Key" button
  Then the API key should be created successfully
  And the domain should be displayed as "example.com" (without www prefix) in the Domains column

Scenario: User attempts to create API key with invalid domain format
  And the "Create New API Key" modal is open
  When I enter "Invalid Domain Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "FULL CONTROL" permission option
  And I enter "https://example.com" in the "Allowed Domains" field
  And I click on the "Create API Key" button
  Then I should see a validation error about invalid domain format
  Or the https:// prefix should be automatically removed
  And the API key should be created with "example.com" as the domain

Scenario: User attempts to create API key with invalid IP address format
  And the "Create New API Key" modal is open
  When I enter "Invalid IP Key" in the "Name *" field
  And I select a future date in the "Expires At *" field
  And I select the "CHAT WITH AGENT" permission option
  And I enter "999.999.999.999" in the "Allowed IP Addresses" field
  And I click on the "Create API Key" button
  Then I should see a validation error about invalid IP address format
  And the API key should not be created
  And the modal should remain open

Scenario: User creates API key with past expiration date
  And the "Create New API Key" modal is open
  When I enter "Past Date Key" in the "Name *" field
  And I select a past date in the "Expires At *" field
  And I select the "CHAT WITH AGENT" permission option
  And I click on the "Create API Key" button
  Then I should see a validation error about expiration date being in the past
  Or the API key should be created but immediately show as expired
  And the application should handle past dates appropriately

Scenario: User creates API key and verifies status is Active
  When I create a new API key with a future expiration date
  Then the API key should show "Active" status in the Status column
  And the status should be displayed in a green pill-shaped label

Scenario: User views API key with no domains restriction
  And there is an API key created without domain restrictions
  When I view the API Keys table
  Then the Domains column should show that all domains are allowed
  Or the column should be empty or show "All domains"

Scenario: User views API key with no IP address restriction
  And there is an API key created without IP address restrictions
  When I view the API Keys table
  Then the IP Addresses column should show that all IP addresses are allowed
  Or the column should be empty or show "All IPs"

Scenario: User opens Edit API Key interface
  And there is an existing API key named "Azure example"
  When I click on the "Azure example" API key row or edit button
  Then I should see a modal or page titled "Edit API Key"
  And I should see the subtitle "Update API key settings and restrictions"
  And I should see a close "X" button in the top right corner

Scenario: User views API Key Details section
  And I am viewing the Edit API Key interface for "Azure example"
  When I click on "Azure example" row
  Then I should see the " Edit API Key" details" section
  And I should see the "Name" field displaying "Azure example"
  And I should see the "Status" displaying "Active" in green text
  And I should see the "Created At" field displaying "12/11/2025 11:01 AM" (or the actual created date)
  And I should see the "API Key" field showing a partially masked value like "59JmKhCN����������������5700"
  And I should see an eye icon next to the API key field
  And I should see a copy icon next to the API key field
  And I should see helper text "Click the eye icon to reveal the full API key or copy to clipboard"

Scenario: User reveals the full API key using eye icon
  And I am viewing the Edit API Key interface
  And the API key is masked
  When I click on the eye icon
  Then the full API key should be revealed
  And the masked characters should be replaced with the actual API key value
  When I click on the eye icon again
  Then the API key should be masked again

Scenario: User copies API key to clipboard
  And I am viewing the Edit API Key interface
  When I click on the copy icon
  Then the API key should be copied to clipboard
  And I should see a success message or notification indicating the key was copied
  And the copied value should match the full API key value

Scenario: User attempts to change permission in Edit interface
  And I am viewing the Edit API Key interface
  And the current permission is "FULL CONTROL"
  When I attempt to select the "CHAT WITH AGENT" radio option
  Then the permission selection should be disabled or prevented
  Or I should see a message indicating permissions cannot be changed
  And the original permission should remain selected

Scenario: User updates expiration date in Edit interface
  And I am viewing the Edit API Key interface
  And the current expiration date is "12/11/2026 06:05 PM"
  When I click on the calendar icon
  And I select a new future date "01/15/2027 12:00 PM"
  And I click on the "Update API Key" button
  Then the expiration date should be updated successfully
  And I should see a success message or confirmation
  And the modal should be closed
  When I view the API Keys table
  Then the API key should show the updated expiration date "01/15/2027 12:00 PM" in the Expires At column

Scenario: User sets API key to never expire
  And I am viewing the Edit API Key interface
  When I clear the "Expires At *" field
  And I click on the "Update API Key" button
  Then the API key should be updated to have no expiration
  And I should see a success message
  When I view the API Keys table
  Then the Expires At column should show "Never" or indicate no expiration

Scenario: User removes a domain tag in Edit interface
  And I am viewing the Edit API Key interface
  And there is a domain tag "google.com" displayed
  When I click on the "x" icon on the "google.com" tag
  Then the "google.com" tag should be removed
  And the domain should no longer be displayed
  When I click on the "Update API Key" button
  Then the changes should be saved successfully
  And the domain should be removed from the API key

Scenario: User adds a new domain in Edit interface
  And I am viewing the Edit API Key interface
  When I enter "example.com" in the Allowed Origins (Domains) input field
  And I press Enter or confirm the input
  Then "example.com" should appear as a new tag/chip
  And I should see an "x" icon on the new tag to remove it
  When I click on the "Update API Key" button
  Then the new domain should be saved successfully
  And I should see "example.com" in the Domains column of the API Keys table

Scenario: User adds multiple domains in Edit interface
  And I am viewing the Edit API Key interface
  When I enter "test.com" in the Allowed Origins (Domains) input field
  And I confirm the input
  And I enter "demo.com" in the Allowed Origins (Domains) input field
  And I confirm the input
  Then I should see both "test.com" and "demo.com" as separate tags
  When I click on the "Update API Key" button
  Then all domains should be saved successfully
  And I should see all domains displayed in the Domains column

Scenario: User removes all domains in Edit interface
  And I am viewing the Edit API Key interface
  And there are existing domain tags
  When I click on the "x" icon to remove all domain tags
  Then all domain tags should be removed
  And the input field should be empty
  When I click on the "Update API Key" button
  Then the API key should be updated to allow all domains
  And the Domains column should show that all domains are allowed

Scenario: User removes an IP address tag in Edit interface
  And I am viewing the Edit API Key interface
  And there is an IP address tag "1.1.1.1" displayed
  When I click on the "x" icon on the "1.1.1.1" tag
  Then the "1.1.1.1" tag should be removed
  And the IP address should no longer be displayed
  When I click on the "Update API Key" button
  Then the changes should be saved successfully
  And the IP address should be removed from the API key

Scenario: User adds a new IP address in Edit interface
  And I am viewing the Edit API Key interface
  When I enter "192.168.1.1" in the Allowed IP Addresses input field
  And I press Enter or confirm the input
  Then "192.168.1.1" should appear as a new tag/chip
  And I should see an "x" icon on the new tag to remove it
  When I click on the "Update API Key" button
  Then the new IP address should be saved successfully
  And I should see "192.168.1.1" in the IP Addresses column of the API Keys table

Scenario: User removes all IP addresses in Edit interface
  And I am viewing the Edit API Key interface
  And there are existing IP address tags
  When I click on the "x" icon to remove all IP address tags
  Then all IP address tags should be removed
  And the input field should be empty
  When I click on the "Update API Key" button
  Then the API key should be updated to allow all IP addresses
  And the IP Addresses column should show that all IP addresses are allowed

Scenario: User updates API key name in Edit interface
  And I am viewing the Edit API Key interface
  And the current name is "Azure example"
  When I update the "Name" field to "Updated Azure Key"
  And I click on the "Update API Key" button
  Then the name should be updated successfully
  And I should see a success message
  And the modal should be closed
  When I view the API Keys table
  Then I should see "Updated Azure Key" in the Name column
  And "Azure example" should no longer appear

Scenario: User updates multiple fields in Edit interface
  And I am viewing the Edit API Key interface
  When I update the "Name" field to "Multi-Update Key"
  And I update the expiration date to a new future date
  And I add a new domain "newdomain.com"
  And I add a new IP address "10.0.0.1"
  And I click on the "Update API Key" button
  Then all changes should be saved successfully
  And I should see a success message
  When I view the API Keys table
  Then I should see "Multi-Update Key" in the Name column
  And I should see the updated expiration date
  And I should see "newdomain.com" in the Domains column
  And I should see "10.0.0.1" in the IP Addresses column

Scenario: User views API key with Active status in Edit interface
  And I am viewing the Edit API Key interface for an active API key
  Then I should see "Active" displayed in green text in the Status field
  And the status should be read-only or non-editable

Scenario: User views API key with Expired status in Edit interface
  And I am viewing the Edit API Key interface for an expired API key
  Then I should see "Expired" displayed in the Status field (not green)
  And the status should be read-only or non-editable

Scenario: User verifies all information is displayed correctly in Edit interface
  And I am viewing the Edit API Key interface for "Azure example"
  Then I should see "Azure example" in the Name field
  And I should see "Active" in green text in the Status field
  And I should see the created date "12/11/2025 11:01 AM" in the Created At field
  And I should see the masked API key value
  And I should see "FULL CONTROL" selected in the Permissions section
  And I should see the expiration date "12/11/2026 06:05 PM" in the Expires At field
  And I should see "google.com" as a domain tag
  And I should see "1.1.1.1" as an IP address tag
