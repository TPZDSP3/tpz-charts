# tpz-charts
Helm charts developed by TZ UK

## How this works

Every time that a chart package (`.tgz`) is updated, the helm repository index file is updated by the GitHub Actions Workflow (`.github/workflows/update-index.yml`).

## How to update the chart repo

You can package your charts using `helm package $CHART_NAME --version "$CHART_VERSION"`.

## Installing from this private chart repo
To authenticate, you must provide a GitHub API token that can read from the chart repository. It has to be provided using HTTP Basic Auth but it does not seem to matter whether you provide it as username, password, or both.

```shell
helm repo add yourorg \
  --username "${GITHUB_TOKEN}" \
  --password "${GITHUB_TOKEN}" \
  "https://raw.githubusercontent.com/yourorg/helm-chart-repository/main/"
```

Once the repository is added, you can search it or install charts from it. Note that you'll have to update the local repository index when looking for new versions.

```shell
helm repo update
helm search repo my-chart --devel
```

## Pushing to the private repo from another GitHub repo
You will need to create another GitHub Actions File (e.g. `.github/workflows/helm.yml`) with the following content:

```yaml
name: Helm

jobs:
  publish:
    runs-on: ubuntu-20.04
    steps:
      - name: Chart Checkout
        uses: actions/checkout@v2
      - name: Helm Installation
        uses: azure/setup-helm@v1.1
        with:
          version: v3.7.0
      - name: Helm Repository Checkout
        uses: actions/checkout@v2
        with:
          repository: yourorg/helm-chart-repository
          token: ${{ secrets.YOUR_BOT_GH_TOKEN }}
          fetch-depth: 0
          persist-credentials: true
          ref: main
          path: helm-chart-repository
      - name: Helm Package
        run: helm package my-chart --version "0.1.0+$(git rev-parse --short "$GITHUB_SHA")" -d helm-chart-repository
      - name: Helm Push
        env:
          GITHUB_TOKEN: ${{ secrets.YOUR_BOT_GH_TOKEN }}
        run: |
          git config --global user.email "yourbot@yourorg.com"
          git config --global user.name "YourOrg Bot"
          CHART_PACKAGE_NAME="my-chart-0.1.0+$(git rev-parse --short "$GITHUB_SHA").tgz"
          cd helm-chart-repository
          git add "$CHART_PACKAGE_NAME"
          git commit -m "$CHART_PACKAGE_NAME"
          git push origin main
```

Note that you will need to grant permissions to the workflow to push changes to the chart repository. This can be achieved by providing a GitHub API token in a secondary checkout@v2 action that has the required permissions (e.g. full access to org repos).
