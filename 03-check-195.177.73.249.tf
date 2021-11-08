resource "datadog_synthetics_test" "check-apo" {
  type    = "api"
  subtype = "icmp"
  request_definition {
    number_of_packets = 4
    host    = "195.177.73.249"
  }
   assertion {
    type     = "packetLossPercentage"
    operator = "lessThan"
    target   = 0.6
  } 
  locations = ["aws:eu-west-2", "aws:ca-central-1", "aws:ap-south-1"]


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
  name    = "Check 195.177.73.249"
  message = "@slack-nightywi-notify \n"
  tags    = ["check_status:live",  "env:test"]

  status = "live"
}
