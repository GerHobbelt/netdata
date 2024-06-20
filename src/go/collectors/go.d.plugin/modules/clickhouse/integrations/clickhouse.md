<!--startmeta
custom_edit_url: "https://github.com/netdata/netdata/edit/master/src/go/collectors/go.d.plugin/modules/clickhouse/README.md"
meta_yaml: "https://github.com/netdata/netdata/edit/master/src/go/collectors/go.d.plugin/modules/clickhouse/metadata.yaml"
sidebar_label: "ClickHouse"
learn_status: "Published"
learn_rel_path: "Collecting Metrics/Databases"
most_popular: False
message: "DO NOT EDIT THIS FILE DIRECTLY, IT IS GENERATED BY THE COLLECTOR'S metadata.yaml FILE"
endmeta-->

# ClickHouse


<img src="https://netdata.cloud/img/clickhouse.svg" width="150"/>


Plugin: go.d.plugin
Module: clickhouse

<img src="https://img.shields.io/badge/maintained%20by-Netdata-%2300ab44" />

## Overview

This collector retrieves performance data from ClickHouse for connections, queries, resources, replication, IO, and data operations (inserts, selects, merges) using HTTP requests and ClickHouse system tables. It monitors your ClickHouse server's health and activity.


It sends HTTP requests to the ClickHouse [HTTP interface](https://clickhouse.com/docs/en/interfaces/http), executing SELECT queries to retrieve data from various system tables.
Specifically, it collects metrics from the following tables:

- system.metrics
- system.async_metrics
- system.events
- system.disks
- system.parts
- system.processes


This collector is supported on all platforms.

This collector supports collecting metrics from multiple instances of this integration, including remote instances.


### Default Behavior

#### Auto-Detection

By default, it detects ClickHouse instances running on localhost that are listening on port 8123.
On startup, it tries to collect metrics from:

- http://127.0.0.1:8123


#### Limits

The default configuration for this integration does not impose any limits on data collection.

#### Performance Impact

The default configuration for this integration is not expected to impose a significant performance impact on the system.


## Metrics

Metrics grouped by *scope*.

The scope defines the instance that the metric belongs to. An instance is uniquely identified by a set of labels.



### Per ClickHouse instance

These metrics refer to the entire monitored application.

This scope has no labels.

Metrics:

| Metric | Dimensions | Unit |
|:------|:----------|:----|
| clickhouse.connections | tcp, http, mysql, postgresql, interserver | connections |
| clickhouse.slow_reads | slow | reads/s |
| clickhouse.read_backoff | read_backoff | events/s |
| clickhouse.memory_usage | used | bytes |
| clickhouse.running_queries | running | queries |
| clickhouse.queries_preempted | preempted | queries |
| clickhouse.queries | successful, failed | queries/s |
| clickhouse.select_queries | successful, failed | selects/s |
| clickhouse.insert_queries | successful, failed | inserts/s |
| clickhouse.queries_memory_limit_exceeded | mem_limit_exceeded | queries/s |
| clickhouse.longest_running_query_time | longest_query_time | seconds |
| clickhouse.queries_latency | queries_time | microseconds |
| clickhouse.select_queries_latency | selects_time | microseconds |
| clickhouse.insert_queries_latency | inserts_time | microseconds |
| clickhouse.io | reads, writes | bytes/s |
| clickhouse.iops | reads, writes | ops/s |
| clickhouse.io_errors | read, write | errors/s |
| clickhouse.io_seeks | lseek | ops/s |
| clickhouse.io_file_opens | file_open | ops/s |
| clickhouse.replicated_parts_current_activity | fetch, send, check | parts |
| clickhouse.replicas_max_absolute_dela | replication_delay | seconds |
| clickhouse.replicated_readonly_tables | read_only | tables |
| clickhouse.replicated_data_loss | data_loss | events |
| clickhouse.replicated_part_fetches | successful, failed | fetches/s |
| clickhouse.inserted_rows | inserted | rows/s |
| clickhouse.inserted_bytes | inserted | bytes/s |
| clickhouse.rejected_inserts | rejected | inserts/s |
| clickhouse.delayed_inserts | delayed | inserts/s |
| clickhouse.delayed_inserts_throttle_time | delayed_inserts_throttle_time | milliseconds |
| clickhouse.selected_bytes | selected | bytes/s |
| clickhouse.selected_rows | selected | rows/s |
| clickhouse.selected_parts | selected | parts/s |
| clickhouse.selected_ranges | selected | ranges/s |
| clickhouse.selected_marks | selected | marks/s |
| clickhouse.merges | merge | ops/s |
| clickhouse.merges_latency | merges_time | milliseconds |
| clickhouse.merged_uncompressed_bytes | merged_uncompressed | bytes/s |
| clickhouse.merged_rows | merged | rows/s |
| clickhouse.merge_tree_data_writer_inserted_rows | inserted | rows/s |
| clickhouse.merge_tree_data_writer_uncompressed_bytes | inserted | bytes/s |
| clickhouse.merge_tree_data_writer_compressed_bytes | written | bytes/s |
| clickhouse.uncompressed_cache_requests | hits, misses | requests/s |
| clickhouse.mark_cache_requests | hits, misses | requests/s |
| clickhouse.max_part_count_for_partition | max_parts_partition | parts |
| clickhouse.parts_count | temporary, pre_active, active, deleting, delete_on_destroy, outdated, wide, compact | parts |
| distributed_connections | active | connections |
| distributed_connections_attempts | connection | attempts/s |
| distributed_connections_fail_retries | connection_retry | fails/s |
| distributed_connections_fail_exhausted_retries | connection_retry_exhausted | fails/s |
| distributed_files_to_insert | pending_insertions | files |
| distributed_rejected_inserts | rejected | inserts/s |
| distributed_delayed_inserts | delayed | inserts/s |
| distributed_delayed_inserts_latency | delayed_time | milliseconds |
| distributed_sync_insertion_timeout_exceeded | sync_insertion | timeouts/s |
| distributed_async_insertions_failures | async_insertions | failures/s |
| clickhouse.uptime | uptime | seconds |

### Per disk

These metrics refer to the Disk.

Labels:

| Label      | Description     |
|:-----------|:----------------|
| disk_name | Name of the disk as defined in the [server configuration](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-multiple-volumes_configure). |

Metrics:

| Metric | Dimensions | Unit |
|:------|:----------|:----|
| clickhouse.disk_space_usage | free, used | bytes |

### Per table

These metrics refer to the Database Table.

Labels:

| Label      | Description     |
|:-----------|:----------------|
| database | Name of the database. |
| table | Name of the table. |

Metrics:

| Metric | Dimensions | Unit |
|:------|:----------|:----|
| clickhouse.database_table_size | size | bytes |
| clickhouse.database_table_parts | parts | parts |
| clickhouse.database_table_rows | rows | rows |



## Alerts


The following alerts are available:

| Alert name  | On metric | Description |
|:------------|:----------|:------------|
| [ clickhouse_restarted ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.uptime | ClickHouse has recently been restarted |
| [ clickhouse_queries_preempted ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.queries_preempted | ClickHouse has queries that are stopped and waiting due to priority setting |
| [ clickhouse_long_running_query ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.longest_running_query_time | ClickHouse has a long-running query exceeding the threshold |
| [ clickhouse_rejected_inserts ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.rejected_inserts | ClickHouse has INSERT queries that are rejected due to high number of active data parts for partition in a MergeTree |
| [ clickhouse_delayed_inserts ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.delayed_inserts | ClickHouse has INSERT queries that are throttled due to high number of active data parts for partition in a MergeTree |
| [ clickhouse_replication_lag ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.replicas_max_absolute_delay | ClickHouse is experiencing replication lag greater than 5 minutes |
| [ clickhouse_replicated_readonly_tables ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.replicated_readonly_tables | ClickHouse has replicated tables in readonly state due to ZooKeeper session loss/startup without ZooKeeper configured |
| [ clickhouse_max_part_count_for_partition ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.max_part_count_for_partition | ClickHouse high number of parts per partition |
| [ clickhouse_distributed_connections_failures ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.distributed_connections_fail_exhausted_retries | ClickHouse has failed distributed connections after exhausting all retry attempts |
| [ clickhouse_distributed_files_to_insert ](https://github.com/netdata/netdata/blob/master/src/health/health.d/clickhouse.conf) | clickhouse.distributed_files_to_insert | ClickHouse high number of pending files to process for asynchronous insertion into Distributed tables |


## Setup

### Prerequisites

No action required.

### Configuration

#### File

The configuration file name for this integration is `go.d/clickhouse.conf`.


You can edit the configuration file using the `edit-config` script from the
Netdata [config directory](/docs/netdata-agent/configuration/README.md#the-netdata-config-directory).

```bash
cd /etc/netdata 2>/dev/null || cd /opt/netdata/etc/netdata
sudo ./edit-config go.d/clickhouse.conf
```
#### Options

The following options can be defined globally: update_every, autodetection_retry.


<details open><summary>Config options</summary>

| Name | Description | Default | Required |
|:----|:-----------|:-------|:--------:|
| update_every | Data collection frequency. | 1 | no |
| autodetection_retry | Recheck interval in seconds. Zero means no recheck will be scheduled. | 0 | no |
| url | Server URL. | http://127.0.0.1:8123 | yes |
| timeout | HTTP request timeout. | 1 | no |
| username | Username for basic HTTP authentication. |  | no |
| password | Password for basic HTTP authentication. |  | no |
| proxy_url | Proxy URL. |  | no |
| proxy_username | Username for proxy basic HTTP authentication. |  | no |
| proxy_password | Password for proxy basic HTTP authentication. |  | no |
| method | HTTP request method. | GET | no |
| body | HTTP request body. |  | no |
| headers | HTTP request headers. |  | no |
| not_follow_redirects | Redirect handling policy. Controls whether the client follows redirects. | no | no |
| tls_skip_verify | Server certificate chain and hostname validation policy. Controls whether the client performs this check. | no | no |
| tls_ca | Certification authority that the client uses when verifying the server's certificates. |  | no |
| tls_cert | Client TLS certificate. |  | no |
| tls_key | Client TLS key. |  | no |

</details>

#### Examples

##### Basic

A basic example configuration.

```yaml
jobs:
  - name: local
    url: http://127.0.0.1:8123

```
##### HTTP authentication

Basic HTTP authentication.

<details open><summary>Config</summary>

```yaml
jobs:
  - name: local
    url: http://127.0.0.1:8123
    username: username
    password: password

```
</details>

##### HTTPS with self-signed certificate

ClickHouse with enabled HTTPS and self-signed certificate.

<details open><summary>Config</summary>

```yaml
jobs:
  - name: local
    url: https://127.0.0.1:8123
    tls_skip_verify: yes

```
</details>

##### Multi-instance

> **Note**: When you define multiple jobs, their names must be unique.

Collecting metrics from local and remote instances.


<details open><summary>Config</summary>

```yaml
jobs:
  - name: local
    url: http://127.0.0.1:8123

  - name: remote
    url: http://192.0.2.1:8123

```
</details>



## Troubleshooting

### Debug Mode

To troubleshoot issues with the `clickhouse` collector, run the `go.d.plugin` with the debug option enabled. The output
should give you clues as to why the collector isn't working.

- Navigate to the `plugins.d` directory, usually at `/usr/libexec/netdata/plugins.d/`. If that's not the case on
  your system, open `netdata.conf` and look for the `plugins` setting under `[directories]`.

  ```bash
  cd /usr/libexec/netdata/plugins.d/
  ```

- Switch to the `netdata` user.

  ```bash
  sudo -u netdata -s
  ```

- Run the `go.d.plugin` to debug the collector:

  ```bash
  ./go.d.plugin -d -m clickhouse
  ```

