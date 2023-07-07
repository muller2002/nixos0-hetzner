{ config, pkgs, ... }:
{
  services.keycloak = {
    enable = true;
    settings.http-port = 8081;
    settings.https-port = 8443;
    database.passwordFile = "/etc/nixos/db_password";
    settings.hostname ="auth.upb.social";
  };

}
