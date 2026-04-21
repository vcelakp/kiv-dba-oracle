
# Database Applications (KIV/DBA): Docker-based environment and Oracle Database examples for KIV/DBA

This set of scripts starts Oracle XE in Docker and allows you to run individual
SQL examples interactively.

## Prerequisites

1. Docker is installed and running.

2. You have access to Oracle Container Registry.

3. For the licensed image, you must first sign in to Oracle Container Registry
via the web interface, accept the license terms for the relevant repository,
and then run `docker login container-registry.oracle.com`.

## Examples

Examples are primarily stored in the `./examples/` directory.

- Data Dictionary
- Query Optimization
- Hierarchical Queries
- [Oracle Database PL/SQL Examples](examples/04-plsql/README.md)
- [Oracle Object-Relational Database Examples](examples/05-object/README.md)

The interactive menu (`scripts/menu.sh`) also searches for .sql files in the
project root, so that you can place your own examples directly next to
docker-compose.yml as well.


## Usage

### Prepare, start and stop Docker container

File `.env` is already prepared. Still, you can modify it or use its template
(`cp .env.template .env`).

- `scripts/recreate-from-scratch.sh` - prepare Docker image and environment;

- `scripts/start.sh` - starts the container and waits until the database is
  ready;

- `scripts/stop.sh` - stops the container;

- `scripts/reset.sh` - removes both the container and the data volume.

  ```bash
  ./scripts/reset.sh/
  ```

### Work with SQL examples

- First, you have to start the container (`scripts/start.sh`).

  ```bash
  ./scripts/start.sh
  ```

- Next, you can use examples:

  - `scripts/sql.sh` - opens an interactive SQL\*Plus session for prepared and
    even your own examples;

    ```bash
    ./scripts/sql.sh
    ```

  - `scripts/menu.sh` - interactive selection of .sql examples;

    ```bash
    ./scripts/menu.sh
    ```

  - `scripts/run-example.sh` - runs one specific .sql file (by its path and
    name);

    ```bash
    ./scripts/run-example.sh examples/00_hello-world-demo.sql
    ```

- `scripts/stop.sh` - stops the container;

  ```bash
  ./scripts/stop.sh
  ```

## Notes

- The default image is `container-registry.oracle.com/database/express:latest`;
  you can change it in `.env`.

- The default PDB for Oracle XE 21c is XEPDB1.

- If you want a clean database from scratch, run `./scripts/reset.sh` and then
  `./scripts/start.sh` again.

- If you want stop and remove existing stack and start from the scratch, you
  can use prepared `scripts/recreate-from-scratch.sh`.

- Default training/student user is auto-created when the database is
  initialised for the first time by calling
  `db-setup/01-create-example-user.sh`.
