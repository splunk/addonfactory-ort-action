# ADDONFACTORY-ORT-ACTION

This action scans a project for third party components and reports the results. This action contains a curation file managed by Splunk Inc. Source is provided for this action however it may not be useful outside of our organization.


# v1

This release adds reliability for pulling node distributions from a cache of node releases.

```yaml
steps:
    - 
    name: ort-action
    uses: splunk/addonfactory-ort-action@v1
    id: ort-action
    - 
    name: ort-action-artifacts
    uses: actions/upload-artifact@v2
    with:
        name: analysis
        path: .ort/
```

The action will check tests/knowledge/* for potentialy identifying data and update the build or pr with annotations identifying violations.

# License

The scripts and documentation in this project are released under the [Apache 2.0 License](LICENSE)

# Contributions

See [our contributor license agreement](https://github.com/splunk/cla-agreement/blob/main/CLA.md)

## Code of Conduct

:wave: Be nice.  See [our code of conduct](https://github.com/splunk/cla-agreement/blob/main/CODE_OF_CONDUCT.md)