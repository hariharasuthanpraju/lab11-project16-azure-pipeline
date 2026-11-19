#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV="${1:-}"
if [[ ! "$ENV" =~ ^(dev|qa|prod)$ ]]; then echo 'Usage: script.sh dev|qa|prod' >&2; exit 2; fi
LOCATION="${LOCATION:-centralindia}"
RG="rg-lab11-p07-${ENV}"
PARAM="$ROOT/infrastructure/parameters/${ENV}.bicepparam"
command -v az >/dev/null || { echo 'Azure CLI required' >&2; exit 1; }
