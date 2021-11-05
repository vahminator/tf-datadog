resource "datadog_synthetics_test" "check-one" {
  type    = "api"
  subtype = "icmp"
  request_definition {
    number_of_packets = 4
    host    = "185.143.146.25"
  }
   assertion {
    type     = "packetLossPercentage"
    operator = "is"
    target   = 1
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
  name    = "Check 185.143.146.25"
  message = "@slack-nightywi-notify \n"
  tags    = ["check_status:live",  "env:test"]

  status = "live"
}
