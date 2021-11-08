resource "datadog_synthetics_test" "goodwin-sport-check" {
  type    = "api"
  subtype = "http"
  request_definition {
    method = "GET"
    url    = "https://sport.goodwin.am/en/sport"
  }
  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }
  assertion {
    type     = "responseTime"
    operator = "lessThan"
    target   = "5000"
  }
  locations = ["aws:eu-west-1", "aws:ca-central-1", "aws:ap-south-1", "aws:us-east-2"]

  options_list {
    tick_every = 60

    retry {
      count    = 2
      interval = 300
    }

    monitor_options {
      renotify_interval = 100
    }
  }
  name    = "Check sport.goodwin.am/en/sport"
  message = "@vk@atlas-iac.com"
  tags    = ["type:sport", "env:dev"]
  

  status = "live"
}
