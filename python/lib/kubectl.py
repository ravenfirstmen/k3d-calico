import time
from pprint import pprint

import yaml
from kubernetes import dynamic
from kubernetes.client import api_client
import logging

from kubernetes.dynamic.exceptions import DynamicApiError

logger = logging.getLogger(__name__)

class Kubectl(object):

    def __init__(self):
        self.client = dynamic.DynamicClient(api_client.ApiClient())

    def apply(self, file_name: str):
        try:
            k8s_objects = load_k8s_objects_from_yaml_file(file_name)
            for k8s_object in k8s_objects:
                namespace = self._get_object_namespace(k8s_object)
                kind_api = self._get_kind_api_from_object(k8s_object)
                logger.info('Creating Kubernetes object on namespace %s', namespace)
                kind_api.create(body=k8s_object, namespace=namespace)
                logger.info('Done creating Kubernetes object')
        except Exception as e:
            log_exception(e)

    def delete(self, file_name: str):
        try:
            k8s_objects = load_k8s_objects_from_yaml_file(file_name)
            for k8s_object in k8s_objects:
                name = self._get_object_name(k8s_object)
                namespace = self._get_object_namespace(k8s_object)
                kind_api = self._get_kind_api_from_object(k8s_object)
                logger.info('Deleting Kubernetes object %s on namespace %s', name, namespace)
                kind_api.delete(name=name, namespace=namespace, body={})
                logger.info('Done deleting Kubernetes object')
        except Exception as e:
            log_exception(e)

    def patch(self, file_name: str):
        try:
            k8s_objects = load_k8s_objects_from_yaml_file(file_name)
            for k8s_object in k8s_objects:
                name = self._get_object_name(k8s_object)
                namespace = self._get_object_namespace(k8s_object)
                kind_api = self._get_kind_api_from_object(k8s_object)
                logger.info('Patching Kubernetes object %s on namespace %s', name, namespace)
                kind_api.patch(body=k8s_object, name=name, namespace=namespace, content_type='application/merge-patch+json')
                logger.info('Done pathing Kubernetes object')
        except Exception as e:
            log_exception(e)

    def get_resource(self, name, namespace, api_version, kind: str):
        try:
            logger.info('Get Kubernetes object %s on namespace %s, of type %s', name, namespace, kind)
            kind_api = self.client.resources.get(api_version=api_version, kind=kind)
            cr = kind_api.get(name=name, namespace=namespace)
            logger.info('Done getting Kubernetes object %s on namespace %s, of type %s', name, namespace, kind)
            return cr
        except Exception as e:
            log_exception(e)

    def wait_for_deployment_complete(self, name, namespace: str, timeout: int=60):

        start = time.time()
        logger.info('Waiting for deployment %s on namespace %s to be ready', name, namespace)
        while time.time() - start < timeout:
            time.sleep(1)
            deployment = self.get_resource(
                name=name,
                namespace=namespace,
                api_version="v1",
                kind="Deployment")
            status = deployment.status
            if (status.updatedReplicas == deployment.spec.replicas and
                    status.replicas == deployment.spec.replicas and
                    status.availableReplicas == deployment.spec.replicas and
                    status.observedGeneration >= deployment.metadata.generation):
                logger.info('Deployment %s ready on namespace %s', name, namespace)
                return True
            else:
                logger.info(f'[updated_replicas:{status.updatedReplicas},replicas:{status.replicas},available_replicas:{status.availableReplicas},observed_generation:{status.observedGeneration}] waiting...')

        logger.error('Waiting timeout for deployment {name} on namespace {namespace}')
        raise RuntimeError(f'Waiting timeout for deployment {name} on namespace {namespace}')

    def _get_kind_api_from_object(self, k8s_object: dict):
        api_version = k8s_object.get('apiVersion')
        kind = k8s_object.get('kind')
        logger.info('Kubernetes object kind is %s and version %s', kind, api_version)
        return self.client.resources.get(api_version=api_version, kind=kind)

    def _get_object_name(self, k8s_object: dict):
        return k8s_object.get('metadata', {}).get('name')
    def _get_object_namespace(self, k8s_object: dict):
        ns = k8s_object.get('metadata', {}).get('namespace')
        return 'default' if ns is None else ns

    def _get_object_version(self, k8s_object: dict):
        return k8s_object.get('metadata', {}).get('resourceVersion')

def load_k8s_objects_from_yaml_file(yaml_file: str) -> []:
    k8s_objects = []
    logger.info('Loading Kubernetes objects from YAML file %s', yaml_file)
    with open(yaml_file, 'r') as f:
        contents = yaml.safe_load_all(f)
        for item in contents:
            k8s_objects.append(item)
    logger.info('Done loading %s Kubernetes objects from YAML file', len(k8s_objects))

    return k8s_objects


def log_exception(exception):
    if isinstance(exception, DynamicApiError):
        logger.error(exception.summary())
    else:
        logger.error(exception)
