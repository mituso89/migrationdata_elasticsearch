MONGODB1=mongo

echo "**********************************************" ${MONGODB1}
echo "Waiting for startup.."
sleep 30
echo "done"

echo SETUP.sh time now: $(date +"%T")
mongo --host ${MONGODB1}:27017 -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} <<EOF


conf = {
    "_id": "replica-setup",
    "protocolVersion": 1,
    "version": 1,
    "members": [
        {
            "_id": 0,
            "host": "${MONGODB1}:27017",
            "priority": 2
        }
    ]
}

rs.initiate(conf)

cfg = rs.conf()
cfg.members[0] = {
            "_id": 0,
            "host": "${MONGODB1}:27017",
            "priority": 2
        }


rs.reconfig(cfg, {force : true})
rs.secondaryOk();
db.getMongo().setReadPref('primary');
rs.status();
EOF
