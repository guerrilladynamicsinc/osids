docker run -d -p 9000:9000 -v /docker/gotify-webhook:/etc/webhook --name=gotify-webhook \
  almir/webhook -verbose -hooks=/etc/webhook/gotify.hooks -hotreload
echo "then install this"
cat install.txt
