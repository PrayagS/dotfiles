---
name: yaml-reader
description: Read and parse YAML files using yq command-line tool. Extract values, query nested structures, filter arrays, and validate syntax. Use when working with YAML configuration files (.yaml, .yml), docker-compose files, Kubernetes manifests, Helm charts, or any YAML parsing tasks.
---

# YAML Reader with yq

When reading or querying YAML files, use `yq` instead of the Read tool or cat command.

## Quick Overview

Start by listing keys to understand the file structure:

```bash
# List all top-level keys
yq 'keys' config.yaml

# List keys of a nested object
yq '.database | keys' config.yaml

# Then query specific keys for their values
yq '.database.host' config.yaml
```

## Basic Operations

```bash
# Read entire file (pretty-printed)
yq '.' config.yaml

# Extract a specific value
yq '.database.host' config.yaml

# Extract nested value
yq '.spec.containers[0].image' deployment.yaml

# Get multiple values
yq '.database | (.host, .port)' config.yaml
```

## Querying Arrays

```bash
# Get first element
yq '.servers[0]' config.yaml

# Get all elements
yq '.servers[]' config.yaml

# Get array length
yq '.servers | length' config.yaml

# Filter by condition
yq '.services[] | select(.enabled == true)' config.yaml

# Get specific field from all array items
yq '.containers[].name' config.yaml
```

## Output Formats

```bash
# Output as JSON
yq -o=json '.' config.yaml

# Output raw string (no quotes)
yq -r '.name' config.yaml

# Output as properties
yq -o=props '.' config.yaml
```

## Working with Multiple Documents

```bash
# Select specific document (0-indexed)
yq 'select(documentIndex == 0)' multi-doc.yaml

# Process all documents
yq '.' multi-doc.yaml
```

## Validation

```bash
# Check if file is valid YAML (exits 0 if valid)
yq '.' config.yaml > /dev/null && echo "Valid YAML"

# Check if key exists
yq 'has("database")' config.yaml
```

## Common Use Cases

### Docker Compose
```bash
# List service names
yq '.services | keys' docker-compose.yaml

# Get image for a service
yq '.services.web.image' docker-compose.yaml
```

### Kubernetes
```bash
# Get container images from deployment
yq '.spec.template.spec.containers[].image' deployment.yaml

# Get all resource names from a manifest
yq '.metadata.name' manifest.yaml
```

### Helm
```bash
# Read values file
yq '.replicaCount' values.yaml
```
