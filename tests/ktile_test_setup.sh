#!/bin/sh

set -e

psql -U postgres -c "DROP DATABASE IF EXISTS test_tilestache"
psql -U postgres -c "CREATE DATABASE test_tilestache"
psql -U postgres -c "CREATE EXTENSION postgis" -d test_tilestache
