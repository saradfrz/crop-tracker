# Postgres on WSL

## Install postgres



To install PostgreSQL on WSL (ie. Ubuntu):

Open your WSL terminal (ie. Ubuntu).
Update your Ubuntu packages: sudo apt update
Once the packages have updated, install PostgreSQL (and the -contrib package which has some helpful utilities) with: sudo apt install postgresql postgresql-contrib
Confirm installation and get the version number: psql --version
There are 3 commands you need to know once PostgreSQL is installed:

sudo service postgresql status for checking the status of your database.
sudo service postgresql start to start running your database.
sudo service postgresql stop to stop running your database.
The default admin user, postgres, needs a password assigned in order to connect to a database. To set a password:

Enter the command: sudo passwd postgres
You will get a prompt to enter your new password.
Close and reopen your terminal.
To run PostgreSQL with psql shell:

## psql

Start your postgres service: 
`sudo service postgresql start`
Connect to the postgres service and open the psql shell: `sudo -u postgres psql`
Once you have successfully entered the psql shell, you will see your command line change to look like this: postgres=#

 Note

Alternatively, you can open the psql shell by switching to the postgres user with: su - postgres and then entering the command: psql.

To exit postgres=# enter: \q or use the shortcut key: Ctrl+D

To see what user accounts have been created on your PostgreSQL installation, use from your WSL terminal: psql --command="\du" ...or just \du if you have the psql shell open. This command will display columns: Account User Name, List of Roles Attributes, and Member of role group(s). To exit back to the command line, enter: q.

For more about working with PostgreSQL databases, see the PostgreSQL docs.

To work with with PostgreSQL databases in VS Code, try the PostgreSQL extension.


## Setting up a PostgreSQL Database for Airflow

You need to create a database and a database user that Airflow will use to access this database. In the example below, a database airflow_db and user with username airflow_user with password airflow_pass will be created

```bash
CREATE DATABASE airflow_db;
CREATE USER airflow WITH PASSWORD 'radioactive';
GRANT ALL PRIVILEGES ON DATABASE airflow_db TO airflow;
-- PostgreSQL 15 requires additional privileges:
USE airflow_db;
GRANT ALL ON SCHEMA public TO airflow;
```

Note
The database must use a UTF-8 character set

You may need to update your Postgres pg_hba.conf to add the airflow user to the database access control list; and to reload the database configuration to load your change. See The pg_hba.conf File in the Postgres documentation to learn more.

Warning

When you use SQLAlchemy 1.4.0+, you need to use postgresql:// as the database in the sql_alchemy_conn. In the previous versions of SQLAlchemy it was possible to use postgres://, but using it in SQLAlchemy 1.4.0+ results in:

>       raise exc.NoSuchModuleError(
            "Can't load plugin: %s:%s" % (self.group, name)
        )
E       sqlalchemy.exc.NoSuchModuleError: Can't load plugin: sqlalchemy.dialects:postgres
If you cannot change the prefix of your URL immediately, Airflow continues to work with SQLAlchemy 1.3 and you can downgrade SQLAlchemy, but we recommend to update the prefix.

Details in the SQLAlchemy Changelog.

We recommend using the psycopg2 driver and specifying it in your SqlAlchemy connection string.

postgresql+psycopg2://<user>:<password>@<host>/<db>
Also note that since SqlAlchemy does not expose a way to target a specific schema in the database URI, you need to ensure schema public is in your Postgres user’s search_path.

If you created a new Postgres account for Airflow:

The default search_path for new Postgres user is: "$user", public, no change is needed.

If you use a current Postgres user with custom search_path, search_path can be changed by the command:

ALTER USER airflow_user SET search_path = public;
For more information regarding setup of the PostgreSQL connection, see PostgreSQL dialect in SQLAlchemy documentation.

Note

Airflow is known - especially in high-performance setup - to open many connections to metadata database. This might cause problems for Postgres resource usage, because in Postgres, each connection creates a new process and it makes Postgres resource-hungry when a lot of connections are opened. Therefore we recommend to use PGBouncer as database proxy for all Postgres production installations. PGBouncer can handle connection pooling from multiple components, but also in case you have remote database with potentially unstable connectivity, it will make your DB connectivity much more resilient to temporary network problems. Example implementation of PGBouncer deployment can be found in the Helm Chart for Apache Airflow where you can enable pre-configured PGBouncer instance with flipping a boolean flag. You can take a look at the approach we have taken there and use it as an inspiration, when you prepare your own Deployment, even if you do not use the Official Helm Chart.

See also Helm Chart production guide

Note

For managed Postgres such as Azure Postgresql, CloudSQL, Amazon RDS, you should use keepalives_idle in the connection parameters and set it to less than the idle time because those services will close idle connections after some time of inactivity (typically 300 seconds), which results with error The error: psycopg2.operationalerror: SSL SYSCALL error: EOF detected. The keepalive settings can be changed via sql_alchemy_connect_args configuration parameter Configuration Reference in [database] section. You can configure the args for example in your local_settings.py and the sql_alchemy_connect_args should be a full import path to the dictionary that stores the configuration parameters. You can read about Postgres Keepalives. An example setup for keepalives that has been observed to fix the problem might be:

keepalive_kwargs = {
    "keepalives": 1,
    "keepalives_idle": 30,
    "keepalives_interval": 5,
    "keepalives_count": 5,
}
Then, if it were placed in airflow_local_settings.py, the config import path would be:

sql_alchemy_connect_args = airflow_local_settings.keepalive_kwargs