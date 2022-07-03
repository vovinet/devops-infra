provider "yandex" {
  token                    = yc_token
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  zone                     = local.yc_zone
}