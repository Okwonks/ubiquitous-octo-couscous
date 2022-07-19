# Bamboo Deployment (Google Compute Engine)

A collection of scripts used to deploy [Bamboo](https://www.atlassian.com/software/bamboo) to a Google Compute Engine (GCE) vm

## Getting Started

The scripts featured use bash, these can be run on any linux/macos distribution.
If there's any problem running a script, please create an issue discribing the problem. A pull request is also welcome

### Prerequisites

1. Some knowledge in `bash` sripting and `gcloud cli` may be required (mainly to understand what's happening).
2. A [Google Cloud Project](https://console.cloud.google.com) (a project id is needed when executing the deploy script)

## Usage

From the root folder:
	```sh
	export PROJECT_ID=<your-gcp-project-id> && ./deploy-compute-engine-vm
	```

## License

Distributed under the MIT License. See `LICENSE` for more information.
