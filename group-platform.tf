resource "gitlab_group" "platform" {
  name             = "platform"
  description      = "Platform Team"
  path             = "platform"
  visibility_level = "private"
}

resource "gitlab_group_variable" "platform_minio_adm_sa_access_key" {
  group     = gitlab_group.platform.id
  key       = "MINIO_ADM_SA_ACCESS_KEY"
  value     = module.minio_sa_api_key_platform.data.username
  protected = false
  masked    = true
}

resource "gitlab_group_variable" "platform_minio_adm_sa_secret_key" {
  group     = gitlab_group.platform.id
  key       = "MINIO_ADM_SA_SECRET_KEY"
  value     = module.minio_sa_api_key_platform.data.password
  protected = false
  masked    = true
}

resource "gitlab_user" "platform_runner_sa" {
  name             = "Platform Runner Service Account"
  username         = module.bw_platform_gitlab_user.data.username
  password         = module.bw_platform_gitlab_user.data.password
  email            = "${module.bw_platform_gitlab_user.data.username}@mail.adm.acme.corp"
  is_admin         = false
  can_create_group = false
  is_external      = false
  reset_password   = false
}

resource "gitlab_group_membership" "platform_platform_runner_sa" {
  group_id     = gitlab_group.platform.id
  user_id      = gitlab_user.platform_runner_sa.id
  access_level = "reporter"
}

resource "gitlab_group_membership" "iam_platform_runner_sa" {
  group_id     = gitlab_group.iam.id
  user_id      = gitlab_user.platform_runner_sa.id
  access_level = "reporter"
}

resource "gitlab_group_membership" "terraform_platform_runner_sa" {
  group_id     = gitlab_group.terraform.id
  user_id      = gitlab_user.platform_runner_sa.id
  access_level = "reporter"
}

resource "gitlab_personal_access_token" "platform_runner_sa" {
  user_id    = gitlab_user.platform_runner_sa.id
  name       = "GitLab"
  expires_at = "2025-01-10"
  scopes     = ["api", "read_api"]
}

resource "local_sensitive_file" "platform_runner_sa_pat" {
  content  = gitlab_personal_access_token.platform_runner_sa.token
  filename = ".terraform/platform_runner_sa_pat.out"
}
