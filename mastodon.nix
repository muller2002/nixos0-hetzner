{ config, pkgs, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme_letsencrypt@marlena.app";
  };
  services.mastodon = {
    enable = true;
    localDomain = "dev2.upb.social"; # Replace with your own domain
    configureNginx = true;
    smtp.fromAddress = ""; # Email address used by Mastodon to send emails, replace with your own
    extraConfig = {
OIDC_ENABLED="true";
OIDC_DISPLAY_NAME="Uni Paderborn Account";
OIDC_ISSUER="https://gitlab.com";
OIDC_DISCOVERY="true";
OIDC_SCOPE="openid,profile,email";
OIDC_UID_FIELD="preferred_username";
# UNI GIT
#OIDC_CLIENT_ID="f25f47d554c1186ce242ebdfa18061c68e4e33bc26fd0f12519a87ea07edad23";
#OIDC_CLIENT_SECRET="c463a0328ddb72431a39fb78593c8f2e3f1e04cf1eb406593cc6ca3570b0d92a";

# GITLAB
OIDC_CLIENT_ID = "bf069b360595628cf8404a79f90da6ee29f7628e054ff6292b226698b28eb1f1";
OIDC_CLIENT_SECERT = "aedb7e5b1587279f8fdb92551f99f1e3f3263ee09907026a405cdc2bbb143e77";
OIDC_REDIRECT_URI="https://dev2.upb.social/auth/auth/openid_connect/callback";
OMNIAUTH_ONLY="true";
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
