Feature: Agents page management

Background:
  Given I navigate to "https://dev.agentiqai.ai/auth/sign-in"
  And I sign in with email "minhnguyen@agentiqai.ai" and password "minhnguyen"
  Then I should land on the dashboard
  When I open the "Agents" page from the sidebar
  Then I should see the Agents page with search, filter, create, and import

Scenario: User views Agents page elements
  Then I should see a search bar with placeholder "Search agents..."
  And I should see a "Filter by Type" dropdown
  And I should see "Create" and "Import Agent" buttons

Scenario: User views agent cards
  And there are agents available
  Then I should see agent cards with name, type badge (e.g., Specialist), "Ready" status, and "Last Updated" text
  And each card should have "View Details" and "Chat with Agent" buttons

Scenario: User views ""Filter by Type" dropdown"
  When I click on "Filter by Type" dropdown
  Then I should see options "Specialist", "Orchestrator", "Functional"

Scenario: Filter by agent type
  When I open the "Filter by Type" dropdown
  Then I should see options "Specialist", "Orchestrator", "Autonomous"
  When I check "Specialist"
  Then only Specialist agents should be listed
  When I additionally check "Orchestrator"
  Then Specialists and Orchestrators should be listed
  When I clear all filters
  Then the full agents list should be shown

Scenario: Filter shows empty state when no matches
  When I open the "Filter by Type" dropdown
  And I mark checkbox "Specialist"
  And there are no Specialist agents
  Then I should see the empty state message "No agents found matching your filters."
  When I clear all filters
  Then I should see the empty state message "No agents available. Click here to create your first agent."

Scenario: Search combined with filter
  Given there are agents named "Alpha Specialist" and "Beta Orchestrator"
  When I open the "Filter by Type" dropdown and check "Specialist"
  And I type "Alpha" into the search box
  Then only "Alpha Specialist" should be listed

Scenario: User opens agent details
  And an agent card is visible
  When I click on "View Details"
  Then I should see the agent detail page or panel

Scenario: User starts chat with agent
  And an agent card is visible
  When I click on "Chat with Agent"
  Then I should be taken to a chat session with that agent

Scenario: User starts a new chat session
  And I am viewing an existing chat session with an Agent
  When I click the "New Chat" button
  Then a new, empty chat session should be started
  And I should see the suggested quick questions/prompts

Scenario: E2E - Navigate to Agents via Management
  Given I am logged in to the dashboard
  When I click on the avatar/profile menu
  And I click on "Management"
  Then I should be redirected to the Agents page
  And I should see agent cards listed

Scenario: E2E - Chat with an agent
  Given I am on the Agents page
  And I see the agent "New package test"
  When I click on "Chat with Agent" for that agent
  Then I should be taken to a chat session
  And I should see the Agent's name displayed at the top (e.g., "New Package test")
  And I should see a message input field labeled "Message..."
  And I should see suggested quick questions/prompts (e.g., "� ngh?a c?a tr�ch nhi?m l�nh ??o...", "C�c ph??ng ph�p ki?m tra...")
  And I should see a "New Chat" button

Scenario: E2E - Run manual with Functional Agent (Autonomous)
  Given I am viewing the Agents list on the Agent Dashboard
  And the "Selenium pipeline" Agent currently shows the status "Ready"
  When I click the "Run manual" button on the "Selenium pipeline" Agent card
  Then the Agent's status on the card should immediately change from "Ready" to "Running"
  # Verification in Detail view
  When I click "View Details" on the "Selenium pipeline" Agent card
  And I navigate to the "Agent Info" tab
  Then the status badge next to the Agent Name ("Selenium pipeline") should display "Running"
  # Post-condition (Simulated Completion)
  When the pipeline execution completes
  Then the Agent's status should change back to "Ready" (or equivalent idle state)
