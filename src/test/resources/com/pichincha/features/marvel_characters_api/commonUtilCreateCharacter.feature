@UtilCreateCharacter
Feature: Create Character only using common functions

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

  Scenario: Create Character with common functions
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * def commonFunctions = karate.call('commonFunction.feature')
    * def randomName = 'Name-' + commonFunctions.randomString(5)
    * jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    * def responseCreateCharacter = response
    * print responseCreateCharacter