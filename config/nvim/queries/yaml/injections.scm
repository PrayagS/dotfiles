;;
;; Source: https://github.com/belltoy/tree-sitter-vrl#advanced-usage
;;
;; Vector VRL codes embeded in YAML
;;
;; _NOTE_: ONLY use injection for VRL code in block scalar **literal** mode.
;;
;;
;; Block header in _clip_ mode with indentation indicator
;; Or in _strip_ or _keep_ mode without indentation indicator
;; Example:
;;
;;     source: |-
;;
;; or
;;
;;     source: |4
(block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_source
      (#any-of? @_source "source" "condition")))
  value: (block_node
    (block_scalar) @injection.content
    (#match? @injection.content "^[\\|][-+1-9]\n.*$")
    (#offset! @injection.content 0 2 0 0)
    (#set! injection.language "vrl")))

;; Block header in _strip_ or _keep_ mode with indentation indicator
;; Example:
;;
;;     source: |-4
(block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_source
      (#any-of? @_source "source" "condition")))
  value: (block_node
    (block_scalar) @injection.content
    (#match? @injection.content "^[\\|][-+][1-9]\n.*$")
    (#offset! @injection.content 0 3 0 0)
    (#set! injection.language "vrl")))

;; Block header in _clip_ mode without indentation indicator
;; Example:
;;
;;     source: |
(block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_source
      (#any-of? @_source "source" "condition")))
  value: (block_node
    (block_scalar) @injection.content
    (#match? @injection.content "^[\\|]\n.*$")
    (#offset! @injection.content 0 1 0 0)
    (#set! injection.language "vrl")))

;; For float scalars
(block_mapping_pair
  key: (flow_node
         (plain_scalar
           (string_scalar) @_source
          (#eq? @_source "condition")))
  value: (flow_node
           (plain_scalar
             (string_scalar) @injection.content
             (#offset! @injection.content 0 0 0 0)
             (#set! injection.language "vrl"))))
