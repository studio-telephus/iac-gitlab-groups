module "gitlab_sa_api_key" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "71c1634f-867a-43f2-b7b6-b0f500ae3e17"
}


module "minio_sa_api_key_iam" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "9daa1ab6-6a06-447f-a108-b0f700694052"
}

module "minio_sa_api_key_platform" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "901308ae-c614-432d-b4b5-b0f700655e20"
}
