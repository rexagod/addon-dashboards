all: generate

SERVICE="odf-ms-service-level-overview.configmap.yaml"
CLUSTER="odf-ms-cluster-status.configmap.yaml"

generate:
	$@.bash

copy-service:
	cp ./configmaps/"$(1)"/"$(SERVICE)" ~/repositories/managed-tenants-slos/ODFMS/dashboards/"$(1)"/"$(SERVICE)"

copy-cluster:
	cp ./configmaps/"$(1)"/"$(CLUSTER)" ~/repositories/managed-tenants-slos/ODFMS/dashboards/"$(1)"/"$(CLUSTER)"

copy: copy-service copy-cluster
