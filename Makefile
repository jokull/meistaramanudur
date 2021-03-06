BUCKET = meistaramanudur

bootstrap:
	npm install
	bower install
	virtualenv venv
	venv/bin/pip install -r dev-requirements.txt

upload:
	honcho run ssstatic -c public/ $(BUCKET)/web/ > .static-md5

deploy: upload
	git push -f heroku master
	heroku config:add STATIC_URL=`cat .static-md5`
	rm .static-md5
