docker run --name=dmoj_site --link=dao_dmojdb_1:dbhost -p 80:80 -t -i -d airobot/dmoj /bin/bash
