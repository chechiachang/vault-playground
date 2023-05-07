.PHONY: policy

# Apply all policies

POLICIES:=$(shell ls policy)
policy:
	declare -a POLICIES=($(POLICIES)); \
  for p in $${POLICIES[@]%.hcl}; do \
    vault policy write $$p policy/$$p.hcl; sleep 1; \
  done
	vault policy list
