resource "datadog_synthetics_test" "luckyyeti-casino-check" {
  type    = "api"
  subtype = "http"
  request_definition {
    method = "GET"
    url    = "https://luckyyeti.com/casino"
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
  locations = ["aws:eu-west-1", "aws:ca-central-1", "aws:ap-south-1"]

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
  name    = "Check luckyyeti.com/casino"
  message = "@vk@atlas-iac.com"
  tags    = ["type:casino", "env:dev"]
  

  status = "live"
}
