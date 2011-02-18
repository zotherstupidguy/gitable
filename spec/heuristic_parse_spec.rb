require 'spec_helper'

describe Gitable::URI, ".heuristic_parse" do
  it "returns a Gitable::URI" do
    uri = "http://github.com/martinemde/gitable"
    Gitable::URI.heuristic_parse(uri).should be_a_kind_of(Gitable::URI)
  end

  [
    "http://host.xz/path/to/repo.git/",
    "http://host.xz/path/to/repo.git",
    "ssh://user@host.xz/path/to/repo.git/",
    "ssh://user@host.xz:1234/path/to/repo.git/",
    "user@host.xz:path/to/repo.git",
    "user@host.xz:path/to/repo.git/",
    "git@github.com:martinemde/gitable.git",
  ].each do |uri|
    it "doesn't break the already valid URI: #{uri.inspect}" do
      Gitable::URI.heuristic_parse(uri).to_s.should == uri
    end
  end

  it "guesses https://github.com/martinemde/gitable.git if I pass in the url bar" do
    uri = "https://github.com/martinemde/gitable"
    gitable = Gitable::URI.heuristic_parse(uri)
    gitable.to_s.should == "https://github.com/martinemde/gitable.git"
  end

  it "isn't upset by trailing slashes" do
    uri = "https://github.com/martinemde/gitable/"
    gitable = Gitable::URI.heuristic_parse(uri)
    gitable.to_s.should == "https://github.com/martinemde/gitable.git/"
  end
end
