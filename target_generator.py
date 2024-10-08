import sys

import yaml

targets = [
  "host1"
]
mapping = {}

for target in set(targets):
    subscription = {
        "address": f"{target}:32767",
        "subscriptions": [
            "port_stats",
            "network_instances_bgp",
            "components",
            "system"
        ]
    }
    mapping[target] = subscription


yaml.dump(mapping, sys.stdout)

print(len(targets))

