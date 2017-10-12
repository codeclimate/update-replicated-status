# Update Replicated Status

General purpose container to update the status line on a Replicated application
during startup. It uses the [status API] to do that.

## Usage

Within a `replicated.yml` file:

```yml
components:
- name: data
  containers:
  - source: private
    image_name: database
    publish_events:
    - name: Started Database
      trigger: container-start
      subscriptions:
      - component: update_app_status
        container: codeclimate/update-replicated-status
        action: start
- name: update_app_status
  containers:
  - source: public
    image_name: codeclimate/update-replicated-status
    version: latest
    ephemeral: true
    cmd: "Starting services..."
    publish_events:
    - name: Updated app status
      trigger: container-stop
      subscriptions:
      - component: services
        container: service
        action: start
```

[status API]: https://help.replicated.com/api/integration-api/status-api/
