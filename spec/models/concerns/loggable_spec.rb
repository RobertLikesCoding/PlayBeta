require "rails_helper"

RSpec.describe Loggable do
  before do
    stub_const("DummyModel", Class.new(ApplicationRecord) do
      self.table_name = "game_developers"
      include Loggable
    end)
  end

  let(:instance) { DummyModel.create!(studio_name: "Test Dev") }

  it "logs an error when EventLog.create! fails" do
    allow(EventLog).to receive(:create!).and_raise(StandardError.new("boom"))
    allow(Rails.logger).to receive(:error)
    instance.send(:create_event_log, "create", { test: true })
  end
end
