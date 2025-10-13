require 'rails_helper'

RSpec.describe EventLog, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      log = build(:event_log)
      expect(log).to be_valid
    end

    it "is invalid with invalid attributes" do
      log = build(:event_log, action: nil)
      expect(log).not_to be_valid
    end

    describe "associations" do
      it "belongs to a loggable" do
        developer = create(:game_developer)
        log = build(:event_log, loggable: developer)
        expect(log.loggable).to eq(developer)
      end

      it "optionally belongs to a game_developer" do
        log = build(:event_log, game_developer: nil)
        expect(log.game_developer).to be_nil
      end
    end

    describe "formatted changes" do
      it "formats array values as old/new pairs" do
        log = build(:event_log, changes_data: { "email" => [ "old@example.com", "new@example.com" ] })
        expect(log.formatted_changes).to eq({
          "email" => { old: "old@example.com", new: "new@example.com" }
        })
      end

      it "wraps single values under value key" do
        log = build(:event_log, changes_data: { "email" => "old@example.com" })
        expect(log.formatted_changes).to eq({ "email" => "old@example.com" })
      end
    end
  end
end
