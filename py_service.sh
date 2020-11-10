# chkconfig: 345 85 15

[Unit]
Description=pysetenv Service
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/local/bin/pysetenv

[Install]
WantedBy=multi-user.target