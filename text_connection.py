import psycopg2

# Connection parameters
dbname = "airflow_db"
user = "airflow"
password = "radioactive"  # Replace with your actual password
host = "localhost"  # Replace with your host if it's not localhost
port = "5432"  # Replace with your port if it's not the default PostgreSQL port

try:
    # Connect to the PostgreSQL server
    conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)

    # Create a cursor object using the connection
    cursor = conn.cursor()

    # Execute a sample query
    cursor.execute("SELECT version();")

    # Fetch the result
    version = cursor.fetchone()
    print("PostgreSQL version:", version)

    # Close communication with the PostgreSQL database server
    cursor.close()

except (Exception, psycopg2.DatabaseError) as error:
    print(error)

finally:
    # Close the database connection
    if conn is not None:
        conn.close()
