#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "$0")"

kubectl cluster-info
kubectl create namespace tarea-grafana --dry-run=client -o yaml | kubectl apply -f -

if ! kubectl -n tarea-grafana get secret grafana-admin >/dev/null 2>&1; then
  echo 'Elige una clave temporal SOLO para este laboratorio; no uses una clave personal.'
  read -r -s -p 'Clave del usuario admin (minimo 12 caracteres): ' GRAFANA_LAB_PASSWORD
  printf '\n'
  if [ "${#GRAFANA_LAB_PASSWORD}" -lt 12 ]; then
    echo 'Clave demasiado corta. Ejecuta nuevamente: bash instalar.sh' >&2
    exit 1
  fi
  kubectl -n tarea-grafana create secret generic grafana-admin --from-literal="admin-password=$GRAFANA_LAB_PASSWORD"
  unset GRAFANA_LAB_PASSWORD
else
  echo 'Se conserva el Secret existente y su clave.'
fi

kubectl apply -f grafana.yaml
kubectl -n tarea-grafana rollout status deployment/grafana --timeout=300s
kubectl -n tarea-grafana get deployment,replicaset,pods,service -o wide
echo 'Abre Traffic/Ports en Killercoda, host controlplane, puerto 30000.'
echo 'Usuario: admin. Clave: la que escribiste. No publiques el Secret.'
