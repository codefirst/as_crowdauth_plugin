as\_crowdauth\_plugin
===================

A authentication plugin using Atlassian Crowd for AsakusaSatellite.

Setup
----------------

1. Edit <AS_ROOT>/config/settings.yml

        omniauth:
          provider: "crowd"
          provider_args:
            crowd_server_url: http://crowd.host/path
            application_name: "crowd username"
            application_password: "crowd password"

2. Restart AsakusaSatellite

3. Click 'Login' link and input your name and password.
