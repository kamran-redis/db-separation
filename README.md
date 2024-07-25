Webhook not working on error looping error message

```
kubectl apply -n application -f - << EOF
apiVersion: app.redislabs.com/v1alpha1
kind: RedisEnterpriseDatabase
metadata:
  name: redis-enterprise-database
spec:
  evictionPolicy: illegal
EOF
```

```
operator/redis-enterprise-operator-7988fc96dd-b8j92[redis-enterprise-operator]: {"level":"error","ts":"2024-07-25T23:13:14.494Z","logger":"controller_redisenterprisedatabase","msg":"failed to Act","Namespace":"application","Name":"redis-enterprise-database","error":"failed to Act on database: Post Error https://rec:9443/v1/bdbs. Status: 400: response = {\"description\":\"'illegal' is an invalid value for 'eviction_policy'. Possible values are ['volatile-lru', 'volatile-ttl', 'volatile-random', 'allkeys-lru', 'allkeys-random', 'noeviction', 'volatile-lfu', 'allkeys-lfu']\",\"error_code\":\"invalid_schema\"}\n","stacktrace":"github.com/RedisLabs/redis-enterprise-operator/pkg/controller/redb.(*ReconcileRedisEnterpriseDatabase).Reconcile\n\t/go/src/github.com/RedisLabs/redis-enterprise-operator/pkg/controller/redb/redisenterprisedatabase_controller.go:128\nsigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).Reconcile\n\t/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.16.3/pkg/internal/controller/controller.go:119\nsigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).reconcileHandler\n\t/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.16.3/pkg/internal/controller/controller.go:316\nsigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).processNextWorkItem\n\t/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.16.3/pkg/internal/controller/controller.go:266\nsigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).Start.func2.2\n\t/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.16.3/pkg/internal/controller/controller.go:227"}
```


Separate namespace for Operator and REC
based on v7.4.2-2 tag
to deploy
```
. ./deploy.sh
```

changes made from original files
```
diff bundle.yaml original/bundle.yaml
2d1
< # tag v7.4.2-2
16532,16533c16531,16533
<             #CHANGED
<               value: application
---
>               valueFrom:
>                 fieldRef:
>                   fieldPath: metadata.namespace
16581c16581,16583
<               value: application
---
>               valueFrom:
>                 fieldRef:
>                   fieldPath: metadata.namespace
diff role_binding.yaml original/role_binding.yaml
10d9
<   namespace: operator
diff role.yaml original/role.yaml
```