## Running tests locally
Running tests locally requires memcached and postgis to be running on the system, and for postgis to have a database called ```test_tilestache``` which has the postgis extension enabled.

To ease setting up these services we have provided a docker-compose to bring these services up. You should be able to launch these services by running from the ```tests``` directory:

```sh
docker-compose up
```

Once complete, from the root directory, you can run:
```sh 
pip install -r requirements-dev.txt
nosetests -v --with-coverage --cover-package TileStache
```

To ensure the tests pass,  and:

```sh
tox
```

To ensure the tests pass in the expected python runtime environments.

**Note** For the tests to be able to connect to the database the docker-compose file will mount the host system's ```/var/run/postgresql``` directory into the container. You must ensure this directory exists on your system for the tests to run successfully. 
