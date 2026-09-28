package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Applies the root module for real, so it costs money and takes time. Not part
// of CI: run it deliberately with valid AWS credentials.
func TestRootModuleCreatesVpc(t *testing.T) {
	t.Parallel()

	opts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../..",
		Vars: map[string]interface{}{
			"project_name": "cloudcoreops-test",
			"db_password":  "test-password-change-me",
		},
	})

	defer terraform.Destroy(t, opts)
	terraform.InitAndApply(t, opts)

	assert.NotEmpty(t, terraform.Output(t, opts, "vpc_id"))
	assert.NotEmpty(t, terraform.Output(t, opts, "eks_cluster_name"))
}
