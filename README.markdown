as\_crowdauth\_plugin
===================

A authentication plugin using Atlassian Crowd.

Setup
----------------

1. Edit <AS_ROOT>/config/settings.yml

        login_link : "crowdauth"
        login_link_redmine: http://crowd.host/path
        login_link_basic_username: "crowd username"
        login_link_basic_password: "crowd password"

2. Restart AsakusaSatellite

3. Click 'Login' link and input your name and password.
