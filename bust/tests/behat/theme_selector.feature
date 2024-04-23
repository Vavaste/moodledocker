@core @core_admin @theme_bust
Feature: Select a theme in bust theme
  In order to choose a theme
  As an admin
  I need to preview the theme and make a selection

  Background:
    Given I log in as "admin"
    And I navigate to "Appearance > Themes" in site administration

  @javascript
  Scenario: I am able to preview a theme using a modal window
    When I click on "Preview theme 'bust'" "button"
    Then I should see "bust" in the "bust" "dialogue"
    And I should see "bust is a modern highly-customisable theme." in the "bust" "dialogue"
    And I should see "Current theme" in the "bust" "dialogue"

  @javascript
  Scenario: I am able to change the theme using the modal window select button
    Given I should see "Current theme" in the "#theme-card-bust" "css_element"
    When I click on "Preview theme 'Classic'" "button"
    And I click on "Select theme" "button" in the "Classic" "dialogue"
    Then I should see "Current theme" in the "#theme-card-classic" "css_element"

  Scenario: I am able to change the theme using the normal select button
    Given I should see "Current theme" in the "#theme-card-bust" "css_element"
    When I click on "Select theme 'Classic'" "button"
    Then I should see "Current theme" in the "#theme-card-classic" "css_element"

  Scenario: I am able to view a theme's settings page
    Given I click on "Edit theme settings 'bust'" "link"
    Then I should see "bust"
