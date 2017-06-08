terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket     = "rcdf-tfstate.${get_env("TF_VAR_REGION", "us-east-1")}"
      key        = "${path_relative_to_include()}/terraform.tfstate"
      region     = "${get_env("TF_VAR_REGION", "us-east-1")}"
      encrypt    = true
      lock_table = "terraform_locking_${get_env("TF_VAR_REGION", "us-east-1")}"
    }
  }
}
