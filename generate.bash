set -exu

function generate {
  cd source
  for dashboard in *; do
    dashboard=${dashboard%%.*}
    out=../configmaps/${dashboard}.configmap.yaml
    kubectl create configmap ${dashboard} \
      --from-file=${dashboard}.json -o yaml --dry-run=client > ${out}
cat << EOF >> ${out}
  labels:
    grafana_dashboard: "true"
  annotations:
    grafana-folder: /grafana-dashboard-definitions/Addons
EOF
  done
  cd -
}

generate
