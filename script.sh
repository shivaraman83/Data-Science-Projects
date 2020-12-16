build_num=2
rm -rf build/ dist/ FaceRecognition.egg-info/
sed -ie "s/0/$build_num/g" setup.py
jfrog rt pipi -r requirements.txt --build-name=facerecognition-python --build-number=$build_num --module=FaceRecognition --no-cache-dir --force-reinstall
python setup.py sdist bdist_wheel
jfrog rt u dist/ pypi/ --build-name=facerecognition-python --build-number=$build_num --module=FaceRecognition --props=stage=dev
jfrog rt bag facerecognition-python $build_num /Users/shanil/Documents/Github/SolEngDemo/ --config issuesCollectionConfig.json
jfrog rt bce facerecognition-python $build_num
jfrog rt bp facerecognition-python $build_num
jfrog rt bprfacerecognition-python $build_num pypi-prod-local --status=Released --comment="Promoting Python Build" --props=stage=prod
jfrog rt bs facerecognition-python $build_num
sed -ie "s/$build_num/0/g" setup.py
