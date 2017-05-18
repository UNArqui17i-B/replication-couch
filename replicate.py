import os
import httplib
import json

def replication():
    # set environmental variables
    target_url = os.environ['TARGET_URL']
    target_port = os.environ['TARGET_PORT']
    target_uri = target_url + ':' + target_port
    host_url = os.environ['HOST_URL']
    host_port = os.environ['HOST_PORT']
    host_uri = host_url + ':' + host_port
    db_name = os.environ['DB_NAME']

    # create database
    conn = httplib.HTTPConnection(host_uri)
    conn.request('PUT', '/' + db_name)
    response = conn.getresponse()
    status = response.status
    if (status < 300) and (status >= 200):
        print 'Database created'
    else:
        print 'Database error:', status, response.read()
        return 1
    conn.close()

    # create _replicator
    conn = httplib.HTTPConnection(host_uri)
    conn.request('PUT', '/_replicator')
    response = conn.getresponse()
    status = response.status
    if (status < 300) and (status >= 200):
        print 'Replicator created'
    else:
        print 'Replicator error:', status, response.read()
        return 1
    conn.close()

    # connect _replicator
    conn = httplib.HTTPConnection(host_uri)
    body = {
        '_id': host_url + '-to-' + target_url,
        'source': host_uri + '/' + db_name,
        'target': target_uri + '/' + db_name,
        'create_target': True,
        'continuous': True
    }
    headers = {
        'Content-type': 'application/json',
        'Accept': 'text/plain'
    }
    conn.request('POST', '/_replicator', json.dumps(body), headers)
    response = conn.getresponse()
    status = response.status
    if (status < 300) and (status >= 200):
        print 'Replication configured'
    else:
        print 'Replication error:', status, response.read()
        return 1
    conn.close()
    return 0

if __name__ == "__main__":
    replication()