# collection_files=$COLLECTION_FILES
env_file_default=$ENV_DEFAULT_FILE
count=1
status_all=0

# for file in $collection_files
# Read file in postman folder
for file in ./collections/*.postman_collection.json
do
  tmp="$(basename -- $file)"
  filename=${tmp//'.postman_collection.json'/''}
  data_file="./data/$filename.postman_data.json"
  env_file="./environments/$filename.postman_environment.json"

  if [ -e $data_file ]; then
    # ถ้ามี Data File จะใช้ ENV ตัวไหน
    if [ -e $env_file ]; then
      # ENV ใหม่
      newman run $file -e $env_file -d $data_file --working-dir ./files \
        -k -r htmlextra,cli,junit \
        --env-var "HOST=$BASE_URL_API"\
        --reporter-htmlextra-export="reports/report_$count.html" \
        --reporter-junit-export="reports/junitReport_$count.xml"
    else
      # ENV Default
      newman run $file -e $env_file_default -d $data_file --working-dir ./files \
        -k -r htmlextra,cli,junit \
        --env-var "HOST=$BASE_URL_API" \
        --reporter-htmlextra-export="reports/report_$count.html" \
        --reporter-junit-export="reports/junitReport_$count.xml"
    fi
  else
    # ถ้าไม่มี Data File จะใช้ ENV ตัวไหน
    if [ -e $env_file ]; then
      # ENV ใหม่
      newman run $file -e $env_file --working-dir ./files \
        -k -r htmlextra,cli,junit \
        --env-var "HOST=$BASE_URL_API" \
        --reporter-htmlextra-export="reports/report_$count.html" \
        --reporter-junit-export="reports/junitReport_$count.xml"
    else
      # ENV Default
      newman run $file -e $env_file_default --working-dir ./files \
        -k -r htmlextra,cli,junit \
        --env-var "HOST=$BASE_URL_API" \
        --reporter-htmlextra-export="reports/report_$count.html" \
        --reporter-junit-export="reports/junitReport_$count.xml"
    fi
  fi

  status=$?
  if [ $status -eq 1 ]
  then
    status_all=1
  fi
  count=$(( $count + 1 ))
done
chmod -R o+rwx ./reports
exit $status_all
