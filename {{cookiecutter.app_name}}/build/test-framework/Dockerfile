ARG BASEIMAGE
FROM ${BASEIMAGE}
RUN pip install molecule
ADD . /opt/ansible/project
ARG NAMESPACEDMAN
ADD $NAMESPACEDMAN /namespaced.yaml
ADD build/test-framework/ansible-test.sh /ansible-test.sh
RUN chmod +x /ansible-test.sh
