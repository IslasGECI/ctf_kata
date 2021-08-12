.PHONY: \
	clean \
	submissions \
	tests \
	fit_dateros

clean:
	rm --force *.txt
	rm --force fit*.log
	rm --force pollos_petrel/dateros_submission.csv
	rm --force pollos_petrel/evaro_submission.csv
	rm --force pollos_petrel/evaro2_submission.csv
	rm --force pollos_petrel/evaro3_submission.csv
	rm --force pollos_petrel/evaro4_submission.csv
	rm --force pollos_petrel/test2.csv
	rm --force pollos_petrel/test3.csv
	rm --force pollos_petrel/test4.csv
	rm --force pollos_petrel/tmp_submission.csv
	rm --force pollos_petrel/train2.csv
	rm --force pollos_petrel/train4.csv

submissions: \
	pollos_petrel/dateros_submission.csv \
	pollos_petrel/evaro_submission.csv \
	pollos_petrel/evaro2_submission.csv \
	pollos_petrel/evaro3_submission.csv \
	pollos_petrel/evaro4_submission.csv \
	pollos_petrel/example_submission.csv \
	pollos_petrel/los_papuchos_de_nezayork_submission.csv

pollos_petrel/dateros_submission.csv:
	@echo "Creating iztapalacra's submission file..."
	Rscript src/dateros/fit_model.R

pollos_petrel/evaro_submission.csv: src/evaro/get_submission.sh
	@echo "Creating Évaro's submission file..."
	src/evaro/get_submission.sh > $@

pollos_petrel/evaro2_submission.csv: src/evaro/get_submission2.sh slope.txt intercept.txt
	@echo "Creating Évaro's submission file..."
	src/evaro/get_submission2.sh > $@

pollos_petrel/evaro3_submission.csv: src/evaro/get_submission3.sh slope.txt intercept.txt
	@echo "Creating Évaro's submission file..."
	src/evaro/get_submission3.sh > $@

pollos_petrel/evaro4_submission.csv: src/evaro/get_submission4.sh a.txt b.txt c.txt
	@echo "Creating Évaro's submission file..."
	src/evaro/get_submission4.sh > $@

slope.txt intercept.txt: src/evaro/get_model_parameters.sh fit.log
	src/evaro/get_model_parameters.sh

a.txt b.txt c.txt: src/evaro/get_model_parameters4.sh fit4.log
	src/evaro/get_model_parameters4.sh

fit.log: src/evaro/fit_model.gp pollos_petrel/train2.csv
	src/evaro/fit_model.gp

fit4.log: src/evaro/fit_model4.gp pollos_petrel/train4.csv
	src/evaro/fit_model4.gp

pollos_petrel/train2.csv: src/evaro/get_training_data_subset.sh
	src/evaro/get_training_data_subset.sh > $@

pollos_petrel/train4.csv: src/evaro/get_training_data_subset4.sh
	src/evaro/get_training_data_subset4.sh > $@

pollos_petrel/example_submission.csv:
	@echo "Creating example submission file..."
	touch pollos_petrel/example_submission.csv

tests:
	R -e "testthat::test_dir('tests/testthat/', report = 'summary', stop_on_failure = TRUE)"

pollos_petrel/los_papuchos_de_nezayork_submission.csv:
	@echo "Creating 'los papuchos de nezayork' submission file..."
	python src/the_ultimate_regressor_3000.py \
		--input pollos_petrel/train.csv \
		--input pollos_petrel/test.csv \
		--output pollos_petrel/los_papuchos_de_nezayork_submission.csv
