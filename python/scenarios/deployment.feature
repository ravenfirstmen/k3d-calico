Feature: Deployment
  Simple deployment test

  Scenario: Deployment
    Given I have a deployment manifest on path ../gloo-istio/10-deploy-http-bin.yaml
    When I deploy it and wait for deployment httpbin on namespace httpbin
    Then I can execute a request to https://localhost:8080/headers
    And the response code should be 200