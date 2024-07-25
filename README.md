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
diff role_binding.yaml original/role_binding.yaml
10d9
<   namespace: operator
diff role.yaml original/role.yaml
```