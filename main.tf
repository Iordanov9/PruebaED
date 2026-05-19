terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

provider "local" {}
provider "null" {}

resource "local_file" "pagina" {
  filename = "${path.module}/index.html"

  content = <<EOT
<!DOCTYPE html>
<html>
<head>
    <title>Terraform Demo</title>
</head>
<body style="font-family: Arial; text-align:center; margin-top:100px;">
    <h1>Despliegue realizado con Terraform</h1>
    <p>Esta página fue creada automáticamente usando infraestructura como código.</p>
</body>
</html>
EOT
}

resource "null_resource" "abrir_navegador" {
  provisioner "local-exec" {
    command = "start index.html"
  }

  depends_on = [local_file.pagina]
}