@REQ_MARVEL-002 @HU002 @create_characters @marvel_characters_api @Agent2 @E2 @REQ_MARVEL-002-marvel_initiative
Feature: MARVEL-002 Create Marvel Characters (API for creating new characters)

  Background:
    * def userNamespace = 'schancay'
    * url port_marvel_characters_api
    * path '/' + userNamespace +'/api/characters'
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

  @id:1 @createCharacter @successfulCreation201
  Scenario: T-API-MARVEL-002-CA01-Successfully create character 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * def commonFunctions = karate.call('commonFunction.feature')
    * def randomName = 'Name-' + commonFunctions.randomString(5)
    * jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    * print response
    And match response.id != null
    And match response.alterego != null
    And match response.description != null
    And match response.powers == '#[3]'
    And match response.name == jsonData.name

  @id:2 @createCharacter @duplicateName400
  Scenario: T-API-MARVEL-002-CA02-Create character with duplicate name 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    Then status 400
    * print response
    And match response.error == 'Character name already exists'
    And match response != null

  @id:3 @createCharacter @requiredFields400
  Scenario: T-API-MARVEL-002-CA03-Create character without required fields 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_invalid_character.json')
    And request jsonData
    When method POST
    Then status 400
    * print response
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'
