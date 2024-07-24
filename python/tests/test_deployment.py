import pytest
import requests
from pytest_bdd import scenario, given, when, then, parsers
import logging
from kubernetes import config

from lib.kubectl import Kubectl
import lib.log as log

logger = logging.getLogger(__name__)


@scenario('../scenarios/deployment.feature', 'Deployment')
def test_scenario():
    log.setup_logger()


@pytest.fixture
def kubectl():
    logger.info('Started deployment scenario')
    config.load_kube_config()
    return Kubectl()


@given(parsers.parse("I have a deployment manifest on path {file_path}"), target_fixture="deployment_path")
def deployment_path(file_path):
    return file_path


@when(parsers.parse("I deploy it and wait for deployment {deployment_name} on namespace {namespace_name}"))
def deploy_it(kubectl, deployment_path, deployment_name, namespace_name):
    kubectl.apply(deployment_path)
    kubectl.wait_for_deployment_complete(deployment_name, namespace_name)


@then(parsers.parse("I can execute a request to {request_url}"))
def execute_request(request_url):
    return requests.get(request_url)


@then(parsers.parse("the response code should be {status_code}"))
def check_response(execute_request, status_code):
    assert execute_request.status_code == status_code


