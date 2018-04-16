defaults:
  timer_type: histogram
  buckets: [.005, .01, .025, .05, .1, .25, .5, 1, 2.5 ]
  match_type: glob
mappings:
- match: vault.barrier.*
  name: "vault_barrier"
  labels:
    job: "$1"
- match: vault.consul.*
  name: "vault_consul"
  labels:
    job: "$1"
- match: vault.route.*.*
  name: "vault_route"
  labels:
    job: "$1"
    path: "$2"
- match: vault.rollback.attempt.*
  name: "vault_rollback_attempt"
  labels:
    mount: "$1"
- match: vault.*.expire.num_leases
  name: "vault_expire_num_leases"
  labels:
    hostname: "$1"
- match: vault.*.runtime.alloc_bytes
  name: "vault_runtime_alloc_bytes"
  labels:
    hostname: "$1"
- match: vault.*.runtime.free_count
  name: "vault_runtime_free_count"
  labels:
    hostname: "$1"
- match: vault.*.runtime.heap_objects
  name: "vault_runtime_heap_objects"
  labels:
    hostname: "$1"
- match: vault.*.runtime.malloc_count
  name: "vault_runtime_malloc_count"
  labels:
    hostname: "$1"
- match: vault.*.runtime.num_goroutines
  name: "vault_runtime_num_goroutines"
  labels:
    hostname: "$1"
- match: vault.*.runtime.sys_bytes
  name: "vault_runtime_sys_bytes"
  labels:
    hostname: "$1"
- match: vault.*.runtime.total_gc_pause_ns
  name: "vault_runtime_total_gc_pause_ns"
  labels:
    hostname: "$1"
- match: vault.*.runtime.total_gc_runs
  name: "vault_runtime_total_gc_runs"
  labels:
    hostname: "$1"
- match: vault.*.runtime.gc_pause_ns
  name: "vault_runtime_gc_pause_ns"
  labels:
    hostname: "$1"