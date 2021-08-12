.PHONY: \
	clean \
	submissions \
	tests \
	fit_dateros

clean:
	rm --force pollos_petrel/evaro_submission.csv

submissions: \
	pollos_petrel/dateros_submission.csv \
	pollos_petrel/evaro_submission.csv \
	pollos_petrel/example_submission.csv \
	pollos_petrel/los_papuchos_de_nezayork_submission.csv

pollos_petrel/dateros_submission.csv:
	@echo "Creating iztapalacra's submission file..."
	Rscript src/dateros/fit_model.R

pollos_petrel/evaro_submission.csv: src/evaro/get_submission.sh
	@echo "Creating Évaro's submission file..."
	src/evaro/get_submission.sh > $@

pollos_petrel/evaro2_submission.csv: src/evaro/get_submission.gp pollos_petrel/train2.csv
	@echo "Creating Évaro's submission file..."
	src/evaro/get_submission.gp > $@

pollos_petrel/train2.csv: src/evaro/get_training_data_subset.sh
	src/evaro/get_training_data_subset.sh > $@

pollos_petrel/example_submission.csv:
	@echo "Creating example submission file..."
	touch pollos_petrel/example_submission.csv

tests:
	R -e "testthat::test_dir('tests/testthat/', report = 'summary', stop_on_failure = TRUE)"

pollos_petrel/los_papuchos_de_nezayork_submission.csv:
	@echo "Creating 'los papuchos de nezayork' submission file..."
	mv pollos_petrel/example2_submission.csv pollos_petrel/los_papuchos_de_nezayork_submission.csv
