package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"

	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/stretchr/testify/assert"
)

func TestTerraformInfraTest(t *testing.T) {
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "./staging",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	//saving terraform outputs in variables
	s3_output := terraform.Output(t, terraformOptions, "s3_tags")
	instance_tag_output := terraform.Output(t, terraformOptions, "instance_tags")

	fmt.Print(instance_tag_output)
	//checking the resources are properly tagged
	assert.Equal(t, "map[Name:Flugel Owner:InfraTeam]", s3_output)
	assert.Equal(t, "[map[key:Name propagate_at_launch:true value:Flugel] map[key:Owner propagate_at_launch:true value:InfraTeam] map[key:environment propagate_at_launch:true value:autoscaling-staging]]", instance_tag_output)
	// saving alb dns output
	albIp := terraform.Output(t, terraformOptions, "alb_dns")
	// saving the url for the static file
	url := fmt.Sprintf("http://%s:8080/index.html", albIp)
	// curling the dns endpoint
	http_helper.HttpGetWithRetryWithCustomValidation(
		t,
		url,
		nil,
		30,
		5*time.Second,
		// returinng a bool if both conditions are true
		func(status int, body string) bool {
			return status == 200 &&
				strings.Contains(body, "Name:Flugel")
			// making sure the static files are reacheable in the nginx server
		},
	)
}
