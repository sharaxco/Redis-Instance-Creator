# Redis Instance Creator Script

This bash script can be used to quickly set up new Redis instances with custom configurations. This is particularly useful for creating separate Redis instances for different applications or environments.

## Prerequisites

- Redis stack should be installed in the `/opt/redis-stack/` directory.
- The script needs to be run with `sudo` or as the root user because it creates files in `/etc` and manipulates system services.

## Usage

1. Make the script executable:

    ```bash
    chmod +x create_redis_instance.sh
    ```

2. Run the script with four parameters:

    ```bash
    sudo ./create_redis_instance.sh name dir port password
    ```

    - `name`: The name of the Redis instance.
    - `dir`: The directory where the Redis instance's data should be stored.
    - `port`: The port on which the Redis instance should listen.
    - `password`: The password for the Redis instance.

    For example, to create a new Redis instance named `myinstance` with its data stored in `/var/lib/redis-stack/myinstance`, listening on port `6380`, and secured with the password `mysecretpassword`, you would run:

    ```bash
    sudo ./create_redis_instance.sh myinstance /var/lib/redis-stack 6380 mysecretpassword
    ```

This will create a new Redis instance with its own configuration and systemd service file. The new service will be set to start at boot and will be started immediately.

## Note

Please test this script in a safe environment before using it in production. Modify it as needed to suit your specific use case.
