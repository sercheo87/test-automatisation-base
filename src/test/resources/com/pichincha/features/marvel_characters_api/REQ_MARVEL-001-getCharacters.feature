@REQ_MARVEL-001 @US001 @get_characters @marvel_characters_api @Agent2 @E2 @REQ_MARVEL-001-marvel_initiative
Feature: MARVEL-001 Get Marvel Characters (API for querying characters)

  Background:
    * def userNamespace = 'schancay'
    * url port_marvel_characters_api
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json",
          "Accept": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @getAllCharacters @successfulQuery200
  Scenario: T-API-MARVEL-001-CA01-Get all characters successfully 200 - karate
    * path '/' + userNamespace +'/api/characters'
    When method GET
    Then status 200
    And match response != null
    And match response == '#[]'

  @id:2 @getCharacterById @successfulQuery200
  Scenario: T-API-MARVEL-001-CA02-Get character by ID successfully 200 - karate
    * call read('commonUtilCreateCharacter.feature@UtilCreateCharacter')
    * def characterId = responseCreateCharacter.id
    * path '/' + userNamespace +'/api/characters/' + characterId
    When method GET
    Then status 200
    * print response
    And match response.id == characterId
    And match response.name != null
    And match response.alterego != null
    And match response.description != null
    And match response.powers == '#[3]'

  @id:3 @getCharacterById @characterNotFound404
  Scenario: T-API-MARVEL-001-CA03-Get non-existent character by ID 404 - karate
    * path '/' + userNamespace +'/api/characters/999'
    When method GET
    Then status 404
    And match response.error == 'Character not found'
    And match response != null

  @id:4 @getCharacterById @serviceError500
  Scenario: T-API-MARVEL-001-CA04-Internal server error 500 - karate
    * path '/' + userNamespace +'/api/characters/error'
    When method GET
    Then status 500
    And match response.error != null
    And match response.error == 'Internal server error'
