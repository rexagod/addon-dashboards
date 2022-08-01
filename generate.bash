set -exu

function generate {
  cd source/"$1"/
  for dashboard in *; do
    dashboard=${dashboard%%.*}
    out=../../configmaps/"$1"/${dashboard}.configmap.yaml
    kubectl create configmap ${dashboard} --from-file=${dashboard}.json -o yaml --dry-run=client > ${out}
cat << EOF >> ${out}
  labels:
    grafana_dashboard: "true"
  annotations:
    grafana-folder: /grafana-dashboard-definitions/Addons
EOF
  done
  cd -
}

generate stage
generate production

