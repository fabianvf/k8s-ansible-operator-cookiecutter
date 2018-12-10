FROM quay.io/water-hole/ansible-operator

COPY roles/ ${HOME}/roles/
COPY watches.yaml ${HOME}/watches.yaml
{% if cookiecutter.generate_playbook == 'yes' -%}
COPY playbook.yml ${HOME}/playbook.yml
{% endif -%}
