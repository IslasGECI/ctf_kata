.PHONY: \
	clean \
	submissions \
	tests

clean:
	rm --force pollos_petrel/evaro_submission.csv

submissions: \
	pollos_petrel/dateros_submission.csv \
	pollos_petrel/evaro_submission.csv \
	pollos_petrel/example_submission.csv

pollos_petrel/dateros_submission.csv:
	@echo "Creating iztapalacra's submission file..."
	cp pollos_petrel/example2_submission.csv pollos_petrel/dateros_submission.csv

pollos_petrel/evaro_submission.csv:
	@echo "Creating Évaro's submission file..."
	mv pollos_petrel/example2_submission.csv pollos_petrel/evaro_submission.csv

pollos_petrel/example_submission.csv:
	@echo "Creating example submission file..."
	touch pollos_petrel/example_submission.csv

tests:
	R -e "testthat::test_dir('tests/testthat/', report = 'summary', stop_on_failure = TRUE)"
