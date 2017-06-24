service "quickstart.nc.http" {
  connector = {
    id = "local",
    command = {
      "nc",
      "--listen",
      "--keep-open",
      "--sh-exec",
      "echo -e \"HTTP/1.1 200 OK\\r\\n\\r\\nHello!!!\""
    }
  }
}
