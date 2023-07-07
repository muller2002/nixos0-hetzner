{ config, pkgs, ... }:
let domain = "headscale.marlena.app";
in {
  services = {
    headscale = {
      enable = true;
      address = "0.0.0.0";
      port = 8888;
      serverUrl = "https://${domain}";
      dns = { baseDomain = "headscale.marlena.app"; };
      settings = { logtail.enabled = false; };
    };

    nginx.virtualHosts.${domain} = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass =
          "http://localhost:${toString config.services.headscale.port}";
        proxyWebsockets = true;
      };
    };
  };

  environment.systemPackages = [ config.services.headscale.package ];
  services.tailscale.enable = true;
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
