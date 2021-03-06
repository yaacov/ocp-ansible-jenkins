#!/bin/bash
echo
echo "#----- Environment variables -----"
echo
echo export OPENSHIFT_HAWKULAR_ROUTE=\"$(oc get route --namespace='openshift-infra' -o go-template --template='{{.spec.host}}' hawkular-metrics 2> /dev/null)\"
echo export OPENSHIFT_PROMETHEUS_ALERTS_ROUTE=\"$(oc get route --namespace='openshift-metrics' -o go-template --template='{{.spec.host}}' alerts 2> /dev/null)\"
echo export OPENSHIFT_PROMETHEUS_METRICS_ROUTE=\"$(oc get route --namespace='openshift-metrics' -o go-template --template='{{.spec.host}}' prometheus 2> /dev/null)\"
echo export OPENSHIFT_MASTER_HOST=\"$(oc get nodes -o name |grep master |sed -e 's/nodes\///g')\"
echo export OPENSHIFT_MANAGEMENT_ADMIN_TOKEN=\"$(oc sa get-token -n management-infra management-admin)\"
echo export OPENSHIFT_CA_CRT=\""$(cat /etc/origin/master/ca.crt)"\"
echo
echo "# Run this command to configure the provider in your local ManageIQ:"
echo
echo 'curl https://raw.githubusercontent.com/container-mgmt/ocp-ansible-jenkins/master/miqplaybook.yml > miqplaybook.yml  && ansible-playbook --extra-vars "provider_name=OCP cfme_route=http://localhost:3000" miqplaybook.yml'
echo '#-----------------------------'
echo
