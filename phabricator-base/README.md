# Phabricator daemons

This image will run the phabricator daemons.

## Extra info

Phabricator's daemons are not supposed to run on the foreground. The only
supported way to have them running in the foreground is to use the debug mode,
which causes _a lot_ of text to be emmited. There is no way at all, using the
current available facilities, to have daemons on the foreground.

For the record, what phabricator does to run the daemons as of 2015-08-07 is:

    PHAB_ROOT/scripts/daemon/phd-daemon < temp_file

Where `temp_file` is a temporary file with the configuration for the daemons,
which is basically:

    {
        "daemonize": true,
        "daemons": [
            {
                "class": "PhabricatorRepositoryPullLocalDaemon"
            },
            {
                "class": "PhabricatorTriggerDaemon"
            },
            {
                "autoscale": {
                    "group": "task",
                    "pool": 4,
                    "reserve": 0
                },
                "class": "PhabricatorTaskmasterDaemon"
            }
        ],
        "log": "/var/tmp/phd/log/daemons.log",
        "piddir": "/var/tmp/phd/pid"
    }

If `daemonize` is set to `false`, the daemons are kept on the foreground. But
there is no way to change that alone via the command line without modifying
Phabricator's code :)
