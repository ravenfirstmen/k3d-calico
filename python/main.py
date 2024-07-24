import sys
from pprint import pprint

from kubernetes import config

from lib.kubectl import Kubectl
import logging

logger = logging.getLogger(__name__)


def run():
    config.load_kube_config()

    kc = Kubectl()
    kc.apply("../gloo-istio/10-deploy-http-bin.yaml")
    # kc.patch("../gloo-istio/10-deploy-http-bin.yaml")
    # kc.delete("../gloo-istio/10-deploy-http-bin.yaml")
    kc.wait_for_deployment_complete(name="httpbin", namespace="httpbin")
    x = kc.get_resource(name="httpbin", namespace="httpbin", api_version="v1", kind="Deployment")
    pprint(x.to_dict())


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s [%(levelname)s] %(message)s",
        handlers=[
            logging.FileHandler("tests.log", mode='w'),
            logging.StreamHandler()
        ]
    )
    logger.info('Started')
    run()
    logger.info('Finished')
