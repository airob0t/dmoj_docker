#docker run --name=dmoj_site --link=dao_dmojdb_1:dbhost -p 80:80 -t -i -d airobot/dmoj /bin/bash
docker run --name=dmoj_site -p 80:80 -p 9999:9999 -p 9998:9998 -p 15100:15100 -p 15101:15101 -p 15102:15102 -t -i -d airobot/dmoj /bin/bash
