# Planning Referral System

[![Build
Status](https://travis-ci.org/parksandwildlife/prs.svg?branch=master)](https://travis-ci.org/parksandwildlife/prs)
[![Coverage
Status](https://coveralls.io/repos/github/parksandwildlife/prs/badge.svg?branch=master)](https://coveralls.io/github/parksandwildlife/prs?branch=master)

This project consists of a redesign and reorganisation of the [Planning
Referral System](https://confluence.dec.wa.gov.au/display/prs/Home)
corporate application.

# Installation

Create a new virtualenv and install required libraries using `pip`:

    pip install -r requirements.txt

# Environment variables

This project uses confy to set environment variables (in a `.env` file).
The following variables are required for the project to run:

    DATABASE_URL="postgis://USER:PASSWORD@HOST:PORT/DATABASE_NAME"
    SECRET_KEY="ThisIsASecretKey"

Variables below may also need to be defined (context-dependent):

    DEBUG=True
    CSRF_COOKIE_SECURE=False
    SESSION_COOKIE_SECURE=False
    EMAIL_HOST="email.host"
    EMAIL_PORT=25
    SITE_URL="prs.dpaw.wa.gov.au"
    GEOSERVER_WMS_URL="//kmi.dpaw.wa.gov.au/geoserver/gwc/service/wms"
    GEOSERVER_WFS_URL="//kmi.dpaw.wa.gov.au/geoserver/ows"
    PRS_USER_GROUP="PRS user"
    PRS_PWUSER_GROUP="PRS power user"
    BORGCOLLECTOR_API="https://borg.dpaw.wa.gov.au/api/"
    SSO_COOKIE_NAME="oim_dpaw_wa_gov_au_sessionid"
    # debug-toolbar settings:
    INTERNAL_IP="x.x.x.x"

# Running

Use `runserver` to run a local copy of the application:

    python manage.py runserver [::]:8080

Run console commands manually:

    python manage.py shell_plus

# Testing

Run unit tests for the *referral* app as follows:

    python manage.py test referral -k -v2

To run tests for e.g. models only:

    python manage.py test referral.test_models -k -v2

To obtain coverage reports:

    coverage run --source='.' manage.py test -k -v2
    coverage report -m

Fabric scripts are also available to run tests:

    fab test
    fab test_coverage
