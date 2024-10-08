# gNMIc Cluster
This project enables users to run an autoscaling [gNMIc](https://gnmic.openconfig.net/) cluster on kubernetes. [gNMIc](https://gnmic.openconfig.net/) is an openconfig project
that allows users to stream telemetry from gNMI enabled routers.

This project was co-funded by [GEANT](https://geant.org) in the GN5-1 WP6 Incubator.
## Telemetry pipeline architecture

![Telemetry Architecture](Architecture.drawio.png)


## Prerequisites

- Kubernetes cluster
- A strimzi operator and kafka cluster deployment within your k8s cluster [Strimzi](https://strimzi.io/downloads/)
- Minimum CPU and RAM for 300 Routers and subscription to all metrics for processing +/- 2 billion events per day


    | CPU | Memory| Storage (90 days retention) |
    |---|---| --- |
    | 20 | 160Gi  | 3Ti |



## Installation

```bash
helm repo add gnmic-cluster-chart https://workfloworchestrator.org/gnmic-cluster-chart/
helm repo update
helm upgrade --install gnmic-cluster gnmic-cluster-chart/gnmic-cluster
```


# Helm Chart Documentation
<!-- include (charts/gnmic/README.md) -->


# Updating documentation
The Helm chart and readme are documented separately.

### Helm
The Helm chart is documented use `helm-docs` [Link](https://github.com/norwoodj/helm-docs)
Run it as follows:

```bash
helm-docs .
```

### Readme generation
The README generation is done by editing the `README.md.tpl` file. and running the command

```bash
md_incl README.md.tpl README.md
```

This assumes you have `md_incl` installed. [link](https://pypi.org/project/md-incl/)