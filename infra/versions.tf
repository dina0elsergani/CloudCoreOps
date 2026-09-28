terraform {
  required_version = ">= 1.5.0"

  required_providers {
    # Pinned to 5.x: the EKS module version used here predates the provider 6.0
    # removals (elastic_gpu_specifications, elastic_inference_accelerator) and
    # fails to load against 6.x.
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }
}
