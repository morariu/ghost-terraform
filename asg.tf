resource "aws_launch_template" "ghost-launch-template" {
  name          = "ghost-launch-template"
  image_id      = var.instance_ami
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.ghost-web.id]
  user_data = base64encode(data.template_file.script.rendered)

  iam_instance_profile {
    name      = aws_iam_instance_profile.ec2_profile.name
  }  
}


data "template_file" "script" {
  template = file("scripts/ghost-install.sh")
  vars = {
    url = "${var.url}"
    url_admin = "${var.url_admin}"
    db_type = "${var.db_type}"
    database_endpoint = "${aws_rds_cluster.ghost_db.endpoint}"
    rds_master_username = "${local.db_creds.username}"
    rds_master_password = "${local.db_creds.password}"
    dbname = "${aws_rds_cluster.ghost_db.database_name}"
  }
}


resource "aws_autoscaling_group" "ghost-asg" {
  name                      = "ghost-asg"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  target_group_arns         = [aws_lb_target_group.ghost-tg.arn]

  launch_template {
    id      = aws_launch_template.ghost-launch-template.id
    version = "$Latest"
  }

  depends_on = [
    aws_rds_cluster.ghost_db
  ]

}