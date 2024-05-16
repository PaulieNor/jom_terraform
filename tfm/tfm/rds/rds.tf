resource "aws_db_instance" "jom_rds" {
      allocated_storage    = 10
       identifier                  = "${var.env}jomdb"
  db_name              = "${var.env}jomdb"
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "jom"
  password             = random_password.master_password.result
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.db_security_group_id]
  parameter_group_name = aws_db_parameter_group.db_parameter_group.name
    publicly_accessible    = false
    db_subnet_group_name = aws_db_subnet_group.database.name
  tags = {
      Name = "${var.env}jomdb"
      ManagedBy = "terraform"
    }
  
}

resource "aws_db_subnet_group" "database" {
  name = "${var.env}-jom-db-subnet-group"
  subnet_ids = var.subnet_ids
}



resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "${var.env}-jom-pg"
  family = "postgres16"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "random_password" "master_password" {
    length = 12
    special = false
}

resource "aws_secretsmanager_secret" "db_access_secret" {
    name = "${aws_db_instance.jom_rds.db_name}/root"

    recovery_window_in_days = 0
    
    tags = {
      Name = "secret-${aws_db_instance.jom_rds.db_name}-root"
      ManagedBy = "terraform"
    }
  
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
    secret_id = aws_secretsmanager_secret.db_access_secret.id
    secret_string = jsonencode(
    {
        username = "${aws_db_instance.jom_rds.username}"
        password = "${aws_db_instance.jom_rds.password}"
        db_host = "${aws_db_instance.jom_rds.address}"
        db_name = "${aws_db_instance.jom_rds.db_name}"
    })

    lifecycle {
      ignore_changes = all
    }
}
