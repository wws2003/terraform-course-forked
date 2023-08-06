# Scale up policy
# # Policy
resource "aws_autoscaling_policy" "app_auto_scale_up_policy" {
    name = "app_auto_scale_up_policy"
    autoscaling_group_name = aws_autoscaling_group.app_auto_scaling_group.name
    adjustment_type        = "ChangeInCapacity"
    scaling_adjustment     = "1"
    cooldown               = "300"
    policy_type            = "SimpleScaling"
}
# # Alarm
resource "aws_cloudwatch_metric_alarm" "app_scale_up_alarm" {
    alarm_name = "app_scale_up_alarm"
    alarm_description   = "Alarm by CPU usage"
    
    # Alarm specification
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "2"
    period              = "120"
    statistic           = "Average"
    threshold           = "30"

    # Actions-related
    actions_enabled = true
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.app_auto_scaling_group.name
    }
    alarm_actions = [aws_autoscaling_policy.app_auto_scale_up_policy.arn]
}

# Scale down policy
# # Policy
resource "aws_autoscaling_policy" "app_auto_scale_down_policy" {
    name = "app_auto_scale_down_policy"
    autoscaling_group_name = aws_autoscaling_group.app_auto_scaling_group.name
    adjustment_type        = "ChangeInCapacity"
    scaling_adjustment     = "-1"
    cooldown               = "300"
    policy_type            = "SimpleScaling"
}
# # Alarm
resource "aws_cloudwatch_metric_alarm" "app_scale_down_alarm" {
    alarm_name = "app_scale_down_alarm"
    alarm_description   = "Alarm by CPU usage"
    
    # Alarm specification
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = "2"
    period              = "120"
    statistic           = "Average"
    threshold           = "5"

    # Actions-related
    actions_enabled = true
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.app_auto_scaling_group.name
    }
    alarm_actions = [aws_autoscaling_policy.app_auto_scale_down_policy.arn]
}