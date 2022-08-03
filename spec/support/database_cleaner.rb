RSpec.configure do |config|
  config.before(:suite) do
    # If you’re using Active Record, the except statement is essential.
    # Without it, the database_cleaner will destroy Active Record’s environment data,
    # resulting in a NoEnvironmentInSchemaError every time your tests run.
    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
  end

  config.before(:each) do
    # Every test will create a database transaction that will simply be rolled back when it ends, as if it never happened.
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end