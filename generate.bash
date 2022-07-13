set -exu

function generate {
  cd source
  for dashboard in *; do
    dashboard=${dashboard%%.*}
    out=../configmaps/grafana-dashboard-${dashboard}.configmap.yaml
    kubectl create configmap grafana-dashboard-${dashboard} \
      --from-file=${dashboard}.json -o yaml --dry-run=client > ${out}
cat << EOF >> ${out}
  labels:
    grafana_dashboard: "true"
  annotations:
    grafana-folder: /grafana-dashboard-definitions/ODFMS
EOF
  done
  cd -
}

generate
