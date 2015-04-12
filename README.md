Netcomm NB604N - Line Speed Tracker
===================================

This will scrape the upstream and downstream line speeds from the status page
of the routers web interface and graph them over time.

There are two parts:

1. Dump the data to disk
2. Present the data in a graph on a web page


Dumping the data
----------------

The `export_data.sh` script will curl the routers web interface and report the
line speeds in CSV. This script is designed to run in a cronjob, for example:

```
* * * * * /opt/line_speed/export_data.sh >> /opt/line_speed/www/data.csv
```


Displaying a graph
------------------

This page makes use of CanvasJS (for the graph) and Zepto (for AJAX).  
The graph uses AJAX to fetch the CSV data every minute, so this CSV needs to be
served on the same webserver (not `file://`).

Here is a quick simple way of serving these files:

```
cd /opt/line_speed/www
nohup python -m SimpleHTTPServer &
```

I am running this from my OSMC on a Raspberry Pi, which has Python
pre-installed. I did however need to install cron.


Risks
-----

Be aware that the `curl` command has a plaintext username and password!  
I have opted to configure the `user` user (instead of the `admin` user) for
this task to mitigate the risk of disclosure.  
This user can be configured in the Netcomm NB604N under
'Management' > 'Access Control' > 'Passwords'.

The crontab above is dumping data every minute, this is useful while I am
debugging, but if this were to run indefinitely it may consume more disk space
on the small memory card of the Raspberry Pi than it needs to.  
Alternatives are to just run it every hour or only when debugging problems.

Python's `SimpleHTTPServer` is not designed for performance, security, etc. but
serves its purpose here.  
If this interface were made public on the internet, I would consider using
Apache or Nginx instead.
