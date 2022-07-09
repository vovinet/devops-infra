terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  zone                     = local.yc_zone
}