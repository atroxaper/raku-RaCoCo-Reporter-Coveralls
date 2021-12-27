[![Ubuntu](https://github.com/atroxaper/raku-RaCoCo-Reporter-Coveralls/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/atroxaper/raku-RaCoCo-Reporter-Coveralls/actions/workflows/ubuntu.yml)
[![MacOS](https://github.com/atroxaper/raku-RaCoCo-Reporter-Coveralls/actions/workflows/macos.yml/badge.svg)](https://github.com/atroxaper/raku-RaCoCo-Reporter-Coveralls/actions/workflows/macos.yml)
[![Windows](https://github.com/atroxaper/raku-RaCoCo-Reporter-Coveralls/actions/workflows/windows.yml/badge.svg)](https://github.com/atroxaper/raku-RaCoCo-Reporter-Coveralls/actions/workflows/windows.yml)

# NAME

`App::RaCoCo::Report::ReporterCoveralls` - App::RaCoCo reporter for [Coveralls.io](http://coveralls.io) service.

# HOWTO USE

Generally, the reporter is for using on a CI like GitHub Actions or so. If you want to run RaCoCo with the reporter locally, you need to set some environment variables (for more information see [Coveralls.io documentation](https://docs.coveralls.io)). Currently, the reporter supports GitHub and GitLab CI. In any case, you need to create an account on [Coveralls.io](https://coveralls.io) and add your repository there. After that, you will get a unique `repository token`.

## GitHub Example

To use the reporter in GitHub Actions you need:
1. Add the secret environment variable for your repository with a name like `COVERALLS_REPO_TOKEN` and value equals the `repository token`. To do so go to YourRepoSettings -> Secrets -> New repository secret;
2. Add installation step in your workflow.yaml file:
```yaml
  - name: Install Coveralls Reporter
    run: zef install --/test App::Racoco::Report::ReporterCoveralls
```
2. Add `--reporter=coveralls` to RaCoCo run in your workflow.yaml file. Also, you need to add `COVERALLS_REPO_TOKEN` environment variable:
```yaml
  - name: Run RaCoCo
    run: racoco --reporter=coveralls
    env:
      COVERALLS_REPO_TOKEN: ${{ secrets.COVERALLS_REPO_TOKEN }}
```

## GitLab Example

# AUTHOR

Mikhail Khorkov <atroxaper[at]cpan.org>

Sources can be found at: [github](https://github.com/atroxaper/raku-RaCoCo-Reporter-Coveralls). The new Issues and Pull Requests are welcome.

# COPYRIGHT AND LICENSE

Copyright 2021 Mikhail Khorkov

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.