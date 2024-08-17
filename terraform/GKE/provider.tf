provider "google" {
  region  = "europe-west2"
  project = "instancepaa"
}

provider "random" {
  version = "~> 2.2.1"
}

provider "null" {
  version = "~> 2.1.2"
}

provider "kubernetes" {
  version = "~> v1.11.3"
}
