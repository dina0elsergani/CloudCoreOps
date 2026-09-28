terraform {
  required_version = ">= 1.5.0"

  required_providers {
    # Permissive here on purpose: child modules state what they need, the root
    # module pins the exact version.
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
