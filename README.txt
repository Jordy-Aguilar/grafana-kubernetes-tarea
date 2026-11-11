GRAFANA EN KUBERNETES: DEPLOYMENT Y REPLICASET

Autor: [COMPLETAR NOMBRE]
Asignatura: [COMPLETAR]
Repositorio publico: [COMPLETAR URL REAL]
Estado de este paquete: material de practica preparado; ejecutar y adjuntar evidencias reales.

OBJETIVO
Desplegar Grafana mediante un Deployment, identificar el ReplicaSet que crea,
exponer la aplicacion con un Service NodePort, escalar de uno a tres Pods y
comprobar que Kubernetes reemplaza un Pod eliminado.

ENTORNO
Killercoda Kubernetes Playground, en el navegador:
https://killercoda.com/playgrounds/scenario/kubernetes
La sesion gratuita es temporal (hasta una hora). Guardar capturas en el equipo.

ARCHIVOS
grafana.yaml: Namespace, Deployment y Service NodePort.
instalar.sh: crea un Secret con clave elegida por el estudiante y despliega Grafana.
GUIA.txt: procedimiento completo con momentos de captura.
INFORME-PLANTILLA.txt: base del informe para completar con resultados reales.
evidencias/: agregar aqui las capturas reales.

EJECUCION (terminal Bash del laboratorio, dentro de este repositorio)
kubectl get nodes -o wide
bash instalar.sh
kubectl -n tarea-grafana get deployment,rs,pods,svc

ACCESO
Service: grafana. Tipo: NodePort. Puerto del nodo: 30000.
Puerto del Service y del contenedor: 3000.
Killercoda > menu de terminal > Traffic/Ports > host controlplane > puerto 30000.
Usuario: admin. Clave: la elegida durante la instalacion.

ESCALADO
kubectl -n tarea-grafana scale deployment grafana --replicas=3
kubectl -n tarea-grafana rollout status deployment/grafana --timeout=300s
kubectl -n tarea-grafana get deployment,rs,pods

AUTORRECUPERACION
Ver GUIA.txt: guardar nombre y UID antes de borrar UN Pod y compararlos despues.
No borrar todo el Deployment ni crear un ReplicaSet independiente con app=grafana.

USOS
Grafana permite visualizar metricas y registros desde fuentes de datos compatibles,
construir dashboards y configurar alertas. Instalar Grafana no instala automaticamente
Prometheus ni configura la recoleccion de metricas de Kubernetes.

ALCANCE DEL LABORATORIO
El Deployment gestiona el ReplicaSet; este mantiene la cantidad deseada de Pods.
El Service selecciona los Pods por app=grafana y distribuye conexiones hacia los listos.
Los datos son temporales (emptyDir). Cada replica usa su propia base SQLite.
Escalar esta practica NO configura alta disponibilidad de datos de Grafana.
Para una instalacion real con varias replicas, Grafana requiere una base compartida
MySQL/PostgreSQL y configuracion adicional. Un solo nodo tampoco tolera perder ese nodo.
No se solicita un PVC porque el objetivo es Deployment/ReplicaSet, no persistencia.

REPRODUCIBILIDAD
Para repetir, crear una nueva sesion de laboratorio, clonar el repositorio y ejecutar
bash instalar.sh. No se necesita Dockerfile: se usa una imagen oficial existente.
La imagen esta fijada en grafana/grafana:13.1.3, sin usar la etiqueta latest.
No subir contrasenas, kubeconfig ni exportaciones del Secret al repositorio.

FUENTES OFICIALES
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/
https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/
https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/
https://grafana.com/docs/grafana/latest/setup-grafana/set-up-for-high-availability/
https://github.com/grafana/grafana/releases/tag/v13.1.3
https://killercoda.com/faq/
https://killercoda.com/creators
