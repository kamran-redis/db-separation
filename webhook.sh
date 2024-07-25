#!/bin/bash
CERT=`kubectl get secret admission-tls -n operator -o jsonpath='{.data.cert}'`

kubectl apply -f webhook.yaml

cat > modified-webhook.yaml <<EOF
webhooks:
- name: redisenterprise.admission.redislabs
  clientConfig:
    caBundle: $CERT
  admissionReviewVersions: ["v1beta1"]
EOF

kubectl patch ValidatingWebhookConfiguration redis-enterprise-admission --patch "$(cat modified-webhook.yaml)"
