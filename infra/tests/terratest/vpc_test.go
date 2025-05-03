package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestVpcModule(t *testing.T) {
  opts := &terraform.Options{
    TerraformDir: "../../envs/dev",
  }
  defer terraform.Destroy(t, opts)
  terraform.InitAndApply(t, opts)
  vpcId := terraform.Output(t, opts, "vpc_id")
  assert.NotEmpty(t, vpcId)
} 