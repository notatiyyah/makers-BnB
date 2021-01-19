require "database_connection"

describe DatabaseConnection do

  it "chooses test environment" do
    ENV["ENVIRONMENT"] = "testing"
    DatabaseConnection.connect
    expect(DatabaseConnection.db).to eq "makers_bnb_testing"
  end

  it "chooses main environment" do
    ENV["ENVIRONMENT"] = "main"
    DatabaseConnection.connect
    expect(DatabaseConnection.db).to eq "makers_bnb"
  end

  it "takes a query" do
    ENV["ENVIRONMENT"] = "testing"
    DatabaseConnection.connect
    results = DatabaseConnection.query("SELECT * FROM bookings")
    expect(results.ntuples).to eq 0
  end

end